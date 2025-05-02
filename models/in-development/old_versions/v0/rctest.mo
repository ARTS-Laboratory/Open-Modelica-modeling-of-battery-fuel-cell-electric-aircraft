model rctest
  Modelica.Electrical.Analog.Basic.Capacitor ceq(C = 1/3)  annotation(
    Placement(transformation(origin = {0, 76}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrent1(I = 10, duration = 60) annotation(
    Placement(transformation(origin = {0, 48}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.MultiSensor meter_eq annotation(
    Placement(transformation(origin = {30, 64}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
    Placement(transformation(origin = {-18, 34}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor req(R = 3)  annotation(
    Placement(transformation(origin = {0, 92}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor r1(R = 1)  annotation(
    Placement(transformation(origin = {-38, 8}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Capacitor c1(C = 1)  annotation(
    Placement(transformation(origin = {-38, -8}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrent(I = 10, duration = 60)  annotation(
    Placement(transformation(origin = {-20, -36}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor r2(R = 1)  annotation(
    Placement(transformation(origin = {22, 8}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Capacitor c2(C = 1)  annotation(
    Placement(transformation(origin = {22, -8}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {-38, -52}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.MultiSensor meter annotation(
    Placement(transformation(origin = {122, -24}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Resistor r3(R = 1)  annotation(
    Placement(transformation(origin = {94, 8}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Capacitor c3(C = 1)  annotation(
    Placement(transformation(origin = {94, -8}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.MultiSensor multi1 annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Sensors.MultiSensor multi2 annotation(
    Placement(transformation(origin = {-6, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Electrical.Analog.Sensors.MultiSensor multi3 annotation(
    Placement(transformation(origin = {62, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
equation
  connect(ground1.p, rampCurrent1.p) annotation(
    Line(points = {{-18, 44}, {-18, 48}, {-10, 48}}, color = {0, 0, 255}));
  connect(ceq.p, rampCurrent1.p) annotation(
    Line(points = {{-10, 76}, {-16, 76}, {-16, 82}, {-22, 82}, {-22, 48}, {-10, 48}}, color = {0, 0, 255}));
  connect(meter_eq.pc, rampCurrent1.n) annotation(
    Line(points = {{30, 54}, {30, 48}, {10, 48}}, color = {0, 0, 255}));
  connect(meter_eq.nc, ceq.n) annotation(
    Line(points = {{30, 74}, {30, 82}, {16, 82}, {16, 76}, {10, 76}}, color = {0, 0, 255}));
  connect(meter_eq.nv, rampCurrent1.p) annotation(
    Line(points = {{20, 64}, {-18, 64}, {-18, 48}, {-10, 48}}, color = {0, 0, 255}));
  connect(meter_eq.pv, rampCurrent1.n) annotation(
    Line(points = {{40, 64}, {50, 64}, {50, 48}, {10, 48}}, color = {0, 0, 255}));
  connect(req.p, rampCurrent1.p) annotation(
    Line(points = {{-10, 92}, {-16, 92}, {-16, 82}, {-22, 82}, {-22, 48}, {-10, 48}}, color = {0, 0, 255}));
  connect(meter_eq.nc, req.n) annotation(
    Line(points = {{30, 74}, {30, 82}, {16, 82}, {16, 92}, {10, 92}}, color = {0, 0, 255}));
  connect(ground.p, rampCurrent.p) annotation(
    Line(points = {{-38, -42}, {-38, -36}, {-30, -36}}, color = {0, 0, 255}));
  connect(c2.n, r2.n) annotation(
    Line(points = {{32, -8}, {38, -8}, {38, 8}, {32, 8}}, color = {0, 0, 255}));
  connect(meter.nv, rampCurrent.p) annotation(
    Line(points = {{112, -24}, {-38, -24}, {-38, -36}, {-30, -36}}, color = {0, 0, 255}));
  connect(r3.n, c3.n) annotation(
    Line(points = {{104, 8}, {110, 8}, {110, -8}, {104, -8}}, color = {0, 0, 255}));
  connect(meter.nc, r3.n) annotation(
    Line(points = {{122, -14}, {122, 0}, {110, 0}, {110, 8}, {104, 8}}, color = {0, 0, 255}));
  connect(meter.pc, rampCurrent.n) annotation(
    Line(points = {{122, -34}, {55, -34}, {55, -36}, {-10, -36}}, color = {0, 0, 255}));
  connect(meter.pv, rampCurrent.n) annotation(
    Line(points = {{132, -24}, {132, -36}, {-10, -36}}, color = {0, 0, 255}));
  connect(meter.nc, c3.n) annotation(
    Line(points = {{122, -14}, {122, 0}, {110, 0}, {110, -8}, {104, -8}}, color = {0, 0, 255}));
  connect(multi1.pc, r1.p) annotation(
    Line(points = {{-60, 0}, {-56, 0}, {-56, 8}, {-48, 8}}, color = {0, 0, 255}));
  connect(c1.p, multi1.pc) annotation(
    Line(points = {{-48, -8}, {-56, -8}, {-56, 0}, {-60, 0}}, color = {0, 0, 255}));
  connect(multi1.nc, rampCurrent.p) annotation(
    Line(points = {{-80, 0}, {-86, 0}, {-86, -36}, {-30, -36}}, color = {0, 0, 255}));
  connect(multi1.nv, r1.p) annotation(
    Line(points = {{-70, -10}, {-70, -16}, {-56, -16}, {-56, 8}, {-48, 8}}, color = {0, 0, 255}));
  connect(multi1.pv, r1.n) annotation(
    Line(points = {{-70, 10}, {-70, 16}, {-24, 16}, {-24, 8}, {-28, 8}}, color = {0, 0, 255}));
  connect(multi2.nc, r1.n) annotation(
    Line(points = {{-16, 0}, {-24, 0}, {-24, 8}, {-28, 8}}, color = {0, 0, 255}));
  connect(multi2.nc, c1.n) annotation(
    Line(points = {{-16, 0}, {-24, 0}, {-24, -8}, {-28, -8}}, color = {0, 0, 255}));
  connect(multi2.pc, r2.p) annotation(
    Line(points = {{4, 0}, {6, 0}, {6, 8}, {12, 8}}, color = {0, 0, 255}));
  connect(c2.p, multi2.pc) annotation(
    Line(points = {{12, -8}, {6, -8}, {6, 0}, {4, 0}}, color = {0, 0, 255}));
  connect(multi2.nv, r2.p) annotation(
    Line(points = {{-6, -10}, {-6, -14}, {6, -14}, {6, 8}, {12, 8}}, color = {0, 0, 255}));
  connect(multi2.pv, r2.n) annotation(
    Line(points = {{-6, 10}, {-6, 16}, {38, 16}, {38, 8}, {32, 8}}, color = {0, 0, 255}));
  connect(multi3.pv, r3.n) annotation(
    Line(points = {{62, 10}, {62, 16}, {110, 16}, {110, 8}, {104, 8}}, color = {0, 0, 255}));
  connect(multi3.nv, c3.p) annotation(
    Line(points = {{62, -10}, {62, -14}, {78, -14}, {78, -8}, {84, -8}}, color = {0, 0, 255}));
  connect(multi3.nc, r2.n) annotation(
    Line(points = {{52, 0}, {38, 0}, {38, 8}, {32, 8}}, color = {0, 0, 255}));
  connect(multi3.pc, r3.p) annotation(
    Line(points = {{72, 0}, {78, 0}, {78, 8}, {84, 8}}, color = {0, 0, 255}));
  connect(c3.p, multi3.pc) annotation(
    Line(points = {{84, -8}, {78, -8}, {78, 0}, {72, 0}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")));
end rctest;
