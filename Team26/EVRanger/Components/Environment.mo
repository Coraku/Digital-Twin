within EVRanger.Components;

model Environment // Here we will calculate the Slope and legal velocity Limit
  import EVRanger.Functions.*;
  // in Km/h, Govermentaly enforced Speed Limit
  input EVRanger.Interfaces.DistanceSignal distanceSignalIn annotation(
    Placement(visible = true,transformation(origin = {2, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  output EVRanger.Interfaces.SlopeSignal slopeSignal annotation(
    Placement(visible = true,transformation(origin = {-116, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
equation

slopeSignal.slope = fSlopeGenerator(distanceSignalIn.x);

annotation(
    Icon(graphics = {Rectangle(fillColor = {0, 170, 0},fillPattern = FillPattern.Solid, extent = {{-100, 40}, {100, -40}}), Rectangle(origin = {-60, 0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}}), Rectangle(fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}}), Rectangle(origin = {60, 0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}})}, coordinateSystem(extent = {{-100, 40}, {100, -40}})));
end Environment;
