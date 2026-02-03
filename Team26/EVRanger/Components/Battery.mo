within EVRanger.Components;

package Battery
  extends EVRanger.Icons.BatterySymb;

model Battery



  import EVRanger.Interfaces.ElectricalPort;
  import EVRanger.Functions.*;
  import EVRanger.Components.Battery.Records.BatteryParams;
  import EVRanger.Components.Battery.BatteryTypes.*;
  import EVRanger.Components.Battery.BatteryOperationModeTypes;
  import EVRanger.Components.Battery.BatterySelectionTypes.BatterySelection;
 

  parameter BatterySelection batteryType = BatterySelection.LFP_60kWh "Select                    battery type";
  
  parameter BatteryParams batt =
  if batteryType == BatterySelection.NMC_60kWh then
    BatteryTypes.NMC_60kWh
  elseif batteryType == BatterySelection.LFP_60kWh then
    BatteryTypes.LFP_60kWh
  else
    BatteryTypes.SolidState_60kWh;
    
  //Battery operation mode
  parameter BatteryOperationModeTypes.BatteryOperationMode operationMode = BatteryOperationModeTypes.BatteryOperationMode.Normal "Select Battery operating mode";
  
  parameter Real SOH_init = if operationMode == BatteryOperationModeTypes.BatteryOperationMode.Normal then 1.0 else 0.4 "Initial state of health (1 = 100%)";
  
  Integer[3] modeColor = if operationMode == BatteryOperationModeTypes.BatteryOperationMode.Normal then {0, 160, 0} else {220, 140, 0};
  
  // Assign parameters from selected battery
  parameter Real R_int = batt.R_int;
  parameter Real Q_nom = batt.Q_nom;
  parameter Real beta_degrad = batt.beta_degrad;
  parameter Real degradation_rate = batt.degradation_rate;
  parameter Real m_batt = batt.m_batt;
  parameter Real c_p = batt.c_p;
  parameter Real h = batt.h;
  parameter Real A = batt.A;
  
  // Common parameters
  parameter Real T_ref = 25 "Reference temperature (°C)";
  parameter Real T_amb = 25 "Ambient temperature (°C)";
  parameter Real SOC_min = 0.05 "Minimum SOC";
  parameter Real SOC_max = 1.0 "Maximum SOC";
  
  // State variables
  Real SOC(start = 0.8, min = 0, max = 1) "State of Charge";
  Real SOH(start = SOH_init, min = 0, max = 1) "State of Health";
  Real T(start = T_ref) "Battery temperature (°C)";
  Real I_batt "Battery current (A)";
  Real V_t "Terminal voltage (V)";
  Real V_oc "Open-circuit voltage (V)";
  Real R_int_T "Temperature-adjusted resistance";
  Real Q_gen "Generated heat (W)";
  Real Q_loss "Heat loss (W)";
  Real Q_eff "Effective capacity";
  Real SOC_out;
  
  output Real T_out;
  output Real SOH_out;
  output Real R_int_factor;
  
  EVRanger.Interfaces.ElectricalPort electricalPortOut annotation(
    Placement(visible = true, transformation(origin = {68, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {18, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output EVRanger.Interfaces.BatteryAvailableSignal batteryAvailableSignal annotation(
    Placement(visible = true, transformation(origin = {84, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-18, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation

  I_batt = electricalPortOut.I;
  electricalPortOut.V = V_t;
  
  R_int_factor = R_int_temp_factor(T);
  R_int_T = R_int*R_int_factor*(if SOC > SOC_min and SOC < SOC_max then 1 else 1e6);
  
  Q_eff = Q_nom_temp(T, Q_nom);
  
  V_oc = OCV_from_SOC(SOC);
  
  V_t = V_oc - R_int_T*I_batt;
  
  der(SOC) = if SOC > SOC_min and SOC < SOC_max then -I_batt/(Q_eff*SOH) else 0;
  
  der(SOH) = if SOC > SOC_min and SOC < SOC_max and abs(I_batt) > 0 then -degradation_rate*abs(I_batt)*exp(beta_degrad*(T - T_ref)) else 0;
  
  Q_gen = I_batt^2*R_int_T;
  Q_loss = h*A*(T - T_amb);
  
  der(T) = if SOC > 0 then (Q_gen - Q_loss)/(m_batt*c_p) else 0;
  
  SOC_out = SOC;
  T_out = T;
  SOH_out = SOH;
  
  batteryAvailableSignal.batteryAvailable = if SOC <= SOC_min then false else true;
  
// green
// orange
  annotation(
    Icon(graphics = {Rectangle(origin = {1, 0}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-53, 32}, {53, -32}}), Rectangle(origin = {1, 38}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-59, 4}, {59, -4}}), Rectangle(origin = {-35, 45}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-7, 3}, {7, -3}}), Rectangle(origin = {-35, 51}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-3, 1}, {3, -1}}), Rectangle(origin = {35, 45}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-7, 3}, {7, -3}}), Rectangle(origin = {35, 51}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-3, 1}, {3, -1}}), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 22}, {40, -22}}), Ellipse(origin = {21, 1}, fillPattern = FillPattern.Solid, extent = {{-9, 9}, {9, -9}}, endAngle = 360), Ellipse(origin = {-23, 1}, fillPattern = FillPattern.Solid, extent = {{-9, 9}, {9, -9}}, endAngle = 360), Text(origin = {-22, 2}, lineColor = {255, 255, 255}, extent = {{-16, 10}, {16, -10}}, textString = "+", textStyle = {TextStyle.Bold}), Text(origin = {22, 3}, lineColor = {255, 255, 255}, extent = {{-34, 13}, {34, -13}}, textString = "-", textStyle = {TextStyle.Bold}), Rectangle(origin = {1, -39}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-59, 5}, {59, -5}}), Text(origin = {-48, -55}, extent = {{-10, 5}, {10, -5}}, textString = "output"), Ellipse(origin = {-46, 24}, lineColor = DynamicSelect({0, 160, 0}, modeColor), fillColor = DynamicSelect({0, 160, 0}, modeColor), fillPattern = FillPattern.Solid, extent = {{-6, 6}, {6, -6}}, endAngle = 360)}),
    Diagram(graphics),
    //Documentation(info = "<html><head></head><body>This is a great battery</body></html>")
    Documentation(info = "<html><head></head><body><h4><b>Description</b></h4><div><b><br></b></div><div>This model represents a rechargeable battery with selectable chemistries (NMC, LFP, or Solid State). It simulates the electrical and thermal behavior of the battery, including key characteristics such as internal resistance, state of charge (SOC), state of health (SOH), temperature effects, and degradation over time.&nbsp;</div><div>The battery is controlled through the current demand and accounts for operating modes that affect initial health.</div><div><br></div><div><b>Adjustable Parameter</b></div><div><ul><li>batteryType: Selects battery chemistry (NMC, LFP, Solid State).</li><li>operationMode: Battery operating mode affecting initial SOH (Normal or Reduced SOH).</li><li>R_int: Internal resistance [Ohm].</li><li>Q_nom: Nominal capacity [Coulombs].</li><li><!--StartFragment--><span data-start=\"937\" data-end=\"953\">beta_degrad:</span> Temperature sensitivity of aging [1/K].<!--EndFragment-->&nbsp;&nbsp;</li><li><!--StartFragment--><span data-start=\"998\" data-end=\"1019\">degradation_rate:</span> Health degradation rate [1/C].<!--EndFragment-->&nbsp;</li><li>&nbsp;<span data-start=\"1055\" data-end=\"1066\">m_batt:</span> Battery mass [kg].<!--EndFragment--></li><li><!--StartFragment--><span data-start=\"1090\" data-end=\"1098\">c_p:</span> Specific heat capacity [J/(kg·K)].<!--EndFragment-->&nbsp;&nbsp;</li><li><!--StartFragment--><span data-start=\"1138\" data-end=\"1144\">h:</span> Heat transfer coefficient [W/(m²·K)].<!--EndFragment--></li><li><!--StartFragment--><span data-start=\"1187\" data-end=\"1193\">A:</span> Surface area [m²].</li><li><!--EndFragment--><!--StartFragment--><span data-start=\"1217\" data-end=\"1227\">T_ref:</span> Reference temperature [°C].<!--EndFragment-->&nbsp;</li><li><!--StartFragment--><span data-start=\"1260\" data-end=\"1270\">T_amb:</span> Ambient temperature [°C].<!--EndFragment-->&nbsp;</li><li><!--StartFragment--><span data-start=\"1301\" data-end=\"1313\">SOC_min:</span> Minimum state of charge.<!--EndFragment-->&nbsp;&nbsp;&nbsp;</li><li><!--StartFragment--><span data-start=\"1343\" data-end=\"1355\">SOC_max:</span> Maximum state of charge.<!--EndFragment-->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li></ul></div><div><b>Process</b></div><div><br></div><div>1. Battery electrical behavior</div><!--StartFragment--><!--EndFragment-->

<div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>

<!--StartFragment-->The model calculates terminal voltage by subtracting the voltage drop due to internal resistance from the open-circuit voltage, which depends on the state of charge:</div><div><div><span class=\"Apple-tab-span\" style=\"white-space: pre;\">							</span><i>V_t = V_oc - R_int,T · I_batt</i></div><div><span class=\"Apple-tab-span\" style=\"white-space: pre;\">	</span>Internal resistance varies with temperature and state of charge.</div><div><br></div><div>2. State of Charge (SOC) and Health (SOH) dynamics</div></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>SOC changes with battery current considering effective capacity and health. SOH degrades over time based on current load and temperature:</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">							</span><i>dSOC/dt = -I_batt / (Q_eff · SOH)</i></div><div><i>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dt = -degradation_rate · |I_batt| · exp(β_degrad · (T - T_ref))</i></div><div><br></div><div>3. Thermal model</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Heat generated by internal resistance and losses to ambient affect battery temperature:</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">							</span><i>Q_gen = I_batt² · R_int,T,  Q_loss = h · A · (T - T_amb)</i></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>The temperature changes based on heat generation and loss.</div><div><br></div><div>4. Battery availability</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>The battery is considered available if SOC is above the minimum threshold; otherwise, output signals reflect unavailability.</div><div><br></div><div><b>Limitations</b></div><div><ul><li>Simplified thermal model assumes uniform temperature.</li><li>Complex electrochemical dynamics and aging mechanisms are approximated.</li><li>Temperature effects on parameters are modeled but do not cover all real-world phenomena.</li><li>No explicit modeling of charging protocols or fast charge effects.</li></ul></div><div><b>Assumptions</b></div><div><ul><li>Battery chemistry parameters are constant and predefined for selected types.</li><li>Battery operates within specified SOC limits.</li><li>Internal resistance and capacity vary with temperature and state of charge as modeled.</li><li>Degradation depends primarily on current load and temperature.</li></ul></div><div><b>Literature</b></div></body></html>"));
end Battery;

  package Records
    record BatteryParams
      parameter Modelica.Units.SI.Resistance R_int "Internal resistance";
      parameter Modelica.Units.SI.ElectricCharge Q_nom "Nominal capacity";
      parameter Real beta_degrad "Temperature sensitivity of aging (1/K)";
      parameter Real degradation_rate "SOH degradation rate (1/C)";
      parameter Modelica.Units.SI.Mass m_batt "Battery mass";
      parameter Modelica.Units.SI.SpecificHeatCapacity c_p "Specific heat capacity";
      parameter Modelica.Units.SI.CoefficientOfHeatTransfer h "Heat transfer coefficient";
      parameter Modelica.Units.SI.Area A "Surface area";
    end BatteryParams;
  end Records;

  //within EVRanger.Components.Battery2;
  //within EVRanger.Components.Battery2;
  //within EVRanger.Components.Battery2;

  package BatteryTypes
    import EVRanger.Components.Battery.Records.BatteryParams;
    
    //~400 V arch - NMC
    constant BatteryParams NMC_60kWh(R_int = 0.03, Q_nom = (60000/400)*3600,  // 150 Ah * 3600 = 540,000 C
    beta_degrad = 0.10, degradation_rate = 5e-8, m_batt = 343,  // 60000 Wh / 175 Wh/kg = ~343 kg
    c_p = 900, h = 8, A = 3.0);
    
    //~320 V arch - LFP
    constant BatteryParams LFP_60kWh(R_int = 0.05, Q_nom = (60000/320)*3600,  // 187.5 Ah * 3600 = 675,000 C
    beta_degrad = 0.05, degradation_rate = 2e-8, m_batt = 414,  // 60000 Wh / 145 Wh/kg = ~414 kg
    c_p = 920, h = 7, A = 3.2);
    
    //~400 V arch - SolidState (projected)
    constant BatteryParams SolidState_60kWh(R_int = 0.015, Q_nom = (60000/400)*3600,  // 150 Ah * 3600 = 540,000 C
    beta_degrad = 0.02, degradation_rate = 5e-9, m_batt = 240,  // 60000 Wh / 250 Wh/kg = 240 kg (projected)
    c_p = 850, h = 10, A = 2.5);
    
  end BatteryTypes;

  package BatteryOperationModeTypes
    type BatteryOperationMode = enumeration(Normal "Code 00: Normal operation", ReducedSOH "Code 01: Reduced initial SOH");
  end BatteryOperationModeTypes;

  package BatterySelectionTypes

type BatterySelection = enumeration(
  NMC_60kWh,       
  LFP_60kWh,        
  SolidState_60kWh 
);

  end BatterySelectionTypes;
  annotation(
   Documentation(info = "<html><head></head><body></body></html>"));
end Battery;
