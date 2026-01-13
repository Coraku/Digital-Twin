within EVRanger.Components;

model Environment // Here we will calculate the different Force Vectors and the real Velocity of the Car
 parameter Real slope = 0; // in Degrees, will be a function later
 parameter Real legal_velocity = 50;
 Real current_velocity;
  // in Km/h, Govermentaly enforced Speed Limit
  Interfaces.VelocitySignal velocitySignal annotation(
    Placement(transformation(origin = {118, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {118, 0}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.SlopeSignal slopeSignal annotation(
    Placement(transformation(origin = {-116, 2}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-116, 2}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.DistanceSignal distanceSignal annotation(
    Placement(transformation(origin = {2, -58}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {2, -58}, extent = {{-10, -10}, {10, 10}})));
equation
velocitySignal.vel = legal_velocity;
slopeSignal.slope = slope;
current_velocity = distanceSignal.x;

annotation(
    Icon(graphics = {Rectangle(fillPattern = FillPattern.Solid, extent = {{-100, 40}, {100, -40}}), Rectangle(origin = {-60, 0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}}), Rectangle(fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}}), Rectangle(origin = {60, 0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}})}, coordinateSystem(extent = {{-100, 40}, {100, -40}})));
end Environment;
