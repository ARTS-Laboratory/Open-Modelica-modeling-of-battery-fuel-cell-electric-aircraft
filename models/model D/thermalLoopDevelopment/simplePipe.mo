model mockFC
  extends Modelica.Thermal.FluidHeatFlow.BaseClasses.TwoPort;
  parameter Modelica.Units.SI.HeatFlowRate Qdot=1000;
  parameter Modelica.Units.SI.Pressure dP=0;
  parameter Modelica.Units.SI.HeatCapacity mcp = 35000;
  parameter Real nch = 78; // Number of channels
  parameter Modelica.Units.SI.Length Lch = 0.16; // Length of each channel
  parameter Modelica.Units.SI.Length Wch = 0.002; // Width of each channel
  parameter Modelica.Units.SI.Length Hch = 0.002; // Height of each channel
  parameter Modelica.Units.SI.Thickness th = 0.002; // Plate thickness (to bottom of channel)
  parameter Modelica.Units.SI.ThermalConductivity kplate = 24; // Thermal conductivity of cooling plate
  
  Real Re; // Reynolds number for each channel
  Real Nu; // Nusselt number
  Real Pr; // Prandtl number
  Real f; // Friction factor
  Modelica.Units.SI.CoefficientOfHeatTransfer hcool(start = 1100); // Convection coefficient
  Modelica.Units.SI.CoefficientOfHeatTransfer U(start = 250); // Overall heat transfer coefficient
  Real NTU(start = 3);
  Real effectiveness(start = 0.95);
  Modelica.Units.SI.Temperature T_fc(start=303.15);
  
protected
  parameter Modelica.Units.SI.Area Ach = Wch*Hch; // FLOW AREA of each channel
  parameter Modelica.Units.SI.Length Pch = 2 * (Wch + Hch); // Perimeter of each channel
  parameter Modelica.Units.SI.Length Dh = 4 * Ach / Pch; // Hydraulic diameter of each channel
  parameter Modelica.Units.SI.Area Aht = (Lch * Wch); // HEAT TRANSFER AREA of each channel
  
equation
  // Compute non-dimensional flow parameters
  // See Incropera Eq. 8.21 and 8.62 for f and Nu correlations
  Re = (flowPort_a.m_flow * Dh)/ (flowPort_a.medium.rho * nch * Ach * flowPort_a.medium.nu);
  f = 1/((0.79 * log(Re) - 1.64)^2);
  Pr = (flowPort_a.medium.cp * flowPort_a.medium.nu * flowPort_a.medium.rho) / (flowPort_a.medium.lambda);
  if Re < 2000 then
    Nu = 4.36;
  else
    Nu = ((f/8) * (Re - 1000) * Pr) / (1 + 12.7 * (sqrt(f/8)) * ((Pr^(2/3))-1));
  end if;
  
  // Compute convection coefficient
  hcool = (Nu * flowPort_a.medium.lambda * Pch) / (4 * 0.000004);
  
  // Compute overall heat transfer coefficient
  1 / U = (1 / hcool) + (th / kplate);
  
  // Compute NTUs
  NTU = (U * (nch * nch * Aht)) / (flowPort_a.medium.cp * flowPort_a.m_flow);
  
  // Compute heat transfer effectiveness
  effectiveness = 1 - exp(-NTU);
  
  dp = dP;
  Q_flow = Qdot - mcp * der(T_fc);
  effectiveness = (T_b - T_a) / (T_fc - T_a);
  
annotation(
    uses(Modelica(version = "4.1.0")));
end mockFC;