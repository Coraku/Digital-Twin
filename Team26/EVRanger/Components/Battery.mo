within EVRanger.Components;




model Battery

 /*WORKING: 
  import EVRanger.Interfaces.ElectricalPort;
  import EVRanger.Functions.*;


  parameter Real R_int = 0.08 "Internal resistance (Ohm)";
  parameter Real Q_nom = 720000 "Nominal capacity (Coulombs)";
  parameter Real T_ref = 25 "Initial temperature (°C)";
 

parameter Real beta_degrad = 0.1 "Temperature sensitivity for SOH degradation";
parameter Real SOC_min = 0.05 "Minimum SOC limit";
parameter Real SOC_max = 1.0 "Maximum SOC limit";



  parameter Real m_batt = 420 "Battery mass (kg)";
  parameter Real c_p = 900 "Specific heat capacity (J/kg.K)";
  parameter Real h = 8 "Heat transfer coefficient (W/m2.K)";
  parameter Real A = 3.0 "Surface area (m2)";
  parameter Real T_amb = 25 "Ambient temperature (°C)";
  
parameter Real degradation_rate = 5e-8 "SOH degradation rate";


  Real SOC(start=0.8, min=0, max=1) "State of Charge";
  Real SOH(start=1, min=0, max=1) "State of Health";
  Real T(start=T_ref) "Battery temperature (°C)";


  Real I_batt "Battery current (A)";
  Real V_t "Terminal voltage (V)";
  Real V_oc "Open-circuit voltage (V)";
  Real R_int_T "Temperature-adjusted resistance";


  Real Q_gen "Generated heat";
  Real Q_loss "Heat loss (W)";

  Real Q_eff "Effective capacity";

 
 Real SOC_out;
  output Real T_out;
  output Real SOH_out;
  output Real R_int_factor;
  

  
 Interfaces.ElectricalPort electricalPortOut annotation(
    Placement(transformation(origin = {68, 26}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {86, 4}, extent = {{-10, -10}, {10, 10}})));
output Interfaces.BatteryAvailable batteryAvailable annotation(
    Placement(visible = true, transformation(origin = {86, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {86, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

 
  I_batt = electricalPortOut.I;
 

  electricalPortOut.V = V_t;

  R_int_factor = R_int_temp_factor(T);

  R_int_T = R_int * R_int_factor * (if (SOC > SOC_min) and (SOC < SOC_max) then 1 else 1e6);
  Q_eff = Q_nom_temp(T, Q_nom); 
 

  
  V_oc = OCV_from_SOC(SOC);
  V_t = V_oc - R_int_T * I_batt;


   der(SOC) = if SOC > SOC_min and SOC < SOC_max then
             -I_batt / (Q_eff * SOH)
           else
             0;
            
        
  der(SOH) = if (SOC > SOC_min) and (SOC < SOC_max) and (abs(I_batt) > 0) then
             - degradation_rate * abs(I_batt) * exp(beta_degrad * (T - T_ref))
           else
             0;


  Q_gen  = I_batt^2 * R_int_T;
  Q_loss = h * A * (T - T_amb);

  der(T) = if SOC > 0 then
           (Q_gen - Q_loss) / (m_batt * c_p)
         else
           0; // or der(T) = 0 to keep temp constant


  SOC_out = SOC;
  T_out   = T;
  SOH_out = SOH;
  
  */
  import EVRanger.Interfaces.ElectricalPort;
  import EVRanger.Functions.*;
  import EVRanger.Records.BatteryParams;
  import EVRanger.BatteryTypes;

// Select battery type: 1=NMC, 2=LFP, 3=SolidState
  parameter Integer batteryType = 1 "Select battery type";

// Choose battery parameters based on selection
  parameter BatteryParams batt = if batteryType == 1 then BatteryTypes.NMC_60kWh
                                 else if batteryType == 2 then BatteryTypes.LFP_60kWh
                                 else BatteryTypes.SolidState_60kWh;

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
  Real SOC(start=0.8, min=0, max=1) "State of Charge";
  Real SOH(start=1, min=0, max=1) "State of Health";
  Real T(start=T_ref) "Battery temperature (°C)";

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
    Placement(visible = true,transformation(origin = {68, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), 
              iconTransformation(origin = {18, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  package BatteryTypes
  import EVRanger.Records.BatteryParams;
  //350 kg pack weight × 177 Wh/kg = ~62 250; Q=62250/3.6(nominal voltage)=17291Ah = 62,247,600 C
    constant BatteryParams NMC_60kWh(
      R_int = 0.08,
      Q_nom = 560250,
      beta_degrad = 0.12,
      degradation_rate = 6e-8,
      m_batt = 350 "kg",
      c_p = 900,
      h = 8,
      A = 3.0
    );
  //415 kg pack weight × 150 Wh/kg = ~62 250; Q=62250/3.2(nominal voltage)=19453Ah = 70,030,800
    constant BatteryParams LFP_60kWh(
      R_int = 0.12,
      Q_nom = 70030800,
      beta_degrad = 0.05,
      degradation_rate = 2e-8,
      m_batt = 480 "kg",
      c_p = 920,
      h = 7,
      A = 3.2
    );
  
    constant BatteryParams SolidState_60kWh(
      R_int = 0.03,
      Q_nom = 70030800,
      beta_degrad = 0.02,
      degradation_rate = 5e-9,
      m_batt = 360,
      c_p = 850,
      h = 10,
      A = 2.5
    );
  end BatteryTypes;

  output EVRanger.Interfaces.BatteryAvailableSignal batteryAvailableSignal annotation(
    Placement(visible = true, transformation(origin = {84, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-18, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

  I_batt = electricalPortOut.I;
  electricalPortOut.V = V_t;

  R_int_factor = R_int_temp_factor(T);
  R_int_T = R_int * R_int_factor * (if (SOC > SOC_min) and (SOC < SOC_max) then 1 else 1e6);

  Q_eff = Q_nom_temp(T, Q_nom);

  V_oc = OCV_from_SOC(SOC);
  V_t = V_oc - R_int_T * I_batt;

  der(SOC) = if SOC > SOC_min and SOC < SOC_max then
               -I_batt / (Q_eff * SOH)
             else
               0;

  der(SOH) = if (SOC > SOC_min) and (SOC < SOC_max) and (abs(I_batt) > 0) then
               - degradation_rate * abs(I_batt) * exp(beta_degrad * (T - T_ref))
             else
               0;

  Q_gen  = I_batt^2 * R_int_T;
  Q_loss = h * A * (T - T_amb);

  der(T) = if SOC > 0 then
             (Q_gen - Q_loss) / (m_batt * c_p)
           else
             0;

  SOC_out = SOC;
  T_out = T;
  SOH_out = SOH;



  
batteryAvailableSignal.batteryAvailable = if SOC <= SOC_min then false else true;
  
annotation(
    Icon(graphics = {Rectangle(origin = {1, 0}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-53, 32}, {53, -32}}), Rectangle(origin = {1, 38}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-59, 4}, {59, -4}}), Rectangle(origin = {-35, 45}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-7, 3}, {7, -3}}), Rectangle(origin = {-35, 51}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-3, 1}, {3, -1}}), Rectangle(origin = {35, 45}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-7, 3}, {7, -3}}), Rectangle(origin = {35, 51}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-3, 1}, {3, -1}}), Rectangle( fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 22}, {40, -22}}), Ellipse(origin = {21, 1}, fillPattern = FillPattern.Solid, extent = {{-9, 9}, {9, -9}}, endAngle = 360), Ellipse(origin = {-23, 1}, fillPattern = FillPattern.Solid, extent = {{-9, 9}, {9, -9}}, endAngle = 360), Text(origin = {-22, 2}, lineColor = {255, 255, 255}, extent = {{-16, 10}, {16, -10}}, textString = "+", textStyle = {TextStyle.Bold}), Text(origin = {22, 3}, lineColor = {255, 255, 255}, extent = {{-34, 13}, {34, -13}}, textString = "-", textStyle = {TextStyle.Bold}), Rectangle(origin = {1, -39}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-59, 5}, {59, -5}}), Text(origin = {-48, -55}, extent = {{-10, 5}, {10, -5}}, textString = "output")}),
 Diagram(graphics));
end Battery;
