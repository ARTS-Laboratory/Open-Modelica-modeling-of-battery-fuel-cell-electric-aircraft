model fuelCellTest
  Modelica.Blocks.Sources.Constant p_air(k = 600000) annotation(
    Placement(transformation(origin = {-28, -12}, extent = {{-4, -4}, {4, 4}})));
  Modelica.Electrical.Analog.Sensors.MultiSensor meter annotation(
    Placement(transformation(origin = {30, -6}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {0, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Math.Gain gain(k = 2) annotation(
    Placement(transformation(origin = {-47, -15}, extent = {{-3, -3}, {3, 3}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor c(C = 15000, T(fixed = true)) annotation(
    Placement(transformation(origin = {28, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation(
    Placement(transformation(origin = {12, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant h(k = 0.24) annotation(
    Placement(transformation(origin = {-18, 52}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambient(T(displayUnit = "K") = 293.15) annotation(
    Placement(transformation(origin = {12, 76}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  detailedFC fc(N = 1, N_m = 1) annotation(
    Placement(transformation(origin = {0, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  simpleTank tank(Cv = 1.3, P = 999999.9999999999) annotation(
    Placement(transformation(origin = {-74, -6}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrent(I = (1e-6) - 92.8, duration = 600, offset = -1e-6, startTime = 300) annotation(
    Placement(transformation(origin = {58, -8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
initial equation
//fc.v_act.i = 1e-6;
//fc.v_conc.i = 1e-6;
//fc.U_O2 = 1e-6;
//fc.U_H2 = 1e-6;
equation
  connect(ground.p, fc.n) annotation(
    Line(points = {{0, 18}, {0, 4}}, color = {0, 0, 255}));
  connect(p_air.y, fc.p_air) annotation(
    Line(points = {{-23.6, -12}, {-9.6, -12}}, color = {0, 0, 127}));
  connect(gain.y, fc.q_air) annotation(
    Line(points = {{-44, -15}, {-9.7, -15}}, color = {0, 0, 127}));
  connect(meter.pv, fc.p) annotation(
    Line(points = {{30, -16}, {30, -26}, {0, -26}, {0, -16}}, color = {0, 0, 255}));
  connect(meter.nv, fc.n) annotation(
    Line(points = {{30, 4}, {30, 10}, {0, 10}, {0, 4}}, color = {0, 0, 255}));
  connect(meter.nc, fc.n) annotation(
    Line(points = {{20, -6}, {14, -6}, {14, 10}, {0, 10}, {0, 4}}, color = {0, 0, 255}));
  connect(c.port, convection.solid) annotation(
    Line(points = {{18, 28}, {12, 28}, {12, 42}}, color = {191, 0, 0}));
  connect(h.y, convection.Gc) annotation(
    Line(points = {{-7, 52}, {1, 52}}, color = {0, 0, 127}));
  connect(convection.fluid, ambient.port) annotation(
    Line(points = {{12, 62}, {12, 66}}, color = {191, 0, 0}));
  connect(fc.hp, convection.solid) annotation(
    Line(points = {{10, -6}, {12, -6}, {12, 42}}, color = {191, 0, 0}));
  connect(tank.p_fuel, fc.p_fuel) annotation(
    Line(points = {{-64, 2}, {-50, 2}, {-50, 4}, {-10, 4}}, color = {0, 0, 127}));
  connect(tank.q_fuel, fc.q_fuel) annotation(
    Line(points = {{-64, -10}, {-52, -10}, {-52, 0}, {-10, 0}}, color = {0, 0, 127}));
  connect(gain.u, tank.q_fuel) annotation(
    Line(points = {{-50, -14}, {-52, -14}, {-52, -10}, {-64, -10}}, color = {0, 0, 127}));
  connect(meter.pc, rampCurrent.p) annotation(
    Line(points = {{40, -6}, {48, -6}, {48, 10}, {58, 10}, {58, 2}}, color = {0, 0, 255}));
  connect(rampCurrent.n, fc.p) annotation(
    Line(points = {{58, -18}, {58, -26}, {0, -26}, {0, -16}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "3.2.3")),
    Diagram);
end fuelCellTest;