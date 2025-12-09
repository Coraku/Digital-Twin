within EVRanger.Components;

model DCMotor "Basic Lynch Type DC Motor"
  import Modelica.Constants.pi;
  
  //typical data sheet information
  parameter Real mot_vel = 70 "Motor speed [rpm/V]";
  parameter Real R_a = 0.016 "Armature resistance [ohm]";
  parameter Real I_lim = 250 "Current limit [A]";
  
  input Real I;
  input Real V;
  
  output Real torque_mot;
  output Real omega;
  
  EVRanger.Interfaces.ElectricalPort controller annotation(
    Placement(visible = true, transformation(origin = {-2, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.MechanicalPort motor annotation(
    Placement(visible = true, transformation(origin = {-2, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

protected
  Real torque_mot_raw;
  Real KmPhi; // K_m*Phi -> motor const*total flux passing through coil
  Real torque_mot_max;
equation
  omega = controller.V / KmPhi; //[rad/s]
  KmPhi = 60 / (mot_vel * 2 * pi);
  torque_mot_max = KmPhi * I;
  torque_mot_raw = KmPhi * V / R_a - KmPhi ^ 2 / R_a * omega;
//limit torque
  torque_mot = min(torque_mot_raw, torque_mot_max);
  annotation(
    Icon(graphics = {Ellipse(extent = {{-30, 30}, {30, -30}}, endAngle = 360), Ellipse(origin = {1.02936, 0.0197136}, extent = {{-79.5265, 79.2145}, {79.5265, -79.2145}}, endAngle = 360), Polygon(origin = {-56, 0}, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}}), Polygon(origin = {0, 56}, rotation = -90, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}}), Polygon(origin = {58, 0}, rotation = 180, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}}), Polygon(origin = {0, -56}, rotation = 90, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}})}));
end DCMotor;
