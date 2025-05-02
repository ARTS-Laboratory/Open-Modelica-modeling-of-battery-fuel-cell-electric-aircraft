model fuelCellTest
  Modelica.Blocks.Sources.Constant p_air(k = 100000) annotation(
    Placement(transformation(origin = {-28, -12}, extent = {{-4, -4}, {4, 4}})));
  Modelica.Electrical.Analog.Sensors.MultiSensor meter annotation(
    Placement(transformation(origin = {30, -6}, extent = {{10, 10}, {-10, -10}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {0, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Math.Gain gain(k = 3) annotation(
    Placement(transformation(origin = {-47, -7}, extent = {{-3, -3}, {3, 3}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor c(C = 15000, T(fixed = true)) annotation(
    Placement(transformation(origin = {28, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation(
    Placement(transformation(origin = {12, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant h(k = 0.24) annotation(
    Placement(transformation(origin = {-18, 52}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambient(T(displayUnit = "K") = 293.15) annotation(
    Placement(transformation(origin = {12, 76}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  newFC fc annotation(
    Placement(transformation(origin = {0, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant p_H2(k = 250000)  annotation(
    Placement(transformation(origin = {-28, 10}, extent = {{-4, -4}, {4, 4}})));
  Modelica.Blocks.Sources.Ramp q(height = (1/600), duration = 60, offset = 1/600) annotation(
    Placement(transformation(origin = {-72, 0}, extent = {{-6, -6}, {6, 6}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 62.5) annotation(
    Placement(transformation(origin = {62, -10}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
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
    Line(points = {{-44, -7}, {-41.7, -7}, {-41.7, -15}, {-9.7, -15}}, color = {0, 0, 127}));
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
  connect(p_H2.y, fc.p_fuel) annotation(
    Line(points = {{-24, 10}, {-16, 10}, {-16, 4}, {-10, 4}}, color = {0, 0, 127}));
  connect(q.y, fc.q_fuel) annotation(
    Line(points = {{-65, 0}, {-10, 0}}, color = {0, 0, 127}));
  connect(q.y, gain.u) annotation(
    Line(points = {{-65, 0}, {-54, 0}, {-54, -7}, {-51, -7}}, color = {0, 0, 127}));
  connect(resistor.p, meter.pc) annotation(
    Line(points = {{62, 0}, {62, 12}, {48, 12}, {48, -6}, {40, -6}}, color = {0, 0, 255}));
  connect(resistor.n, fc.p) annotation(
    Line(points = {{62, -20}, {62, -26}, {0, -26}, {0, -16}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram);
end fuelCellTest;
