within EVRanger.Components;

model DCMotor "Basic Lynch Type DC Motor"
  import Modelica.Constants.pi;
  import EVRanger.Functions.*;
  
  //typical data sheet information
  parameter Real mot_vel = 70 "Motor speed [rpm/V]";
  parameter Real R_a = 0.016 "Armature resistance [ohm]";
  parameter Real I_lim = 250 "Current limit [A]";
  
  parameter Real tau_max = -34 "[Nm]"; //Vorzeichen gerade etwas spannend das Strom Vorzeichen irgenwie gerade ugedreht
  
  //Flow/Potential
  EVRanger.Interfaces.ElectricalPort electricalPortIn annotation(
    Placement(visible = true, transformation(origin = {-2, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {36, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  EVRanger.Interfaces.MechanicalPort mechanicalPortOut annotation(
    Placement(visible = true, transformation(origin = {-2, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  // Signals
  input EVRanger.Interfaces.TorqueSignal torqueSignal annotation(
    Placement(visible = true, transformation(origin = {-24, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-24, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

//protected

  Real KmPhi; // K_m*Phi -> motor const*total flux passing through coil
  Real V_b "Voltage opposing supply voltage";
  Real I_amature "Amature current";
  Real I_demand "Current necessary to meet torque demand from controller";
  Real I_actual "Possible current, considering I_max, I_demand & I_amature";
  Real tau_des "Desired torque value, considering the max torque of the motor & controller demand";
input Interfaces.BatteryAvailable batteryAvailable annotation(
    Placement(visible = true, transformation(origin = {26, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {26, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

  KmPhi = 60 / (mot_vel * 2 * pi); //motor constant
  
  // tau_des = max torque times the procentual signal 
  tau_des = tau_max*torqueSignal.tau; 
  
  // Current required to meet controller torque demand
  I_demand = tau_des / KmPhi; 
  
  // Voltage opposing supply voltage
  V_b = KmPhi * mechanicalPortOut.omega;

  if batteryAvailable.battAvailable then
  // Amature current for the voltage from the battery
  I_amature = (electricalPortIn.V - V_b) / R_a;  
  I_actual = minCurrValue(I_demand, I_amature, I_lim);
  else
  I_amature = 0;
  I_actual = 0;
  end if;
  // Limit current to battery capability & motor possibilities
 
 // Assign signal & flow values
  mechanicalPortOut.tau = KmPhi * (I_actual);
  electricalPortIn.I   = I_actual;
 

  annotation(
    Icon(graphics = {Ellipse(extent = {{-30, 30}, {30, -30}}, endAngle = 360), Ellipse(origin = {1.02936, 0.0197136}, extent = {{-79.5265, 79.2145}, {79.5265, -79.2145}}, endAngle = 360), Polygon(origin = {-56, 0}, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}}), Polygon(origin = {0, 56}, rotation = -90, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}}), Polygon(origin = {58, 0}, rotation = 180, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}}), Polygon(origin = {0, -56}, rotation = 90, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}})}));
end DCMotor;
