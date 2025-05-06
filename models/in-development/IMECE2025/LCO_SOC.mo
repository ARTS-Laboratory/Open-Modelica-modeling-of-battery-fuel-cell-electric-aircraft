block LCO_SOC
  extends ElectricalEnergyStorage.Icons.Block;
  parameter Real SOCini "Initial state of charge";
  Modelica.Blocks.Interfaces.RealInput C "Connector of Real input signal" annotation(
    Placement(transformation(extent = {{-100, -70}, {-80, -50}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput SOC "Output signal connector" annotation(
    Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput i "Connector of Real input signal" annotation(
    Placement(transformation(extent = {{-100, 50}, {-80, 70}}, rotation = 0)));
  Modelica.Blocks.Math.Division DivisionNormierung annotation(
    Placement(transformation(extent = {{-40, -10}, {-20, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimIntegrator limIntegrator(outMax = 1 - (1e-6), outMin = 1e-6, y_start = SOCini)  annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(i, DivisionNormierung.u1) annotation(
    Line(points = {{-90, 60}, {-60, 60}, {-60, 6}, {-42, 6}}, color = {0, 0, 127}));
  connect(C, DivisionNormierung.u2) annotation(
    Line(points = {{-90, -60}, {-60, -60}, {-60, -6}, {-42, -6}}, color = {0, 0, 127}));
  connect(DivisionNormierung.y, limIntegrator.u) annotation(
    Line(points = {{-18, 0}, {-2, 0}}, color = {0, 0, 127}));
  connect(limIntegrator.y, SOC) annotation(
    Line(points = {{22, 0}, {110, 0}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics),
    Icon(graphics = {Text(textColor = {0, 0, 130}, extent = {{-80, -40}, {-40, -80}}, textString = "C"), Text(textColor = {0, 0, 130}, extent = {{-80, 80}, {-40, 40}}, textString = "i"), Text(textColor = {0, 0, 130}, extent = {{10, 20}, {90, -20}}, textString = "SOC")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    uses(Modelica(version = "3.2.3")));
end LCO_SOC;