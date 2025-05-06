model fcLoadSplitter

  Modelica.Blocks.Interfaces.RealOutput fcLoad annotation(
    Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput batLoad annotation(
    Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  parameter Real taxiRamp = 600;
  parameter Real taxiTime = 600;
  parameter Real taxiP = 0.1*maxP;
  parameter Real maxRamp = 30;
  parameter Real maxTime = 90;
  parameter Real maxP = 65000;
  parameter Real cruiseTime;
  parameter Real cruiseP = 0.75*maxP;
  parameter Real chargeCurrent;
  parameter Real batV = 366 "Parameter used as workaround for apparent Modelica bug";
  
  Real SOC;
  Real now;
  Real totLoad;
  Boolean flight(start=true);
  Real startFlight(start=0);
  Real t(start=0);
  Real endFlight(start=2*taxiRamp+2*taxiTime+4*maxRamp+2*maxTime+cruiseTime);
  Real fcV;

algorithm
  now := time;

  when time<=endFlight then
    flight := true;
  elsewhen time>endFlight then
    flight := false;
  end when;
  
  if flight then
    if now<t+taxiRamp then
     totLoad := (((taxiP-1e-6)/taxiRamp)*(time-t) + 1e-6);
      fcLoad := (totLoad);
      batLoad := totLoad - fcLoad;
    elseif now<t+taxiRamp+taxiTime then
      totLoad := taxiP;
      fcLoad := (totLoad);
      batLoad := (totLoad - fcLoad);
    elseif now<t+taxiRamp+taxiTime+maxRamp then
      totLoad := (((maxP-taxiP)/maxRamp)*(time-(t+taxiRamp+taxiTime))+taxiP);
      fcLoad := (((cruiseP-taxiP)/(2*maxRamp+maxTime))*(time-(t+taxiRamp+taxiTime))+taxiP);
      batLoad := totLoad - fcLoad;
    elseif now<t+taxiRamp+taxiTime+maxRamp+maxTime then
      totLoad := maxP;
      fcLoad := (((cruiseP-taxiP)/(2*maxRamp+maxTime))*(time-(t+taxiRamp+taxiTime))+taxiP);
     batLoad := totLoad - fcLoad;
    elseif now<t+taxiRamp+taxiTime+2*maxRamp+maxTime then
      totLoad := (((cruiseP-maxP)/maxRamp)*(time-(t+taxiRamp+taxiTime+maxRamp+maxTime)) + maxP);
      fcLoad := (((cruiseP-taxiP)/(2*maxRamp+maxTime))*(time-(t+taxiRamp+taxiTime))+taxiP);
      batLoad := totLoad - fcLoad;
    elseif now<t+taxiRamp+taxiTime+2*maxRamp+maxTime+cruiseTime then
      totLoad := cruiseP;
      fcLoad := (totLoad);
      batLoad := totLoad - fcLoad;
    elseif now<t+taxiRamp+taxiTime+3*maxRamp+maxTime+cruiseTime then
      totLoad := (((taxiP-cruiseP)/maxRamp)*(time-(t+taxiRamp+taxiTime+2*maxRamp+maxTime+cruiseTime))+cruiseP);
      fcLoad := (((taxiP-cruiseP)/(2*maxRamp+maxTime))*(time-(t+taxiRamp+taxiTime+2*maxRamp+maxTime+cruiseTime))+cruiseP);
      batLoad := totLoad - fcLoad;
    elseif now<t+taxiRamp+taxiTime+3*maxRamp+2*maxTime+cruiseTime then
      totLoad := taxiP;
      fcLoad := (((taxiP-cruiseP)/(2*maxRamp+maxTime))*(time-(t+taxiRamp+taxiTime+2*maxRamp+maxTime+cruiseTime))+cruiseP);
      batLoad := totLoad - fcLoad;
    elseif now<t+taxiRamp+2*taxiTime+4*maxRamp+2*maxTime+cruiseTime then
      totLoad := taxiP;
      fcLoad := (totLoad);
      batLoad := totLoad - fcLoad;
    //else
      //totLoad := ((((1e-6)-taxiP)/taxiRamp)*(time-(t+taxiRamp+2*taxiTime+4*maxRamp+2*maxTime+cruiseTime))+taxiP);
      totLoad := 1e-6;
      //fcLoad := (totLoad);
      fcLoad := 1e-6;
      batLoad := -100*batV;
      //batLoad := totLoad - fcLoad;
    end if;
  else
    totLoad := 1e-6;
    fcLoad := 1e-6;
    batLoad := -100*batV;
  end if;
    totLoad := totLoad/(fcV+batV);
    if(fcLoad < 1) then
      fcLoad := 1e-6;
    else
      fcLoad := fcLoad/(fcV);
    end if;
    batLoad := batLoad/(batV);
  
  when not flight and SOC>=0.9 then
    startFlight := now;
    endFlight := startFlight+(taxiRamp+2*taxiTime+4*maxRamp+2*maxTime+cruiseTime);
    t := now;
    flight:= true;
  end when;
  
  annotation(uses(Modelica(version = "3.2.3")));
end fcLoadSplitter;
