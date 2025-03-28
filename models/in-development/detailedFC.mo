model detailedFC
  // Constants
  constant Real R = Modelica.Constants.R;
  constant Real F = Modelica.Constants.F;

  // Exernal Ports
  Modelica.Blocks.Interfaces.RealInput q_air "air flow rate (m^3/s)" annotation(
    Placement(transformation(origin = {-90, 108}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-90, 108}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput p_air "air pressure (Pa)" annotation(
    Placement(transformation(origin = {-60, 108}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-60, 108}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput p_fuel "fuel pressure (Pa)" annotation(
    Placement(transformation(origin = {90, 108}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {90, 108}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput q_fuel "fuel flow rate (m^3/s)"annotation(
    Placement(transformation(origin = {60, 108}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {60, 108}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a hp annotation(
    Placement(transformation(origin = {-8, -100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-8, -100}, extent = {{-10, -10}, {10, 10}})));

// Parameters
  // May work out equations for some of these
  // See textbook for definitions
  parameter Real N = 65 "Number of cells in series per module";
  parameter Real N_m = 10 "Number of modules";
  parameter Modelica.Units.SI.Current i_0 = 80 "Exchange current (A)";
  parameter Real alpha = 0.5 "Charge transfer coefficient";
  parameter Modelica.Units.SI.Resistance R_i = 0.05 "Internal ohmic resistance (Ohms)";
  parameter Modelica.Units.SI.Current i_lim = 200 "Collapse current (A)";
  parameter Modelica.Units.SI.Capacitance C = 0.01 "Double layer capacitance (F)";
  parameter Real z = 2 "Electrons transferred in reaction";
  parameter Real x_O2 = 0.21 "Oxygen concentration in air";
  parameter Real x_H2 = 0.99 "Hydrogen concentration in fuel";
  parameter Real x_H2O = 0.01 "Vapor concentration in air";

// Variables
  Real U_O2 "Utilization rate O2";
  Real U_H2 "Utilization rate H2";
  Modelica.Units.SI.Pressure p_O2 "Partial pressure O2 in cell";
  Modelica.Units.SI.Pressure p_H2 "Partial pressure H2 in cell";
  Modelica.Units.SI.Pressure p_H2O "Partial pressure water vapor in cell";
  
  Modelica.Electrical.Analog.Sources.SignalVoltage E_oc annotation(
    Placement(transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.MultiSensor meter annotation(
    Placement(transformation(origin = {-80, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin p annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n annotation(
    Placement(transformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor R_ohm(R = N_m*N*R_i) annotation(
    Placement(transformation(origin = {52, 0}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage v_act annotation(
    Placement(transformation(origin = {-12, 12}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage v_conc annotation(
    Placement(transformation(origin = {18, 12}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Electrical.Analog.Basic.Capacitor C_dl(C = C/(N_m*N))  annotation(
    Placement(transformation(origin = {2, -10}, extent = {{-10, -10}, {10, 10}})));
equation
  U_O2 = (meter.i*R*293.15)/(2*z*F*p_air*q_air*x_O2);
  U_H2 = (meter.i*R*293.15)/(z*F*p_fuel*q_fuel*x_H2);
  
  p_O2 = (p_air*x_O2*(1 - U_O2));
  p_H2 = (p_fuel*x_H2*(1 - U_H2));
  p_H2O = (p_air*(x_H2O + 2*x_O2*U_O2));
  
  if hp.T < 373.15 then
    E_oc.v = N_m*N*(1.228 - ((R*293.15)/(z*F))*(log(p_H2O/(p_H2*(p_O2^0.5))) + log(101325^0.5)));
  else
    E_oc.v = N_m*N*(1.228 - ((R*293.15)/(z*F))*(log(1/(p_H2)*(p_O2^0.5)) + log(101325^1.5)));
  end if;
  
  if v_act.i > i_0 then
    v_act.v = N_m*N*(0.23)*log(v_act.i/i_0);
  else
    v_act.v = 0;
  end if;
  v_conc.v = N_m*N*((R*293.15)/(z*F)*log(i_lim/(i_lim - v_conc.i)));
  
  hp.Q_flow = -meter.power*((1.228*N)/(meter.v) - 1);
  connect(n, E_oc.n) annotation(
    Line(points = {{102, 0}, {90, 0}}, color = {0, 0, 255}));
  connect(meter.pv, p) annotation(
    Line(points = {{-80, 10}, {-94, 10}, {-94, 0}, {-100, 0}}, color = {0, 0, 255}));
  connect(meter.nv, n) annotation(
    Line(points = {{-80, -10}, {-80, -24}, {94, -24}, {94, 0}, {102, 0}}, color = {0, 0, 255}));
  connect(E_oc.p, R_ohm.p) annotation(
    Line(points = {{70, 0}, {62, 0}}, color = {0, 0, 255}));
  connect(meter.pc, diode.n) annotation(
    Line(points = {{-70, 0}, {-60, 0}}, color = {0, 0, 255}));
  connect(meter.nc, p) annotation(
    Line(points = {{-90, 0}, {-100, 0}}, color = {0, 0, 255}));
  connect(v_conc.p, R_ohm.n) annotation(
    Line(points = {{28, 12}, {36, 12}, {36, 0}, {42, 0}}, color = {0, 0, 255}));
  connect(v_conc.n, v_act.p) annotation(
    Line(points = {{8, 12}, {-2, 12}}, color = {0, 0, 255}));
  connect(v_act.n, diode.p) annotation(
    Line(points = {{-22, 12}, {-30, 12}, {-30, 0}, {-40, 0}}, color = {0, 0, 255}));
  connect(C_dl.n, R_ohm.n) annotation(
    Line(points = {{12, -10}, {36, -10}, {36, 0}, {42, 0}}, color = {0, 0, 255}));
  connect(C_dl.p, diode.p) annotation(
    Line(points = {{-8, -10}, {-30, -10}, {-30, 0}, {-40, 0}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram);
end detailedFC;
