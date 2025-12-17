within EVRanger.Components;

model DCMotor "Basic Lynch Type DC Motor"
  import Modelica.Constants.pi;
  //typical data sheet information
  parameter Real mot_vel = 70 "Motor speed [rpm/V]";
  parameter Real R_a = 0.016 "Armature resistance [ohm]";
  parameter Real I_lim = 250 "Current limit [A]";
  EVRanger.Interfaces.ElectricalPort electricalPortIn annotation(
    Placement(visible = true, transformation(origin = {-2, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {36, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  EVRanger.Interfaces.MechanicalPort mechanicalPortOut annotation(
    Placement(visible = true, transformation(origin = {-2, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  EVRanger.Interfaces.MechanicalPort mechanicalPortIn annotation(
    Placement(visible = true, transformation(origin = {-34, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-34, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  //Real torque_mot_raw;
  Real KmPhi;
  // K_m*Phi -> motor const*total flux passing through coil
  //Real torque_mot_max;
  Real V_b;
  Real I_demand;
  Real I_possible;
  //Real I_voltage;
equation
// electricalPortIn.V = V_s
  KmPhi = 60 / (mot_vel * 2 * pi); //motor constant
  
  // Current required to meet controller torque demand
I_demand = mechanicalPortIn.tau / KmPhi; 
  
  //electricalPortIn.I = (electricalPortIn.V - V_b)/R_a;
  I_possible = electricalPortIn.I;
  
  V_b = KmPhi * mechanicalPortOut.omega;

// Limit current to motor capability
if I_demand > electricalPortIn.I then
  mechanicalPortOut.tau = KmPhi * I_possible;
  electricalPortIn.I = I_possible;
else 
  mechanicalPortOut.tau = KmPhi * I_demand;
  electricalPortIn.I = I_demand;
end if;


  annotation(
    Icon(graphics = {Ellipse(extent = {{-30, 30}, {30, -30}}, endAngle = 360), Ellipse(origin = {1.02936, 0.0197136}, extent = {{-79.5265, 79.2145}, {79.5265, -79.2145}}, endAngle = 360), Polygon(origin = {-56, 0}, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}}), Polygon(origin = {0, 56}, rotation = -90, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}}), Polygon(origin = {58, 0}, rotation = 180, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}}), Polygon(origin = {0, -56}, rotation = 90, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}})}));
end DCMotor;
