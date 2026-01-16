within EVRanger.Components;

model Environment // Here we will calculate the Slope and legal velocity Limit
  import EVRanger.Functions.*;
  // in Km/h, Govermentaly enforced Speed Limit
  input Interfaces.DistanceSignal distanceSignalIn annotation(
    Placement(transformation(origin = {2, -58}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {2, -58}, extent = {{-10, -10}, {10, 10}})));
  output Interfaces.VelocitySignal velocitySignal annotation(
    Placement(transformation(origin = {118, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {118, 0}, extent = {{-10, -10}, {10, 10}})));
  output Interfaces.SlopeSignal slopeSignal annotation(
    Placement(transformation(origin = {-116, 2}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-116, 2}, extent = {{-10, -10}, {10, 10}})));
    
equation
velocitySignal.vel = fSpeedLimit(distanceSignalIn.x);
slopeSignal.slope = fSlopeGenerator(distanceSignalIn.x);

annotation(
    Icon(graphics = {Rectangle(fillPattern = FillPattern.Solid, extent = {{-100, 40}, {100, -40}}), Rectangle(origin = {-60, 0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}}), Rectangle(fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}}), Rectangle(origin = {60, 0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}})}, coordinateSystem(extent = {{-100, 40}, {100, -40}})));
end Environment;
