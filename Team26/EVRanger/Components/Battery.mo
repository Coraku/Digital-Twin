within EVRanger.Components;

model Battery
  import EVRanger.Interfaces.ElectricalPort;
  import EVRanger.Functions.*;
  import EVRanger.Records.BatteryParams;
  import EVRanger.BatteryTypes;
  import Battery.BatteryOperationModeTypes;
  
  
  // Select battery type: 1=NMC, 2=LFP, 3=SolidState
  parameter Integer batteryType = 3 "Select battery type";
  // Choose battery parameters based on selection
  parameter BatteryParams batt = if batteryType == 1 then BatteryTypes.NMC_60kWh else if batteryType == 2 then BatteryTypes.LFP_60kWh else BatteryTypes.SolidState_60kWh;
  
  //Battery operation mode
  parameter BatteryOperationModeTypes.BatteryOperationMode operationMode = BatteryOperationModeTypes.BatteryOperationMode.Normal "Select Battery operating mode";
  parameter Real SOH_init = if operationMode == BatteryOperationModeTypes.BatteryOperationMode.Normal then 1.0 else 0.4 "Initial state of health (1 = 100%)";
  Integer[3] modeColor =
  if operationMode == BatteryOperationModeTypes.BatteryOperationMode.Normal
  then {0,160,0}
  else {220,140,0};
  
  
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

  package BatteryTypes
    import EVRanger.Records.BatteryParams;
    //~400 V arch
    constant BatteryParams NMC_60kWh(R_int = 0.03, Q_nom = 540000, beta_degrad = 0.10, degradation_rate = 5e-8, m_batt = 350, c_p = 900, h = 8, A = 3.0);
    // C: 60kWh / 400V = 150Ah -> 150*3600
    // kg, 60kWh / 175 Wh/kg (175=pack level energy density)
    //~320 V arch
    constant BatteryParams LFP_60kWh(R_int = 0.05, Q_nom = 675000, beta_degrad = 0.05, degradation_rate = 2e-8, m_batt = 415, c_p = 920, h = 7, A = 3.2);
    // C: 60kWh / 320V = 187.5Ah -> *3600
    // kg,, 60kWh / 145 Wh/kg
    // projected, ~400 V
    constant BatteryParams SolidState_60kWh(R_int = 0.015, Q_nom = 540000, beta_degrad = 0.02, degradation_rate = 5e-9, m_batt = 240, c_p = 850, h = 10, A = 2.5);
    // projected lower resistance -->solid electrolyte
    // C: 60kWh / 400V = 150Ah -> *3600
    // Empirical: slowest degradation (theoretical)
    // kG, 60kWh / 250 Wh/kg (250=projected pack density)
    // m2, more compact pack geometry
  end BatteryTypes;

  output EVRanger.Interfaces.BatteryAvailableSignal batteryAvailableSignal annotation(
    Placement(visible = true, transformation(origin = {84, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-18, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  package BatteryOperationModeTypes
  
  type BatteryOperationMode = enumeration(
      Normal        "Code 00: Normal operation",
      ReducedSOH    "Code 01: Reduced initial SOH"
    );
  
  end BatteryOperationModeTypes;
equation
  I_batt = electricalPortOut.I;
  electricalPortOut.V = V_t;
  R_int_factor = R_int_temp_factor(T);
  R_int_T = R_int * R_int_factor * (if SOC > SOC_min and SOC < SOC_max then 1 else 1e6);
  Q_eff = Q_nom_temp(T, Q_nom);
  V_oc = OCV_from_SOC(SOC);
  V_t = V_oc - R_int_T * I_batt;
  der(SOC) = if SOC > SOC_min and SOC < SOC_max then -I_batt / (Q_eff * SOH) else 0;
  der(SOH) = if SOC > SOC_min and SOC < SOC_max and abs(I_batt) > 0 then -degradation_rate * abs(I_batt) * exp(beta_degrad * (T - T_ref)) else 0;
  Q_gen = I_batt ^ 2 * R_int_T;
  Q_loss = h * A * (T - T_amb);
  der(T) = if SOC > 0 then (Q_gen - Q_loss) / (m_batt * c_p) else 0;
  SOC_out = SOC;
  T_out = T;
  SOH_out = SOH;
  batteryAvailableSignal.batteryAvailable = if SOC <= SOC_min then false else true;
// green
// orange
  annotation(
    Icon(graphics = {Rectangle(origin = {1, 0}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-53, 32}, {53, -32}}), Rectangle(origin = {1, 38}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-59, 4}, {59, -4}}), Rectangle(origin = {-35, 45}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-7, 3}, {7, -3}}), Rectangle(origin = {-35, 51}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-3, 1}, {3, -1}}), Rectangle(origin = {35, 45}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-7, 3}, {7, -3}}), Rectangle(origin = {35, 51}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-3, 1}, {3, -1}}), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 22}, {40, -22}}), Ellipse(origin = {21, 1}, fillPattern = FillPattern.Solid, extent = {{-9, 9}, {9, -9}}, endAngle = 360), Ellipse(origin = {-23, 1}, fillPattern = FillPattern.Solid, extent = {{-9, 9}, {9, -9}}, endAngle = 360), Text(origin = {-22, 2}, lineColor = {255, 255, 255}, extent = {{-16, 10}, {16, -10}}, textString = "+", textStyle = {TextStyle.Bold}), Text(origin = {22, 3}, lineColor = {255, 255, 255}, extent = {{-34, 13}, {34, -13}}, textString = "-", textStyle = {TextStyle.Bold}), Rectangle(origin = {1, -39}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-59, 5}, {59, -5}}), Text(origin = {-48, -55}, extent = {{-10, 5}, {10, -5}}, textString = "output"),Ellipse(origin = {-46, 24}, lineColor = DynamicSelect({0,160,0}, modeColor), fillColor = DynamicSelect({0,160,0}, modeColor), fillPattern = FillPattern.Solid, extent = {{-6, 6}, {6, -6}}, endAngle = 360)}),
    Diagram(graphics),
    Documentation(info = "<html><head></head><body>This is a great battery</body></html>"));
end Battery;
