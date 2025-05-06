block LCO_Capacity
  extends ElectricalEnergyStorage.Icons.Block;
  parameter ElectricalEnergyStorage.CellRecords.Components.ChargeCapacity capacity "Charge capacity";
  parameter Real b = 0.453;
  Real CF "Capacity fade (%)";
  Real RUL "Remaining Useful Life (%)";
  Modelica.Blocks.Interfaces.RealInput ECF annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(extent = {{-100, -10}, {-80, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput DOD annotation(
    Placement(visible = true, transformation(origin = {80, 100}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {40, 0}, extent = {{-100, -10}, {-80, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput mSOC annotation(
    Placement(visible = true, transformation(origin = {-80, 100}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, 0}, extent = {{-100, -10}, {-80, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput Qabs "Connector of Real input signal" annotation(
    Placement(transformation(extent = {{-100, -70}, {-80, -50}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput T "Connector of Real input signal" annotation(
    Placement(transformation(extent = {{-100, -10}, {-80, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput t "Connector of Real input signal" annotation(
    Placement(transformation(extent = {{-100, 50}, {-80, 70}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput C "Output signal connector" annotation(
    Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
  
equation
  //C = capacity.C0*(1 + capacity.aging.kt*t + capacity.aging.kQabs*Qabs)*(1 + capacity.temperature.alpha*(T - capacity.temperature.Tref));
  CF = 1-(C/capacity.C0);
  RUL = 1-(CF/0.2);
  C = (capacity.C0/100)*(100-(3.25*mSOC*(1+3.25*DOD-2.25*(DOD^2)))*((ECF)^b));
  annotation(
    Diagram(graphics),
    Icon(graphics = {Text(textColor = {0, 0, 130}, extent = {{-108, 82}, {-28, 42}}, textString = "t"), Text(textColor = {0, 0, 130}, extent = {{40, 20}, {100, -20}}, textString = "C"), Text(textColor = {0, 0, 130}, extent = {{-106, -36}, {-4, -76}}, textString = "|Q|"), Text(textColor = {0, 0, 130}, extent = {{-106, 20}, {-26, -20}}, textString = "T")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    uses(Modelica(version = "3.2.3")));
end LCO_Capacity;