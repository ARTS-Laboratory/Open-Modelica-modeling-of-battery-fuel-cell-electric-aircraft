block DOD_mSOC
  extends ElectricalEnergyStorage.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput SOC annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-100, -10}, {-80, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput DOD annotation(
    Placement(visible = true, transformation(origin = {100, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput mSOC annotation(
    Placement(visible = true, transformation(origin = {100, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real initialSOC;
  Real maxSOC(start=initialSOC);
  Real minSOC(start=initialSOC);
  
initial equation
  //maxSOC = initialSOC;
  //minSOC = initialSOC;

algorithm
  maxSOC := max(delay(maxSOC,1),SOC);
  minSOC := min(delay(minSOC,1),SOC);
  
equation
  DOD = maxSOC - minSOC;
  mSOC = (DOD/2)+minSOC;
  annotation(
    uses(Modelica(version = "3.2.3")));
end DOD_mSOC;