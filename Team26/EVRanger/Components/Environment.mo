within EVRanger.Components;

model Environment // Here we will calculate the different Force Vectors and the real Velocity of the Car
 parameter Real slope = 0; // in Degrees, will be a function later
equation

annotation(
    Icon(graphics = {Rectangle(fillPattern = FillPattern.Solid, extent = {{-100, 40}, {100, -40}}), Rectangle(origin = {-60, 0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}}), Rectangle(fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}}), Rectangle(origin = {60, 0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}})}, coordinateSystem(extent = {{-100, 40}, {100, -40}})));
end Environment;
