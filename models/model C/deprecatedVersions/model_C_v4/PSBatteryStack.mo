model PSBatteryStack
  extends Modelica.Electrical.Batteries.Icons.BatteryIcon(final displaySOC = SOC);
  parameter Integer Ns(final min = 1) = 1 "Number of serial connected cells";
  parameter Integer Np(final min = 1) = 1 "Number of parallel connected cells";
  replaceable parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellData "Cell parameters" annotation(
    Placement(transformation(extent = {{-10, 60}, {10, 80}})));
  parameter Real SOCtolerance = 1e-9 "Tolerance to detect depleted of overcharged battery" annotation(
    Dialog(tab = "Advanced"));
  
  PowerSystems.AC1ph_DC.Ports.TwoPin_n term_n annotation(
    Placement(transformation(origin = {104, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
  PowerSystems.Interfaces.Electric_p term_p annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 2}, extent = {{-10, -10}, {10, 10}})));
  
  //Not sure this line is right... need to test...
  Modelica.Units.SI.Voltage v = term_p.v-term_n.v[1] "Voltage drop of the two pins";
  
  Modelica.Units.SI.Current i = term_p.i "Current into the battery";
  Modelica.Units.SI.Power power = v*i "Power to the battery";
  output Real SOC(start = cellData.SOCmax) = limIntegrator.y "State of charge" annotation(
    Dialog(showStartAttribute = true));
  
  PowerSystems.AC1ph_DC.Sensors.Isensor currentSensor annotation(
    Placement(transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}})));
  PowerSystems.AC1ph_DC.Sources.DCvoltage OCV(use_vDC_in = true) annotation(
    Placement(transformation(origin = {-66, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.LimIntegrator limIntegrator(k = 1/(Np*cellData.Qnom), outMax = 1 - SOCtolerance, outMin = SOCtolerance, initType = Modelica.Blocks.Types.Init.NoInit) annotation(
    Placement(transformation(origin = {-20, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Tables.CombiTable1Ds ocv_soc(table = cellData.OCV_SOC_internal, smoothness = cellData.smoothness, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint) annotation(
    Placement(transformation(origin = {-40, 54}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Gain gainV annotation(
    Placement(transformation(origin = {-60, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PowerSystems.AC1ph_DC.Impedances.Resistor r0(r = {Ns*cellData.Ri/Np, Ns*cellData.Ri/Np}) annotation(
    Placement(transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  assert(cellData.OCVmax > cellData.OCVmin, "Specify 0 <= OCVmin < OCVmax");
  assert(cellData.SOCmax > cellData.SOCmin, "Specify 0 <= SOCmin < SOCmax <= 1");
  assert(cellData.OCV_SOC[1, 1] >= 0, "Specify OCV(SOC) table with minimum SOC >= 0");
  assert(cellData.OCV_SOC[end, 1] <= 1, "Specify OCV(SOC) table with maximum SOC <= 1");
  assert(cellData.OCV_SOC[1, 2] >= 0, "Specify OCV(SOC) table with minimum OCV/OCVmax >= 0");
  assert(cellData.OCV_SOC[end, 2] <= 1, "Specify OCV(SOC) table with maximum OCV/OCVmax <= 1");
  assert(SOC < cellData.SOCmax + SOCtolerance, "Battery overcharged!");
  assert(SOC > cellData.SOCmin - SOCtolerance, "Battery exhausted!");
  connect(r0.term_n, term_n) annotation(
    Line(points = {{40, 0}, {104, 0}}, color = {0, 0, 255}));
  connect(currentSensor.term_n, r0.term_p) annotation(
    Line(points = {{-10, 0}, {20, 0}}, color = {0, 0, 255}));
  connect(currentSensor.term_p, OCV.term) annotation(
    Line(points = {{-30, 0}, {-56, 0}}, color = {0, 0, 255}));
  connect(OCV.neutral, term_p) annotation(
    Line(points = {{-76, 0}, {-100, 0}}, color = {0, 0, 255}));
  connect(gainV.u, ocv_soc.y[1]) annotation(
    Line(points = {{-60, 42}, {-60, 54}, {-51, 54}}, color = {0, 0, 127}));
  connect(limIntegrator.y, ocv_soc.u) annotation(
    Line(points = {{-20, 42}, {-20, 54}, {-28, 54}}, color = {0, 0, 127}));
  connect(currentSensor.i[1], limIntegrator.u) annotation(
    Line(points = {{-20, 10}, {-20, 18}}, color = {0, 0, 127}));
  connect(gainV.y, OCV.vDC_in) annotation(
    Line(points = {{-60, 20}, {-60, 10}}, color = {0, 0, 127}));
  annotation(
    uses(PowerSystems(version = "2.0.0"), Modelica(version = "4.0.0")),
    Diagram);
end PSBatteryStack;
