model simpleCool
  parameter Modelica.Thermal.FluidHeatFlow.Media.Air_30degC air(rho(displayUnit = "kg/m3")) annotation(
    Placement(transformation(origin = {-56, 90}, extent = {{-10, -10}, {10, 10}})));
  parameter Modelica.Thermal.FluidHeatFlow.Media.Water water annotation(
    Placement(transformation(origin = {-86, 90}, extent = {{-10, -10}, {10, 10}})));
  simpleHEX HEX(medium1 = water, medium2 = air, fluid1_T0 = 303.15, fluid2_T0 = 303.15, T0fixed = false, fluid1_Vflow(start = 0.001), fluid2_Vflow(start = 3.544), epsilon = 0.95, fluid1_dp = 1e5) annotation(
    Placement(transformation(origin = {52, 28}, extent = {{-18, -18}, {18, 18}}, rotation = 90)));
  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow volumeFlow1(medium = air, m = 0, T0 = 303.15, constantVolumeFlow = 106.32, T0fixed = false) annotation(
    Placement(transformation(origin = {52, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient2(medium = air, constantAmbientPressure = 1e5, constantAmbientTemperature = 303.15, flowPort.h(start = 3020000)) annotation(
    Placement(transformation(origin = {52, -44}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient3(medium = air, constantAmbientPressure = 1e5, constantAmbientTemperature = 303.15) annotation(
    Placement(transformation(origin = {52, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.FluidHeatFlow.Sources.IdealPump pump(m = 0, T0 = 303.15, wNominal(displayUnit = "rad/s") = 2000, dp0 = 5e5, V_flow0 = 4e-3, medium = water) annotation(
    Placement(transformation(origin = {-58, 28}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed(exact = true, useSupport = false) annotation(
    Placement(transformation(origin = {-54, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Rotational.Sensors.MultiSensor multiSensor annotation(
    Placement(transformation(origin = {-58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.FluidHeatFlow.Sources.AbsolutePressure absolutePressure(medium = water, p = 1e5) annotation(
    Placement(transformation(origin = {-76, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const(k = 1000) annotation(
    Placement(transformation(origin = {-54, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.FluidHeatFlow.Components.Valve controlValve(Kv1 = 0.001, LinearCharacteristic = true, T0 = 303.15, dp0 = 1000, frictionLoss = 0, kv0 = 1e-300, m = 0, medium = water, rho0 = water.rho, y1 = 1) annotation(
    Placement(transformation(origin = {-30, 27}, extent = {{-10, -10}, {10, 10}})));
  mockFC fakeFC(m = 0, T0 = 303.15, Qdot = 123000, medium = water)  annotation(
    Placement(transformation(origin = {8, 28}, extent = {{-16, -16}, {16, 16}})));
  Modelica.Blocks.Sources.Constant const1(k = 1)  annotation(
    Placement(transformation(origin = {-30, 62}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
//PI.u_m = HEX.T_1b;
  connect(volumeFlow1.flowPort_b, HEX.fluid2_a) annotation(
    Line(points = {{52, -2}, {52, 10}}, color = {255, 0, 0}));
  connect(ambient2.flowPort, volumeFlow1.flowPort_a) annotation(
    Line(points = {{52, -34}, {52, -22}}, color = {255, 0, 0}));
  connect(HEX.fluid2_b, ambient3.flowPort) annotation(
    Line(points = {{52, 45.64}, {52, 73.64}}, color = {255, 0, 0}));
  connect(speed.flange, multiSensor.flange_a) annotation(
    Line(points = {{-54, -20}, {-54, -15}, {-58, -15}, {-58, -10}}));
  connect(multiSensor.flange_b, pump.flange_a) annotation(
    Line(points = {{-58, 10}, {-58, 18}}));
  connect(HEX.fluid1_b, pump.flowPort_a) annotation(
    Line(points = {{69.28, 27.64}, {87.28, 27.64}, {87.28, -78.36}, {-84.72, -78.36}, {-84.72, 28}, {-68, 28}}, color = {255, 0, 0}));
  connect(absolutePressure.flowPort, pump.flowPort_a) annotation(
    Line(points = {{-76, 40}, {-76, 28}, {-68, 28}}, color = {255, 0, 0}));
  connect(const.y, speed.w_ref) annotation(
    Line(points = {{-54, -52}, {-54, -42}}, color = {0, 0, 127}));
  connect(controlValve.flowPort_a, pump.flowPort_b) annotation(
    Line(points = {{-40, 28}, {-48, 28}}, color = {255, 0, 0}));
  connect(controlValve.flowPort_b, fakeFC.flowPort_a) annotation(
    Line(points = {{-20, 28}, {-8, 28}}, color = {255, 0, 0}));
  connect(fakeFC.flowPort_b, HEX.fluid1_a) annotation(
    Line(points = {{24, 28}, {34, 28}}, color = {255, 0, 0}));
  connect(const1.y, controlValve.y) annotation(
    Line(points = {{-30, 52}, {-30, 38}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.1.0")));
end simpleCool;