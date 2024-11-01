model simpleTank

  Modelica.Blocks.Interfaces.RealOutput p_fuel annotation(
    Placement(transformation(origin = {106, 72}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {106, 72}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput q_fuel annotation(
    Placement(transformation(origin = {106, -38}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {106, -38}, extent = {{-10, -10}, {10, 10}})));


  parameter Real capacity = 100 "kg";
  parameter Real P;
  parameter Real T;
  
  Real fuel_percent;
  Real m_fuel;

equation

 if time == 0 then
   fuel_percent = 1;
 else
   fuel_percent = m_fuel/capacity;
 end if;
 
  m_fuel = m_fuel - q_fuel;
  p_fuel = P;
  q_fuel = 0.5*(m_fuel/capacity)*10;

annotation(
    uses(Modelica(version = "4.0.0")));
end simpleTank;
