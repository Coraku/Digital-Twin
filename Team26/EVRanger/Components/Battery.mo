within EVRanger.Components;

model Battery

  import EVRanger.Interfaces.ElectricalPort;
  //ElectricalPort port;

// Lithium Ion Battery
  parameter Real E_m = 360;       // Open-circuit voltage = 3.6v/cell * 100 cells, when no current is drawn
  parameter Real R_int = 0.05;     // Internal resistance
  parameter Real Q_nom = 648000;      // Nominal capacity = 180Ah * 3600 C/Ah, total charge the battery can store when fully charged
  Real SOC(start=1) "State of Charge, 0 empty 1 full";
  Real V_t "Terminal voltage";
  Real I_batt "Battery current";
  Real P_available "Maximum power battery can provide";
  Real P_drawn "Actual power drawn";
  Real I_max "Max allowed current depends on SOC to protect battery";
 // input
   Real P_demand "Power requested by controller/motor";
  // outputs
  //output Real Voltage "Battery terminal voltage (Volts)";
  output Real SOC_out "Current State of Charge";
 Interfaces.ElectricalPort electricalPortOut annotation(
    Placement(transformation(origin = {68, 26}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {86, 4}, extent = {{-10, -10}, {10, 10}})));
 Interfaces.ElectricalPort electricalPortIn annotation(
    Placement(transformation(origin = {-76, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-88, 0}, extent = {{-10, -10}, {10, 10}})));
equation

// Terminal voltage drops with current bc of internal resistance
  V_t = E_m - I_batt * R_int;
// max allowed current depends on SOC to protect battery, if the SOC falls below 5%, the battery stops delivering any current to avoid damage, and setting Imax to zero; if higher that 5%, can safely provide 400 Amperes of discharge current
  I_max = if SOC > 0.05 then 400 else 0;
// max available power based on voltage and current limit
  P_available = V_t * I_max;
// actual power drawn limited by battery capability, P_drawn to not exceed P_available
P_demand = electricalPortIn.V *electricalPortIn.I;
    P_drawn = min(P_demand, P_available);
// current from power and voltage
  I_batt = P_drawn / V_t;
// SOC changes over time according to discharge current
  der(SOC) = - I_batt / Q_nom;
// outputs calculated
  //Voltage = V_t; //goes to controller
  SOC_out = SOC;  
  
  electricalPortOut.V = V_t;
  electricalPortOut.I = I_batt;
  
annotation(
    Icon(graphics = {Rectangle(origin = {1, 0}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-53, 32}, {53, -32}}), Rectangle(origin = {1, 38}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-59, 4}, {59, -4}}), Rectangle(origin = {-35, 45}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-7, 3}, {7, -3}}), Rectangle(origin = {-35, 51}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-3, 1}, {3, -1}}), Rectangle(origin = {35, 45}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-7, 3}, {7, -3}}), Rectangle(origin = {35, 51}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-3, 1}, {3, -1}}), Rectangle( fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 22}, {40, -22}}), Ellipse(origin = {21, 1}, fillPattern = FillPattern.Solid, extent = {{-9, 9}, {9, -9}}), Ellipse(origin = {-23, 1}, fillPattern = FillPattern.Solid, extent = {{-9, 9}, {9, -9}}), Text(origin = {-22, 2}, textColor = {255, 255, 255}, extent = {{-16, 10}, {16, -10}}, textString = "+", textStyle = {TextStyle.Bold}), Text(origin = {22, 3}, textColor = {255, 255, 255}, extent = {{-34, 13}, {34, -13}}, textString = "-", textStyle = {TextStyle.Bold}), Rectangle(origin = {1, -39}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2, extent = {{-59, 5}, {59, -5}}), Line(origin = {65, 2}, points = {{-11, 0}, {11, 0}}), Text(origin = {84, -15}, extent = {{-10, 5}, {10, -5}}, textString = "output"), Line(origin = {-66, 0}, points = {{14, 0}, {-12, 0}}), Text(origin = {-84, -17}, extent = {{-10, 5}, {10, -5}}, textString = "input")}),
 Diagram(graphics));
end Battery;
