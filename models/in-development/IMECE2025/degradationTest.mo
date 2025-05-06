model degradationTest
  LCO_CellStackTC stack(SOCini = 1, cellParameters = cellParams, np = 1, ns = 1)  annotation(
    Placement(visible = true, transformation(origin = {28, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-40, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.MultiSensor meter annotation(
    Placement(visible = true, transformation(origin = {-6, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter ElectricalEnergyStorage.CellRecords.StaticResistance.StaticResistanceParameters cellParams(Rs = ElectricalEnergyStorage.CellRecords.Components.Resistance(R0 = 0.0162421792644079),SOCOCV = ElectricalEnergyStorage.CellRecords.Components.SOCOCV(OCVtableOnFile = true, OCVtableName = "18650SOCvOVC", OCVfileName = "/media/nate/External/UTDallas Project/IMECE2025/model/30Q_SOCOCV.csv"), capacity = ElectricalEnergyStorage.CellRecords.Components.ChargeCapacity(C0 = 10800))  annotation(
    Placement(visible = true, transformation(origin = {56, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.TerminateSimulation terminateSimulation(condition = stack.cellCalculator.cycles >= 250)  annotation(
    Placement(visible = true, transformation(origin = {0, 80}, extent = {{-40, -4}, {40, 4}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.PulseCurrent pulseCurrent(I = -16.5, offset = 1.5, period = 7920, width = 20/2.2)  annotation(
    Placement(visible = true, transformation(origin = {-40, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
algorithm

equation
  connect(meter.nc, stack.pin_p) annotation(
    Line(points = {{4, 30}, {10, 30}, {10, 54}, {28, 54}, {28, 40}}, color = {0, 0, 255}));
  connect(pulseCurrent.n, meter.pc) annotation(
    Line(points = {{-40, 40}, {-40, 52}, {-22, 52}, {-22, 30}, {-16, 30}}, color = {0, 0, 255}));
  connect(meter.pv, pulseCurrent.n) annotation(
    Line(points = {{-6, 40}, {-6, 52}, {-40, 52}, {-40, 40}}, color = {0, 0, 255}));
  connect(pulseCurrent.p, stack.pin_n) annotation(
    Line(points = {{-40, 20}, {-40, 12}, {28, 12}, {28, 20}}, color = {0, 0, 255}));
  connect(meter.nv, pulseCurrent.p) annotation(
    Line(points = {{-6, 20}, {-6, 12}, {-40, 12}, {-40, 20}}, color = {0, 0, 255}));
  connect(ground.p, pulseCurrent.p) annotation(
    Line(points = {{-40, 2}, {-40, 20}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "3.2.3"), ElectricalEnergyStorage(version = "3.2.2")));
end degradationTest;