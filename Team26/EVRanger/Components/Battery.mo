within EVRanger.Components;




model Battery

  import EVRanger.Interfaces.ElectricalPort;
  import EVRanger.Functions.*;



  /* ========= Parameters ========= */
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
  Real R_int_T "Temperature-adjusted resistance (Ohm)";


  Real Q_gen "Generated heat (W)";
  Real Q_loss "Heat loss (W)";

  /* ========= Derived ========= */
  Real Q_eff "Effective capacity (Coulombs)";

 
 Real SOC_out;
  output Real T_out;
  output Real SOH_out;
  output Real R_int_factor;
  

  
 Interfaces.ElectricalPort electricalPortOut annotation(
    Placement(transformation(origin = {68, 26}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {86, 4}, extent = {{-10, -10}, {10, 10}})));
equation


 
  /* ========= Electrical port ========= */
  //I_batt = electricalPortOut.I;
  /*I_batt = if SOC <= SOC_min then
             max(electricalPortOut.I, 0) // Allow only charging current if at min SOC
           elseif SOC >= SOC_max then
             min(electricalPortOut.I, 0) // Allow only discharging current if at max SOC
           else
             electricalPortOut.I; //Prevent battery current flow when SOC outside limits
             */
             I_batt = check_SOC(SOC, SOC_min, SOC_max, electricalPortOut.I);

  electricalPortOut.V = V_t;

  /* ========= Temperature effects ========= */
  R_int_factor = R_int_temp_factor(T);
  R_int_T = R_int * R_int_factor;
  Q_eff = Q_nom_temp(T, Q_nom);

  /* ========= Voltage model ========= */
  //V_oc = OCV_from_SOC(SOC);
  
  V_oc = OCV_from_SOC(SOC);
  V_t = V_oc - R_int_T * I_batt;

  /* ========= SOC dynamics ========= */
  /*der(SOC) = if SOC > 0 then
               -I_batt / (Q_eff * SOH)
             else
               0; */
   der(SOC) = if SOC > SOC_min and SOC < SOC_max then
             -I_batt / (Q_eff * SOH)
           else
             0;
            
        

  /* ========= SOH dynamics ========= */
  //der(SOH) = -degradation_rate * abs(I_batt);
  //der(SOH) = - degradation_rate * abs(I_batt) * exp(beta_degrad * (T - T_ref));
  der(SOH) = if (SOC > SOC_min) and (SOC < SOC_max) and (abs(I_batt) > 0) then
             - degradation_rate * abs(I_batt) * exp(beta_degrad * (T - T_ref))
           else
             0;



  /* ========= Thermal dynamics ========= */
  Q_gen  = I_batt^2 * R_int_T;
  Q_loss = h * A * (T - T_amb);


  //der(T) = (Q_gen - Q_loss) / (m_batt * c_p);
  der(T) = if SOC > 0 then
           (Q_gen - Q_loss) / (m_batt * c_p)
         else
           0; // or der(T) = 0 to keep temp constant

  /* ========= Outputs ========= */
  SOC_out = SOC;
  T_out   = T;
  SOH_out = SOH;



  

  
annotation(
    Icon(graphics = {Rectangle(origin = {1, 0}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-53, 32}, {53, -32}}), Rectangle(origin = {1, 38}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-59, 4}, {59, -4}}), Rectangle(origin = {-35, 45}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-7, 3}, {7, -3}}), Rectangle(origin = {-35, 51}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-3, 1}, {3, -1}}), Rectangle(origin = {35, 45}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-7, 3}, {7, -3}}), Rectangle(origin = {35, 51}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-3, 1}, {3, -1}}), Rectangle( fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 22}, {40, -22}}), Ellipse(origin = {21, 1}, fillPattern = FillPattern.Solid, extent = {{-9, 9}, {9, -9}}), Ellipse(origin = {-23, 1}, fillPattern = FillPattern.Solid, extent = {{-9, 9}, {9, -9}}), Text(origin = {-22, 2}, textColor = {255, 255, 255}, extent = {{-16, 10}, {16, -10}}, textString = "+", textStyle = {TextStyle.Bold}), Text(origin = {22, 3}, textColor = {255, 255, 255}, extent = {{-34, 13}, {34, -13}}, textString = "-", textStyle = {TextStyle.Bold}), Rectangle(origin = {1, -39}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-59, 5}, {59, -5}}), Line(origin = {65, 2}, points = {{-11, 0}, {11, 0}}), Text(origin = {84, -15}, extent = {{-10, 5}, {10, -5}}, textString = "output")}),
 Diagram(graphics));
end Battery;
