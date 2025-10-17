model simpleHEX
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium1=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium2=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  parameter Modelica.Units.SI.Temperature fluid1_T0 "Initial temperature fluid 1";
  parameter Modelica.Units.SI.Temperature fluid2_T0 "Initial temperature fluid 2";
  parameter Boolean T0fixed = false 
    "Initial temperature guess or fixed"
    annotation(choices(checkBox=true));
  parameter Modelica.Units.SI.PressureDifference fluid1_dp = 0;
  parameter Modelica.Units.SI.PressureDifference fluid2_dp = 0;
  parameter Real epsilon=0.95 "Heat exchanger effectiveness";

  output Modelica.Units.SI.Temperature T1(start=fluid1_T0, fixed=T0fixed);
  output Modelica.Units.SI.Temperature T2(start=fluid2_T0, fixed=T0fixed);
  output Modelica.Units.SI.Temperature T_1a(start=fluid1_T0) "Temperature at port fluid1_a";
  output Modelica.Units.SI.Temperature T_1b(start=fluid1_T0) "Temperature at port fluid1_b";
  output Modelica.Units.SI.Temperature T_2a(start=fluid2_T0) "Temperature at port fluid2_a";
  output Modelica.Units.SI.Temperature T_2b(start=fluid2_T0) "Temperature at port fluid2_b";
  
  // Not sure about these...
  Modelica.Units.SI.VolumeFlowRate fluid1_Vflow(start=0) "Fluid 1 volume flow a->b";
  Modelica.Units.SI.VolumeFlowRate fluid2_Vflow(start=0) "Fluid 2 volume flow a->b";

protected
  Modelica.Units.SI.SpecificEnthalpy fluid1_h(start=medium1.cp*fluid1_T0);
  Modelica.Units.SI.SpecificEnthalpy fluid2_h(start=medium2.cp*fluid2_T0);
  
public
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a fluid1_a(final medium=medium1) annotation(
    Placement(transformation(origin = {0, 98}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 98}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a fluid2_a(final medium=medium2) annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b fluid2_b(final medium=medium2) annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b fluid1_b(final medium=medium1) annotation(
    Placement(transformation(origin = {-2, -96}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-2, -96}, extent = {{-10, -10}, {10, 10}})));

equation
  
  fluid1_dp = fluid1_a.p - fluid1_b.p;
  fluid2_dp = fluid2_a.p - fluid2_b.p; 

  fluid1_Vflow = fluid1_a.m_flow/medium1.rho;
  fluid2_Vflow = fluid2_a.m_flow/medium2.rho;

  T_1a = fluid1_a.h/medium1.cp;
  T_1b = fluid1_b.h/medium1.cp;
  T_2a = fluid2_a.h/medium2.cp;
  T_2b = fluid2_b.h/medium2.cp;

  fluid1_h = medium1.cp*T1;
  fluid2_h = medium2.cp*T2;
  
  // mass balance
  fluid1_a.m_flow + fluid1_b.m_flow = 0;
  fluid2_a.m_flow + fluid2_b.m_flow = 0;
  
  // energy balance
  fluid1_a.H_flow + fluid1_b.H_flow = fluid2_a.H_flow + fluid2_b.H_flow;
  
  // mass flow a->b mixing rule at a, energy flow at b defined by medium's temperature
  // mass flow b->a mixing rule at b, energy flow at a defined by medium's temperature
  fluid1_a.H_flow = semiLinear(fluid1_a.m_flow,fluid1_a.h,fluid1_h);
  fluid1_b.H_flow = semiLinear(fluid1_b.m_flow,fluid1_b.h,fluid1_h);
  fluid2_a.H_flow = semiLinear(fluid2_a.m_flow,fluid2_a.h,fluid2_h);
  fluid2_b.H_flow = semiLinear(fluid2_b.m_flow,fluid2_b.h,fluid2_h);
  
  // Effectiveness of the HEX (for a counterflow HEX)
  // See Incropera section 11.4, page 722
  epsilon * (min(medium1.cp * abs(fluid1_a.m_flow),medium2.cp * abs(fluid2_a.m_flow)) * (T_1a - T_2a)) = 
    (medium1.cp * abs(fluid1_a.m_flow) * (T_1a - T_1b));

annotation(
    uses(Modelica(version = "4.1.0")));
end simpleHEX;