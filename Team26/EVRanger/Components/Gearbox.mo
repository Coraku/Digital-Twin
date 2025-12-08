within EVRanger.Components;

model Gearbox
 "interface between motor and vehicle long dyn. tau_axle = tau_mot*G*eta"

  parameter Real G "Gear ratio (motorSpeed/axleSpeed)";
  parameter Real eta = 1;
  
Interfaces.MechanicalPort motor annotation(
    Placement(visible = true, transformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Interfaces.MechanicalPort axle annotation(
    Placement(visible = true, transformation(origin = {2, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  axle.omega = motor.omega / G;

  axle.tau   = motor.tau * G * eta;

  //motor.tau  = -axle.tau / (G * eta);
  
annotation(
    Icon(graphics = {Rectangle(origin = {1, 1}, extent = {{-79, 39}, {79, -39}})}));
end Gearbox;
