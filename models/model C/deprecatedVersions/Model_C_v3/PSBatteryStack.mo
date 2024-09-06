model PSBatteryStack
  //Icons
  extends ElectricalEnergyStorage.Icons.StackStaticResistance;
  
  //Params
  parameter Integer ns(min = 1) "number of serial connected cells";
  parameter Integer np(min = 1) "number of parallel connected cells";
  //extends ElectricalEnergyStorage.Batteries.Components.OperationalParameters;
  parameter Real SOCini(start = 0.5) "Initial state of charge" annotation(Dialog(group = "Initialization"));
  final parameter Modelica.SIunits.Time tini(fixed = false) "Initial time";
  //External Ports
  PowerSystems.AC1ph_DC.Ports.TwoPin_n term_p annotation(
    Placement(visible = true, transformation(origin = {-4, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Interfaces.Electric_p term_n annotation(
    Placement(visible = true, transformation(origin = {4, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Sensors.Isensor iBatt annotation(
    Placement(visible = true, transformation(origin = {0, 60}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  PowerSystems.AC1ph_DC.Sources.DCvoltage Uo(use_vDC_in = true)  annotation(
    Placement(visible = true, transformation(origin = {0, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  //Components
  Modelica.Blocks.Math.Gain gain(final k = ns) annotation(Placement(transformation(extent = {{-40, -80}, {-20, -60}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(final k = 1 / np) annotation(Placement(transformation(origin = {-30, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Clock clock(final startTime = tini) annotation(Placement(transformation(extent = {{-4, 4}, {4, -4}}, rotation = 180, origin = {-24, 36})));
  Modelica.Blocks.Sources.Constant const(k = cellParameters.Rs.R0)  annotation(Placement(transformation(extent = {{4, -4}, {-4, 4}}, rotation = 0, origin = {-24, 24})));
  Modelica.Blocks.Tables.CombiTable1D sococvTable(final smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, final tableOnFile = cellParameters.SOCOCV.OCVtableOnFile, final table = cellParameters.SOCOCV.OCVtable, final tableName = cellParameters.SOCOCV.OCVtableName, final fileName = cellParameters.SOCOCV.OCVfileName) annotation(Placement(transformation(extent = {{-70, -80}, {-50, -60}}, rotation = 0)));
  ElectricalEnergyStorage.Batteries.Components.Calculators.PSCellCalculator cellCalculator(final SOCini = SOCini, final Z0 = cellParameters.Rs.R0, final capacity = cellParameters.capacity, final SoH = cellParameters.SoH) annotation(
    Placement(visible = true, transformation(origin = {-60, 58}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  parameter ElectricalEnergyStorage.CellRecords.StaticResistance.StaticResistanceParameters cellParameters annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Impedances.Resistor Rs(r = {cellParameters.Rs.R0*ns/np, cellParameters.Rs.R0*ns/np})  annotation(
    Placement(visible = true, transformation(origin = {0, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant constTemp annotation(
    Placement(visible = true, transformation(origin = {-28, 88}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
protected
   //Equations
initial equation
  tini = time;

equation
  //gain.u = if cellCalculator.SOC < 0.0002 then 2.60780469349346 else sococvTable.y[1];
  connect(term_p, iBatt.term_n) annotation(
    Line(points = {{-4, 100}, {0, 100}, {0, 70}}, color = {0, 0, 255}));
  connect(iBatt.i[1], gain1.u) annotation(
    Line(points = {{-10, 60}, {-18, 60}}, color = {0, 0, 127}));
  connect(gain.y, Uo.vDC_in) annotation(Line(points = {{-18, -70}, {-16, -70}, {-16, -64}, {-10, -64}}, color = {0, 0, 127}));
  connect(term_n, Uo.neutral) annotation(
    Line(points = {{4, -100}, {0, -100}, {0, -80}}, color = {0, 0, 255}));
  connect(gain1.y, cellCalculator.i) annotation(
    Line(points = {{-40, 60}, {-50, 60}}, color = {0, 0, 127}));
  connect(clock.y, cellCalculator.t) annotation(
    Line(points = {{-28, 36}, {-42, 36}, {-42, 56}, {-50, 56}}, color = {0, 0, 127}));
  connect(const.y, cellCalculator.Z) annotation(
    Line(points = {{-28, 24}, {-46, 24}, {-46, 52}, {-50, 52}}, color = {0, 0, 127}));
  connect(cellCalculator.SOC, sococvTable.u[1]) annotation(
    Line(points = {{-70, 64}, {-88, 64}, {-88, -70}, {-72, -70}}, color = {0, 0, 127}));
  connect(Rs.term_n, iBatt.term_p) annotation(
    Line(points = {{0, 8}, {0, 50}}, color = {0, 0, 255}));
  connect(Rs.term_p, Uo.term) annotation(
    Line(points = {{0, -12}, {0, -60}}));
  connect(constTemp.y, cellCalculator.T) annotation(
    Line(points = {{-38, 88}, {-46, 88}, {-46, 64}, {-50, 64}}, color = {0, 0, 127}));
  connect(sococvTable.y[1], gain.u) annotation(
    Line(points = {{-49, -70}, {-42, -70}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1), graphics),
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1), graphics),
    uses(Modelica(version = "3.2.3"), PowerSystems(version = "1.0.1"), ElectricalEnergyStorage(version = "3.2.2")));
end PSBatteryStack;