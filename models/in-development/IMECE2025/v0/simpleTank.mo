model simpleTank

  Modelica.Blocks.Interfaces.RealOutput p_fuel annotation(
    Placement(transformation(origin = {106, 72}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {106, 72}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput q_fuel annotation(
    Placement(transformation(origin = {106, -38}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {106, -38}, extent = {{-10, -10}, {10, 10}})));

  parameter Modelica.SIunits.Volume V = 7.36238 "Cylinder volume";
  parameter Modelica.SIunits.Pressure P = 16000000 "Cylinder pressure";
  parameter Modelica.SIunits.Temperature T = 293.15 "Cylinder temperature";
  parameter Real Cv = 0.06 "Regulator flow coefficient";
  parameter Modelica.SIunits.Pressure Preg = 300000 "Regulator outlet pressure";
  
  Real m_fuel;  // mass of gas in tank
  //Boolean refuel (start = true);
  //Real dm; // mass flow rate
  
algorithm
  
initial equation
  m_fuel = (P * V * 0.002016) / (8.314 * T);

equation
  p_fuel = Preg;
  der(m_fuel) = -Cv * (94.8/3600) * (P/(1e5)) * 0.017929907 * sqrt((((P-Preg)/P)*0.002016)/(T * 1));
  q_fuel = (-der(m_fuel) * V)/m_fuel;
  
  annotation(
    uses(Modelica(version = "3.2.3")));
end simpleTank;
