model simpleTank

  Modelica.Blocks.Interfaces.RealOutput p_fuel annotation(
    Placement(transformation(origin = {106, 72}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {106, 72}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput q_fuel annotation(
    Placement(transformation(origin = {106, -38}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {106, -38}, extent = {{-10, -10}, {10, 10}})));


  parameter Modelica.Units.SI.Volume V = 7.36238 "Cylinder volume";
  parameter Modelica.Units.SI.Pressure P "Cylinder pressure";
  parameter Modelica.Units.SI.Temperature T "Cylinder temperature";
  parameter Real Cv = 0.06;
  parameter Modelica.Units.SI.Pressure P_reg;
  parameter Real G = 0.0696 "Specific gravity";
  
  Real m_fuel;

initial equation
  m_fuel = ((P/1e5) * V * 0.002016) / (8.314 * T);

equation
  p_fuel = P_reg;
  //q_fuel = (sqrt(520/(G*T)) * Cg * p_fuel) * sin((59.64 / C1) * sqrt((P - p_fuel) / P))*((0.3048^3)/3600);
  q_fuel = 0.471 * (6.950*60) * Cv * (P/1e5) * sqrt(1/(G*T)); // Cubic m/s
  der(m_fuel) = -q_fuel*(m_fuel/V);

annotation(
    uses(Modelica(version = "4.0.0")));
end simpleTank;
