model Model_B_v2
  PowerSystems.AC1ph_DC.Sources.DCvoltage voltage1(pol = 0, puUnits = false, use_vDC_in = true) annotation (
    Placement(visible = true, transformation(origin = {-196, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Nodes.GroundOne ground annotation (
    Placement(visible = true, transformation(origin = {-228, 14}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Sensors.PVImeter fcMeter( puUnits = false) annotation (
    Placement(visible = true, transformation(origin = {-166, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BFCEA.simpleFC fc annotation (
    Placement(visible = true, transformation(origin = {-194, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Inverters.InverterAverage inverter(redeclare record Data =
        PowerSystems.Examples.Data.Semiconductors.IdealSC100V_10A)                                                                         annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Common.Thermal.BdCondV bdCond annotation (
    Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Inverters.Select select annotation (
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Blocks.Signals.TransientPhasor phasor annotation (
    Placement(visible = true, transformation(origin = {-22, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner PowerSystems.System system annotation (
    Placement(visible = true, transformation(origin = {-2, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Sensors.PVImeter ACMeter(puUnits = false) annotation (
    Placement(visible = true, transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Sources.PQsource pQsource1(pq0 = {10000, 0}, puUnits = false, use_pq_in = true) annotation (
    Placement(visible = true, transformation(origin = {60, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_up(duration = 30, height = -9900, offset = -100, startTime = 600)  annotation (
    Placement(visible = true, transformation(origin = {38, 66}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Blocks.Sources.Step step(height = 4000, startTime = 690)  annotation (
    Placement(visible = true, transformation(origin = {54, 80}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Blocks.Math.Add3 add annotation (
    Placement(visible = true, transformation(origin = {54, 26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Ramp ramp_down(duration = 30, height = 5900, startTime = 3090)  annotation (
    Placement(visible = true, transformation(origin = {70, 68}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  PowerSystems.AC1ph_DC.Nodes.BusBar bus annotation (
    Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-28, -26}, {28, 26}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Sensors.PVImeter busMeter annotation (
    Placement(visible = true, transformation(origin = {-28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Sensors.PVImeter boostedFCMeter annotation (
    Placement(visible = true, transformation(origin = {-110, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Inverters.ChopperAverage fcBooster annotation (
    Placement(visible = true, transformation(origin = {-138, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Common.Thermal.BdCondV bdCond1 annotation (
    Placement(visible = true, transformation(origin = {-138, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Blocks.Signals.Transient transSig1(s_end = 2, s_start = 0, t_change = 0, t_duration = 0.001)  annotation (
    Placement(visible = true, transformation(origin = {-132, 64}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
// Piecewise definition of i_FC
  if time == 0 then
    fc.i_FC = fc.epsilon;
  else
    fc.i_FC = fcMeter.i;
  end if;
  voltage1.vDC_in = fc.v_FC;
  connect(ground.term, voltage1.neutral) annotation (
    Line(points = {{-218, 14}, {-206, 14}}, color = {0, 0, 255}));
  connect(voltage1.term, fcMeter.term_p) annotation (
    Line(points = {{-186, 14}, {-176, 14}}, color = {0, 0, 255}));
  connect(bdCond.heat, inverter.heat) annotation (
    Line(points = {{0, 10}, {0, 10}}, color = {176, 0, 0}));
  connect(select.theta_out, inverter.theta) annotation (
    Line(points = {{-6, 22}, {-6, 10}}, color = {0, 0, 127}));
  connect(select.vPhasor_out, inverter.vPhasor) annotation (
    Line(points = {{6, 22}, {6, 10}}, color = {0, 0, 127}, thickness = 0.5));
  connect(phasor.y, select.vPhasor_in) annotation (
    Line(points = {{-12, 60}, {6, 60}, {6, 42}}, color = {0, 0, 127}, thickness = 0.5));
  connect(ACMeter.term_p, inverter.AC) annotation (
    Line(points = {{18, 0}, {10, 0}}, color = {0, 120, 120}));
  connect(pQsource1.term, ACMeter.term_n) annotation (
    Line(points = {{50, 0}, {38, 0}}, color = {0, 120, 120}));
  pQsource1.pq_in[2] = 0;
  connect(pQsource1.pq_in[1], add.y) annotation (
    Line(points = {{54, 10}, {54, 16}}, color = {0, 0, 127}));
  connect(ramp_down.y, add.u1) annotation (
    Line(points = {{70, 62}, {70, 50}, {62, 50}, {62, 38}}, color = {0, 0, 127}));
  connect(step.y, add.u2) annotation (
    Line(points = {{54, 74}, {54, 38}}, color = {0, 0, 127}));
  connect(ramp_up.y, add.u3) annotation (
    Line(points = {{38, 60}, {38, 52}, {46, 52}, {46, 38}}, color = {0, 0, 127}));
  connect(busMeter.term_n, inverter.DC) annotation (
    Line(points = {{-18, 0}, {-10, 0}}, color = {0, 0, 255}));
  connect(busMeter.term_p, bus.term) annotation (
    Line(points = {{-38, 0}, {-60, 0}}, color = {0, 0, 255}));
  connect(boostedFCMeter.term_n, bus.term) annotation (
    Line(points = {{-100, 14}, {-85, 14}, {-85, 0}, {-60, 0}}));
  connect(fcBooster.DCout, boostedFCMeter.term_p) annotation (
    Line(points = {{-128, 14}, {-120, 14}}, color = {0, 0, 255}));
  connect(fcBooster.DCin, fcMeter.term_n) annotation (
    Line(points = {{-148, 14}, {-156, 14}}, color = {0, 0, 255}));
  connect(bdCond1.heat, fcBooster.heat) annotation (
    Line(points = {{-138, 26}, {-138, 24}}, color = {176, 0, 0}));
  connect(transSig1.y, fcBooster.uDC) annotation (
    Line(points = {{-132, 54}, {-132, 24}}, color = {0, 0, 127}));
  annotation (
    uses(PowerSystems(version="2.0.0"),
      Modelica(version="4.0.0")),
    Diagram(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
    version="1",
    Icon(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
    conversion(noneFromVersion=""));
end Model_B_v2;
