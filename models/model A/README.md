## Model A
# Fuel Cell Simplified Electrical Model
This repository contains a Modelica-based Fuel Cell model that replicates the Simscape Fuel Cell Simplified Electrical Model which can be found [here](https://www.mathworks.com/help/sps/ref/fuelcell.html). The model can also be found in the BFCEA library (as BFCEA.simpleFC).

![Simple FC in Simulink](media/Simple_FC.png)

The model is designed to be functionally equivalent to the Simscape version model. This repository includes simulation results showcasing the fuel cell's voltage and power output in both Simulink and Dymola, demonstrating the consistency and accuracy of the Modelica implementation.

### Voltage Output Comparison

<div style="display: flex; justify-content: space-between;">
  <div style="text-align: center; width: 45%;">
    <img src="media/Voltage_Output_of_Simple_FC.svg" alt="Voltage Output in Simulink" style="width:100%;">
    <p><strong>Simulink</strong> - Voltage output of the Fuel Cell model in Simulink.</p>
  </div>
  <div style="text-align: center; width: 45%;">
    <img src="media/Fuel_Cell_Simpilified_Electrical_Model_Voltage_output_in_Dymola.svg" alt="Voltage Output in Dymola" style="width:100%;">
    <p><strong>Dymola</strong> - Voltage output of the Fuel Cell model in Dymola.</p>
  </div>
</div>

### Power Output Comparison

<div style="display: flex; justify-content: space-between;">
  <div style="text-align: center; width: 45%;">
    <img src="media/Power_Output_of_Simple_FC.svg" alt="Power Output in Simulink" style="width:100%;">
    <p><strong>Simulink</strong> - Power output of the Fuel Cell model in Simulink.</p>
  </div>
  <div style="text-align: center; width: 45%;">
    <img src="media/Fuel_Cell_Simpilified_Electrical_Model_Power_output_in_Dymola.svg" alt="Power Output in Dymola" style="width:100%;">
    <p><strong>Dymola</strong> - Power output of the Fuel Cell model in Dymola.</p>
  </div>
</div>
