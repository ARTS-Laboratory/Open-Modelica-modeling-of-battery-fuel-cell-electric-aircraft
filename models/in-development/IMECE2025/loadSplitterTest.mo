model loadSplitterTest
  fcLoadSplitter loadSplitter(chargeCurrent = -10, cruiseTime = 3600, maxRamp = 20, maxTime = 60, taxiRamp = 600) annotation(
    Placement(visible = true, transformation(origin = {-68, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-30, 16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Gain gain(k = 3) annotation(
    Placement(visible = true, transformation(origin = {64, 30}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  simpleTank tank(Cv = 60) annotation(
    Placement(visible = true, transformation(origin = {90, 42}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  detailedFC fc(N = 36, N_m = 15)  annotation(
    Placement(visible = true, transformation(origin = {28, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Modelica.Electrical.Analog.Sources.SignalCurrent fcLoad annotation(
    Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Sensors.MultiSensor fcMeter annotation(
    Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SignalCurrent batLoad annotation(
    Placement(visible = true, transformation(origin = {-20, -6}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  CellStackTC_adapted stack(CycleLife = 425, RUL(start = 0.9), SOCini = 0.7, cellParameters = batParams, np = 120, ns = 96)  annotation(
    Placement(visible = true, transformation(origin = {28, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.MultiSensor batMeter annotation(
    Placement(visible = true, transformation(origin = {0, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter ElectricalEnergyStorage.CellRecords.StaticResistance.StaticResistanceParameters batParams(Rs = ElectricalEnergyStorage.CellRecords.Components.Resistance(R0 = 0.0162421792644079),SOCOCV = ElectricalEnergyStorage.CellRecords.Components.SOCOCV(OCVtableOnFile = true, OCVtableName = "18650SOCvOVC", OCVfileName = "E:\UTDallas Project\IMECE2025\model\30Q_SOCOCV.csv"), capacity = ElectricalEnergyStorage.CellRecords.Components.ChargeCapacity(C0 = 10800))  annotation(
    Placement(visible = true, transformation(origin = {50, -6}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
initial equation
  fcLoad.i = 1e-6;
  batLoad.i = 1e-6;

equation
  fc.p_air = 1e5;
  loadSplitter.SOC = stack.staticResistance.cellCalculator.SOC;
  loadSplitter.fcV = fc.E_oc.v - fc.v_act.v - fc.v_conc.v - fc.R_ohm.v;
  connect(tank.q_fuel, gain.u) annotation(
    Line(points = {{80, 38}, {69, 38}, {69, 30}}, color = {0, 0, 127}));
  connect(tank.p_fuel, fc.p_fuel) annotation(
    Line(points = {{79, 49}, {39, 49}}, color = {0, 0, 127}));
  connect(gain.y, fc.q_air) annotation(
    Line(points = {{60, 30}, {46, 30}, {46, 31}, {39, 31}}, color = {0, 0, 127}));
  connect(tank.q_fuel, fc.q_fuel) annotation(
    Line(points = {{79, 38}, {44, 38}, {44, 46}, {39, 46}}, color = {0, 0, 127}));
  connect(loadSplitter.fcLoad, fcLoad.i) annotation(
    Line(points = {{-56, 20}, {-44, 20}, {-44, 40}, {-32, 40}}, color = {0, 0, 127}));
  connect(ground.p, fcLoad.p) annotation(
    Line(points = {{-20, 16}, {-20, 30}}, color = {0, 0, 255}));
  connect(batLoad.p, ground.p) annotation(
    Line(points = {{-20, 4}, {-20, 16}}, color = {0, 0, 255}));
  connect(batLoad.i, loadSplitter.batLoad) annotation(
    Line(points = {{-32, -6}, {-44, -6}, {-44, 12}, {-56, 12}}, color = {0, 0, 127}));
  connect(batMeter.pc, batLoad.p) annotation(
    Line(points = {{-10, -6}, {-12, -6}, {-12, 10}, {-20, 10}, {-20, 4}}, color = {0, 0, 255}));
  connect(batMeter.pv, batLoad.p) annotation(
    Line(points = {{0, 4}, {0, 10}, {-20, 10}, {-20, 4}}, color = {0, 0, 255}));
  connect(batMeter.nc, stack.pin_pStack) annotation(
    Line(points = {{10, -6}, {14, -6}, {14, 10}, {28, 10}, {28, 4}}, color = {0, 0, 255}));
  connect(stack.pin_nStack, batLoad.n) annotation(
    Line(points = {{28, -16}, {28, -24}, {-20, -24}, {-20, -16}}, color = {0, 0, 255}));
  connect(batMeter.nv, batLoad.n) annotation(
    Line(points = {{0, -16}, {0, -24}, {-20, -24}, {-20, -16}}, color = {0, 0, 255}));
  connect(fcMeter.pv, fcLoad.p) annotation(
    Line(points = {{0, 30}, {0, 24}, {-20, 24}, {-20, 30}}, color = {0, 0, 255}));
  connect(fc.p, fcLoad.p) annotation(
    Line(points = {{28, 30}, {28, 24}, {-20, 24}, {-20, 30}}, color = {0, 0, 255}));
  connect(fcLoad.n, fcMeter.pc) annotation(
    Line(points = {{-20, 50}, {-20, 56}, {-14, 56}, {-14, 40}, {-10, 40}}, color = {0, 0, 255}));
  connect(fcMeter.nv, fcLoad.n) annotation(
    Line(points = {{0, 50}, {0, 56}, {-20, 56}, {-20, 50}}, color = {0, 0, 255}));
  connect(fc.n, fcMeter.nc) annotation(
    Line(points = {{28, 50}, {28, 56}, {14, 56}, {14, 40}, {10, 40}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "3.2.3"), ElectricalEnergyStorage(version = "3.2.2")),
    Diagram);
end loadSplitterTest;
