block flightCycle
  parameter Real sigma = 2901.8;
  
  parameter Modelica.SIunits.Time period = 300 + 2*taxiRamp + 2*taxiTime + 3*maxRamp + maxTime +cruiseTime;
  parameter Integer nperiod=-1;
  parameter Real offset = 1e-6;
  parameter Modelica.SIunits.Time startTime = 0;
  
  parameter Modelica.SIunits.Time taxiRamp = 600;
  parameter Modelica.SIunits.Time taxiTime = 600;
  parameter Modelica.SIunits.Power taxiP = 0.1*maxP;
  
  parameter Modelica.SIunits.Time maxRamp = 20;
  parameter Modelica.SIunits.Time maxTime = 60;
  parameter Modelica.SIunits.Power maxP = 65000;
  
  parameter Modelica.SIunits.Time cruiseTime = 3600;
  parameter Modelica.SIunits.Power cruiseP = 0.75*maxP;

  Modelica.SIunits.Power totLoad;
  Modelica.SIunits.Power fcLoad;
  //output Modelica.SIunits.Current fcCurrent;
  Modelica.SIunits.Power batLoad;
  output Boolean refuel(start=false);
  //output Modelica.SIunits.Current batCurrent;
  Modelica.Blocks.Noise.NormalNoise normalNoise(mu = cruiseP, samplePeriod = 1, sigma = sigma)  annotation(
    Placement(visible = true, transformation(origin = {-38, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));protected 
  Modelica.SIunits.Time startFlight;
  Integer count;
  
initial algorithm
  count := integer((time-startTime)/period);
  startFlight := startTime + count*period;

equation
  when integer((time - startTime)/period) > pre(count) then
    count = pre(count) + 1;
    startFlight = time;
  end when;

  if mod(time,period) == 0 then
    refuel = true;
  else
    refuel = false;
  end if;
  
  if (time < startTime or nperiod == 0 or (nperiod > 0 and count >= nperiod)) then 
    totLoad = offset;
    fcLoad = offset;
  elseif time < startFlight + taxiRamp then
    totLoad = (taxiP/taxiRamp)*(time - startFlight) + offset;
    fcLoad = totLoad;
  elseif time < startFlight + taxiRamp + taxiTime then
    totLoad = taxiP+offset;
    fcLoad = totLoad;
  elseif time < startFlight  + taxiRamp + taxiTime + maxRamp then
    totLoad = ((maxP - taxiP)/maxRamp)*(time - (startFlight+taxiRamp+taxiTime))+taxiP+offset;
    fcLoad = ((cruiseP -taxiP)/(2*maxRamp + maxTime))*(time-(startFlight+taxiRamp+taxiTime))+taxiP+offset;
  elseif time < startFlight + taxiRamp + taxiTime + maxRamp + maxTime then
    totLoad = maxP+offset;
    fcLoad = ((cruiseP -taxiP)/(2*maxRamp + maxTime))*(time-(startFlight+taxiRamp+taxiTime))+taxiP+offset;
  elseif time < startFlight + taxiRamp + taxiTime + 2*maxRamp + maxTime then
    totLoad = ((cruiseP-maxP)/maxRamp)*(time - (startFlight + taxiRamp + taxiTime + maxRamp + maxTime)) + maxP + offset;
    fcLoad = ((cruiseP -taxiP)/(2*maxRamp + maxTime))*(time-(startFlight+taxiRamp+taxiTime))+taxiP + offset;
  elseif time < startFlight + taxiRamp + taxiTime + 2*maxRamp + maxTime + cruiseTime then
    totLoad = normalNoise.y+offset;
    fcLoad = cruiseP + offset;
  elseif time < startFlight + taxiRamp + taxiTime + 3*maxRamp + maxTime + cruiseTime then
    totLoad = ((taxiP - cruiseP)/maxTime)*(time - (startFlight + taxiRamp + taxiTime + 2*maxRamp + maxTime + cruiseTime)) + cruiseP + offset;
    fcLoad = ((taxiP - cruiseP)/(2*maxRamp+maxTime))*(time - (startFlight+taxiRamp+taxiTime+2*maxRamp+maxTime+cruiseTime)) + cruiseP + offset;
  elseif time < startFlight+taxiRamp+taxiTime + 4*maxRamp + 2*maxTime + cruiseTime then
    totLoad = taxiP + offset;
    fcLoad = ((taxiP - cruiseP)/(2*maxRamp+maxTime))*(time - (startFlight+taxiRamp+taxiTime+2*maxRamp+maxTime+cruiseTime)) + cruiseP + offset;
  elseif time < startFlight + taxiRamp + 2*taxiTime + 3*maxRamp + maxTime + cruiseTime then
    totLoad = taxiP + offset;
    fcLoad = totLoad;
  elseif time< startFlight + 2*taxiRamp + 2*taxiTime + 3*maxRamp + maxTime + cruiseTime then
    totLoad = (-taxiP/taxiRamp)*(time - (startFlight + taxiRamp + 2*taxiTime + 3*maxRamp + maxTime + cruiseTime)) + taxiP + offset;
    fcLoad = totLoad;
  else
    totLoad = offset;
    fcLoad = offset;
  end if;
  
  if time < startFlight + 2*taxiRamp + 2*taxiTime + 3*maxRamp + maxTime + cruiseTime then
    batLoad = totLoad - fcLoad + 2*offset;
  else
    batLoad = -50000;
  end if;
   
annotation(
    uses(Modelica(version = "3.2.3")));
end flightCycle;