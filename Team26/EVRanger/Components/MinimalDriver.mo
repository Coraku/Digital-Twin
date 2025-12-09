within EVRanger.Components;

model MinimalDriver
  parameter Real velocity = 20;
  Interfaces.MovementPort outputMovement annotation(
    Placement(transformation(origin = {-2, -48}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {2, -58}, extent = {{-10, -10}, {10, 10}})));
equation
der(outputMovement.r) = velocity;

annotation(
    Icon(graphics = {Ellipse(origin = {1, 4}, extent = {{-55, 56}, {55, -56}})}));
end MinimalDriver;
