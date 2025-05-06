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
  parameter Real z = 2 "Electrons transferred in reaction";
  parameter Real x_O2 = 0.21 "Oxygen concentration in air";
  parameter Real x_H2 = 0.99 "Hydrogen concentration in fuel";
  parameter Real x_H2O = 0.01 "Vapor concentration in air";

// Variables
  Real U_O2 "Utilization rate O2";
  Real U_H2 "Utilization rate H2";
  Modelica.SIunits.Pressure p_O2 "Partial pressure O2 in cell";
  Modelica.SIunits.Pressure p_H2 "Partial pressure H2 in cell";
  Modelica.SIunits.Pressure p_H2O "Partial pressure water vapor in cell";
  
  Modelica.Electrical.Analog.Sources.SignalVoltage E_oc annotation(
    Placement(transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.MultiSensor meter annotation(
    Placement(transformation(origin = {-80, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin p annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n annotation(
    Placement(transformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage v_conc annotation(
    Placement(visible = true, transformation(origin = {18, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SignalVoltage v_act annotation(
    Placement(visible = true, transformation(origin = {-14, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.VariableResistor R_ohm annotation(
    Placement(visible = true, transformation(origin = {54, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  U_O2 = (meter.i*R*hp.T)/(2*z*F*p_air*q_air*x_O2);
  U_H2 = (meter.i*R*hp.T)/(z*F*p_fuel*q_fuel*x_H2);
  p_O2 = p_air*x_O2*(1 - U_O2);
  p_H2 = p_fuel*x_H2*(1 - U_H2);
  p_H2O = p_air*(x_H2O + 2*x_O2*U_O2);
// See Larminie & Dicks, 2003 and Laurencelle et. al. 2001
  if hp.T < 373.15 then
    E_oc.v = N*N_m*((1.228 - ((R*hp.T)/(z*F))*(log(p_H2O/(p_H2*(p_O2^0.5))) + log(101325^0.5))) + ((4.01e-2) - (1.4e-4)*(hp.T - 293.15))*log(0.00824));
  else
    E_oc.v = N*N_m*((1.228 - ((R*hp.T)/(z*F))*(log(1/(p_H2)*(p_O2^0.5)) + log(101325^1.5))) + ((4.01e-2) - (1.4e-4)*(hp.T - 293.15))*log(0.00824));
  end if;
// See Larminie & Dicks, 2003 and Laurencelle et. al., 2001
  if v_act.i <=0 then
    v_act.v = 0;
  elseif ((4.01e-2) - (1.4e-4)*(hp.T - 273.15))*log(v_act.i*(232/1000))>0 then
    v_act.v = N*N_m*(((4.01e-2) - (1.4e-4)*(hp.T - 273.15))*log(v_act.i*(232/1000)));
  else
    v_act.v = 0;
  end if;
// See Larminie & Dicks, 2003 and Laurencelle et. al., 2001
  if hp.T >= 312.15 then
    v_conc.v = N*N_m*(((1.1e-4) - (1.2e-6)*(hp.T - 273.15))*exp((8e-3)*(v_conc.i*(232/1000))));
  else
    v_conc.v = N*N_m*(((3.3e-3) - (8.2e-5)*(hp.T - 273.15))*exp((8e-3)*(v_conc.i*(232/1000))));
  end if;
// See Laurencelle et. al., 2001
  R_ohm.R = N*N_m*(((4.77e-4)-(3.32e-6)*(hp.T-273.15))*(1000/232));
  hp.T = 297.15;
//hp.Q_flow = -meter.power*((1.228*N)/(meter.v) - 1);
  connect(n, E_oc.n) annotation(
    Line(points = {{102, 0}, {90, 0}}, color = {0, 0, 255}));
  connect(meter.pv, p) annotation(
    Line(points = {{-80, 10}, {-94, 10}, {-94, 0}, {-100, 0}}, color = {0, 0, 255}));
  connect(meter.nv, n) annotation(
    Line(points = {{-80, -10}, {-80, -24}, {94, -24}, {94, 0}, {102, 0}}, color = {0, 0, 255}));
  connect(meter.pc, diode.n) annotation(
    Line(points = {{-70, 0}, {-60, 0}}, color = {0, 0, 255}));
  connect(meter.nc, p) annotation(
    Line(points = {{-90, 0}, {-100, 0}}, color = {0, 0, 255}));
  connect(v_act.p, v_conc.n) annotation(
    Line(points = {{-4, 0}, {8, 0}}, color = {0, 0, 255}));
  connect(v_act.n, diode.p) annotation(
    Line(points = {{-24, 0}, {-40, 0}}, color = {0, 0, 255}));
  connect(E_oc.p, R_ohm.p) annotation(
    Line(points = {{70, 0}, {64, 0}}, color = {0, 0, 255}));
  connect(R_ohm.n, v_conc.p) annotation(
    Line(points = {{44, 0}, {28, 0}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "3.2.3")),
    Diagram);
end detailedFC;