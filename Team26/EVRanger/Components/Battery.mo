within EVRanger.Components;

model Battery

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
  input Real P_demand "Power requested by controller/motor";
  
  // outputs
  output Real Voltage "Battery terminal voltage (Volts)";
  output Real SOC_out "Current State of Charge";

  model Test
  
  
    EVRanger.Components.Battery batt;
  
    // Power requested from battery [W]
    parameter Real P_demand = 10000;
  
  equation
    // Feed requested power into battery
    batt.P_demand = P_demand;
  
    // You do NOT assign batt.I_batt here because battery computes it internally
  
    // Terminate when SOC empty
    when batt.SOC <= 0 then
      terminate("Battery depleted");
    end when;
  
  
  
  

  end Test;
equation

  // Terminal voltage drops with current bc of internal resistance
  V_t = E_m - I_batt * R_int;
  
  // max allowed current depends on SOC to protect battery, if the SOC falls below 5%, the battery stops delivering any current to avoid damage, and setting Imax to zero; if higher that 5%, can safely provide 400 Amperes of discharge current
I_max = if SOC > 0.05 then 400 else 0;
  
  // max available power based on voltage and current limit
  P_available = V_t * I_max;
  
  // actual power drawn limited by battery capability, P_drawn to not exceed P_available
    P_drawn = min(P_demand, P_available);
  
  // current from power and voltage
  I_batt = P_drawn / V_t;
  
  // SOC changes over time according to discharge current
  der(SOC) = - I_batt / Q_nom;

  // outputs calculated
  Voltage = V_t; //goes to controller
  SOC_out = SOC;
  
end Battery;
