within EVRanger.Components;

model MinimalDriver
  parameter Real velocity = 55;
 
  output Interfaces.VelocitySignal velocitySignal annotation(
    Placement(visible = true, transformation(origin = {0, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
velocitySignal.vel = velocity;

annotation(
    Icon(graphics = {Ellipse(origin = {1, 4}, extent = {{-55, 56}, {55, -56}}, endAngle = 360)}));
end MinimalDriver;
