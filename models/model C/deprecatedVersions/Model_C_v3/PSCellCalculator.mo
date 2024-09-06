block PSCellCalculator "Calculator for the capacity, SOC, SOH,..."
  import ElectricEnergyStorages = ElectricalEnergyStorage;
  extends ElectricalEnergyStorage.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput i annotation(Placement(transformation(extent = {{-100, 10}, {-80, 30}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput SOC annotation(Placement(transformation(extent = {{100, 50}, {120, 70}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput SOH annotation(Placement(transformation(extent = {{100, -70}, {120, -50}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput C "Connector of Real output signal" annotation(Placement(transformation(extent = {{100, -30}, {120, -10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput cycles "Connector of Real output signal" annotation(Placement(transformation(extent = {{100, 10}, {120, 30}}, rotation = 0)));
  ElectricEnergyStorages.Batteries.Components.Calculators.SOC sOC(SOCini = SOCini) annotation(Placement(transformation(extent = {{70, 50}, {90, 70}}, rotation = 0)));
  ElectricEnergyStorages.Batteries.Components.Calculators.Capacity c(capacity = capacity) annotation(Placement(transformation(extent = {{20, -10}, {40, -30}}, rotation = 0)));
  ElectricEnergyStorages.Batteries.Components.Calculators.SOHSOS sOH(C0 = capacity.C0, Z0 = Z0, SoH = SoH) annotation(Placement(transformation(extent = {{72, -76}, {92, -56}}, rotation = 0)));
  ElectricEnergyStorages.Batteries.Components.Calculators.Qabs q(Qini = capacity.aging.Qini) annotation(Placement(transformation(extent = {{-20, 0}, {0, 20}}, rotation = 0)));
  ElectricEnergyStorages.Batteries.Components.Calculators.Cycles EquivalentCycles(C0 = capacity.C0, Qini = capacity.aging.Qini) annotation(Placement(transformation(extent = {{70, 10}, {90, 30}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput t annotation(Placement(transformation(extent = {{-100, -30}, {-80, -10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput T annotation(Placement(transformation(extent = {{-100, 50}, {-80, 70}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Z "Connector of Real input signal" annotation(Placement(transformation(extent = {{-100, -70}, {-80, -50}})));
  parameter Real SOCini "Initial state of charge";
  parameter Modelica.SIunits.Resistance Z0 "Sum of all initial ohmic impedances Rs0+Rd0[1]+...+Rd0[ns]";
  parameter
    ElectricalEnergyStorage.CellRecords.Components.ChargeCapacity
    capacity "Charge capacity";
  parameter
    ElectricalEnergyStorage.CellRecords.Components.SOH SoH
    "State of health relevant parameters";
equation
  connect(sOC.SOC, SOC) annotation(Line(points = {{91, 60}, {110, 60}}, color = {0, 0, 127}));
  connect(i, q.i) annotation(Line(points = {{-90, 20}, {-30, 20}, {-30, 10}, {-19, 10}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(i, sOC.i) annotation(Line(points = {{-90, 20}, {-30, 20}, {-30, 26}, {50, 26}, {50, 66}, {71, 66}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(EquivalentCycles.cycles, cycles) annotation(Line(points = {{91, 20}, {110, 20}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(q.Qabs, c.Qabs) annotation(Line(points = {{1, 10}, {10, 10}, {10, -14}, {21, -14}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(t, c.t) annotation(Line(points = {{-90, -20}, {-70, -20}, {-70, -26}, {21, -26}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(sOH.SOH, SOH) annotation(Line(points = {{93, -60}, {110, -60}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(i, EquivalentCycles.i) annotation(Line(points = {{-90, 20}, {-30, 20}, {-30, 26}, {71, 26}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(T, c.T) annotation(Line(points = {{-90, 60}, {-48, 60}, {-48, -20}, {21, -20}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(sOH.Z, Z) annotation(Line(points = {{73, -72}, {50, -72}, {50, -60}, {-90, -60}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(c.C, C) annotation(Line(points = {{41, -20}, {110, -20}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(c.C, sOH.C) annotation(Line(points = {{41, -20}, {60, -20}, {60, -60}, {73, -60}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(c.C, EquivalentCycles.C) annotation(Line(points = {{41, -20}, {60, -20}, {60, 14}, {71, 14}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(c.C, sOC.C) annotation(Line(points = {{41, -20}, {60, -20}, {60, 54}, {71, 54}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(graphics), Icon(graphics={  Text(extent = {{-86, 44}, {-46, 4}}, lineColor = {0, 0, 130}, textString = "i"), Text(extent = {{38, 0}, {90, -40}}, lineColor = {0, 0, 130}, textString = "C"), Text(extent = {{6, 80}, {86, 40}}, lineColor = {0, 0, 130}, textString = "SOC"), Text(extent = {{-12, 44}, {90, 2}}, lineColor = {0, 0, 130}, textString = "cycles"), Text(extent = {{0, -38}, {96, -78}}, lineColor = {0, 0, 130}, textString = "SOH"), Text(extent = {{-86, 82}, {-46, 42}}, lineColor = {0, 0, 130}, textString = "T"), Text(extent = {{-86, 6}, {-46, -34}}, lineColor = {0, 0, 130}, textString = "t"), Text(extent = {{-84, -40}, {-44, -80}}, lineColor = {0, 0, 130}, textString = "Z")}));
end PSCellCalculator;
