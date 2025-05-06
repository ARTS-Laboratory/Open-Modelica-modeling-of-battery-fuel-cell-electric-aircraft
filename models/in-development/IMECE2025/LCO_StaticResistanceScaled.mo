block LCO_StaticResistanceScaled
import ElectricEnergyStorages = ElectricalEnergyStorage;
extends ElectricalEnergyStorage.Icons.StackStaticResistance;
  parameter Integer ns(min = 1) "number of serial connected cells";
  parameter Integer np(min = 1) "number of parallel connected cells";
  parameter ElectricalEnergyStorage.CellRecords.StaticResistance.StaticResistanceParameters cellParameters annotation(
    __Dymola_choicesAllMatching = true,
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  extends ElectricalEnergyStorage.Batteries.Components.OperationalParameters;
  parameter Real SOCini(start = 0.5) "Initial state of charge" annotation(
    Dialog(group = "Initialization"));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative pin" annotation(
    Placement(transformation(extent = {{-10, -110}, {10, -90}}, rotation = 0), iconTransformation(extent = {{-10, -104}, {10, -84}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive pin (potential p.v > n.v for positive voltage drop v)" annotation(
    Placement(transformation(extent = {{-10, 90}, {10, 110}}, rotation = 0), iconTransformation(extent = {{-10, 84}, {10, 104}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage Uo annotation(
    Placement(transformation(origin = {0, -70}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor IBatt annotation(
    Placement(transformation(origin = {0, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.HeatingResistor Rs(useHeatPort = true, final R_ref = cellParameters.Rs.R0*ns/np, final T_ref = cellParameters.Rs.temperature.Tref, final alpha = cellParameters.Rs.temperature.alpha) annotation(
    Placement(transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0), iconTransformation(extent = {{84, -10}, {104, 10}})));
  Modelica.Blocks.Math.Gain gain(final k = ns) annotation(
    Placement(transformation(extent = {{-40, -80}, {-20, -60}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(final k = 1/np) annotation(
    Placement(transformation(origin = {-30, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
protected
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort annotation(
    Placement(transformation(extent = {{76, -4}, {84, 4}})));
public
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final T = TOperational) if not useHeatPort annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {80, -30})));
  Modelica.Blocks.Sources.Clock clock(final startTime = tini) annotation(
    Placement(transformation(extent = {{-4, 4}, {4, -4}}, rotation = 180, origin = {-24, 36})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temp annotation(
    Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {70, 80})));
  Modelica.Blocks.Sources.Constant const(final k = cellParameters.Rs.R0) annotation(
    Placement(transformation(extent = {{4, -4}, {-4, 4}}, rotation = 0, origin = {-24, 24})));
  LCO_CellCalculator cellCalculator(final SOCini = SOCini, final Z0 = cellParameters.Rs.R0, final capacity = cellParameters.capacity, final SoH = cellParameters.SoH) annotation(
    Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, origin = {-70, 58})));
  Modelica.Blocks.Tables.CombiTable1D sococvTable(final smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, final tableOnFile = cellParameters.SOCOCV.OCVtableOnFile, final table = cellParameters.SOCOCV.OCVtable, final tableName = cellParameters.SOCOCV.OCVtableName, final fileName = cellParameters.SOCOCV.OCVfileName) annotation(
    Placement(transformation(extent = {{-70, -80}, {-50, -60}}, rotation = 0)));
  final parameter Modelica.SIunits.Time tini(fixed = false) "Initial time";
initial equation
  tini = time;
equation
  connect(Uo.n, pin_n) annotation(
    Line(points = {{0, -80}, {0, -100}}, color = {0, 0, 255}));
  connect(Rs.p, Uo.p) annotation(
    Line(points = {{0, -10}, {0, -35}, {0, -60}}, color = {0, 0, 255}));
  connect(gain.y, Uo.v) annotation(
    Line(points = {{-19, -70}, {-7, -70}}, color = {0, 0, 127}));
  connect(gain1.u, IBatt.i) annotation(
    Line(points = {{-18, 60}, {-10, 60}}, color = {0, 0, 127}));
  connect(Rs.heatPort, internalHeatPort) annotation(
    Line(points = {{10, 0}, {80, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(internalHeatPort, fixedTemperature.port) annotation(
    Line(points = {{80, 0}, {80, -20}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(internalHeatPort, heatPort) annotation(
    Line(points = {{80, 0}, {100, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(internalHeatPort, temp.port) annotation(
    Line(points = {{80, 0}, {80, 80}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(cellCalculator.i, gain1.y) annotation(
    Line(points = {{-61, 60}, {-41, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(cellCalculator.T, temp.T) annotation(
    Line(points = {{-61, 64}, {-40, 64}, {-40, 80}, {60, 80}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(cellCalculator.t, clock.y) annotation(
    Line(points = {{-61, 56}, {-40, 56}, {-40, 36}, {-28.4, 36}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(const.y, cellCalculator.Z) annotation(
    Line(points = {{-28.4, 24}, {-50, 24}, {-50, 52}, {-61, 52}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(IBatt.p, Rs.n) annotation(
    Line(points = {{0, 50}, {0, 10}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(IBatt.n, pin_p) annotation(
    Line(points = {{0, 70}, {0, 100}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(sococvTable.y[1], gain.u) annotation(
    Line(points = {{-49, -70}, {-42, -70}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(sococvTable.u[1], cellCalculator.SOC) annotation(
    Line(points = {{-72, -70}, {-90, -70}, {-90, 64}, {-81, 64}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1), graphics),
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1), graphics));

end LCO_StaticResistanceScaled;