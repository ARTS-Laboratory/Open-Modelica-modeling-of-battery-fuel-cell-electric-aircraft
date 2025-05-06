model IMECE2025v1
  Modelica.Electrical.Analog.Sensors.MultiSensor fcmeter annotation(
    Placement(visible = true, transformation(origin = {-14, 34}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  detailedFC fc(N = 300, N_m = 8)  annotation(
    Placement(visible = true, transformation(origin = {20, 32}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  simpleTank tank(Cv = 0.6)  annotation(
    Placement(visible = true, transformation(origin = {76, 32}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain annotation(
    Placement(visible = true, transformation(origin = {48, 42}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  flightCycle cycle(cruiseP(displayUnit = "kW") = 154000, cruiseTime = 5112, maxP(displayUnit = "kW") = 212000, maxRamp = 30, maxTime = 180, sigma = 0, taxiP(displayUnit = "kW") = 41000, taxiRamp = 60, taxiTime = 592)  annotation(
    Placement(visible = true, transformation(origin = {-76, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 3e5)  annotation(
    Placement(visible = true, transformation(origin = {47, 33}, extent = {{-3, -3}, {3, 3}}, rotation = 180)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {30, 8}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.SignalCurrent fcLoad annotation(
    Placement(visible = true, transformation(origin = {-44, 32}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  LCO_CellStackTC stack(CycleLife = 425,SOCini = 1, cellParameters = batParams, np = 48, ns = 168)  annotation(
    Placement(visible = true, transformation(origin = {20, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.MultiSensor batmeter annotation(
    Placement(visible = true, transformation(origin = {-14, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SignalCurrent batLoad annotation(
    Placement(visible = true, transformation(origin = {-44, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  parameter ElectricalEnergyStorage.CellRecords.StaticResistance.StaticResistanceParameters batParams(Rs = ElectricalEnergyStorage.CellRecords.Components.Resistance(R0 = 0.0162421792644079),SOCOCV = ElectricalEnergyStorage.CellRecords.Components.SOCOCV(OCVtableOnFile = true, OCVtableName = "18650SOCvOVC", OCVfileName = "/media/nate/External/UTDallas Project/IMECE2025/model/30Q_SOCOCV.csv"), capacity = ElectricalEnergyStorage.CellRecords.Components.ChargeCapacity(C0 = 10800))  annotation(
    Placement(visible = true, transformation(origin = {52, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.TerminateSimulation terminateSimulation(condition = stack.cellCalculator.c.RUL <= 0)  annotation(
    Placement(visible = true, transformation(origin = {-8, 84}, extent = {{-40, -4}, {40, 4}}, rotation = 0)));
equation
  fcLoad.i = max(cycle.fcLoad/fcmeter.v,1e-6);
  batLoad.i = cycle.batLoad/batmeter.v;
  tank.limIntegrator.reset = cycle.refuel;
  connect(gain.y, fc.q_air) annotation(
    Line(points = {{44, 42}, {30, 42}}, color = {0, 0, 127}));
  connect(tank.q_fuel, gain.u) annotation(
    Line(points = {{66, 36}, {60, 36}, {60, 42}, {52, 42}}, color = {0, 0, 127}));
  connect(tank.q_fuel, fc.q_fuel) annotation(
    Line(points = {{66, 36}, {60, 36}, {60, 26}, {30, 26}}, color = {0, 0, 127}));
  connect(tank.p_fuel, fc.p_fuel) annotation(
    Line(points = {{66, 24}, {30, 24}}, color = {0, 0, 127}));
  connect(const.y, fc.p_air) annotation(
    Line(points = {{44, 33}, {36, 33}, {36, 38}, {30, 38}}, color = {0, 0, 127}));
  connect(fcmeter.nv, fc.n) annotation(
    Line(points = {{-14, 24}, {-14, 12}, {20, 12}, {20, 22}}, color = {0, 0, 255}));
  connect(fcmeter.pv, fc.p) annotation(
    Line(points = {{-14, 44}, {-14, 52}, {20, 52}, {20, 42}}, color = {0, 0, 255}));
  connect(fcmeter.pc, fc.p) annotation(
    Line(points = {{-4, 34}, {2, 34}, {2, 52}, {20, 52}, {20, 42}}, color = {0, 0, 255}));
  connect(fcLoad.p, fcmeter.nc) annotation(
    Line(points = {{-44, 42}, {-44, 52}, {-30, 52}, {-30, 34}, {-24, 34}}, color = {0, 0, 255}));
  connect(fcLoad.n, fc.n) annotation(
    Line(points = {{-44, 22}, {-44, 12}, {20, 12}, {20, 22}}, color = {0, 0, 255}));
  connect(batmeter.nc, stack.pin_p) annotation(
    Line(points = {{-4, -16}, {2, -16}, {2, 4}, {20, 4}, {20, -6}}, color = {0, 0, 255}));
  connect(ground.p, fc.n) annotation(
    Line(points = {{20, 8}, {20, 22}}, color = {0, 0, 255}));
  connect(ground.p, stack.pin_p) annotation(
    Line(points = {{20, 8}, {20, -6}}, color = {0, 0, 255}));
  connect(batLoad.n, batmeter.pc) annotation(
    Line(points = {{-44, -6}, {-44, 4}, {-28, 4}, {-28, -16}, {-24, -16}}, color = {0, 0, 255}));
  connect(batmeter.pv, batLoad.n) annotation(
    Line(points = {{-14, -6}, {-14, 4}, {-44, 4}, {-44, -6}}, color = {0, 0, 255}));
  connect(batLoad.p, stack.pin_n) annotation(
    Line(points = {{-44, -26}, {-44, -36}, {20, -36}, {20, -26}}, color = {0, 0, 255}));
  connect(batmeter.nv, batLoad.p) annotation(
    Line(points = {{-14, -26}, {-14, -36}, {-44, -36}, {-44, -26}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "3.2.3"), ElectricalEnergyStorage(version = "3.2.2")));
end IMECE2025v1;
