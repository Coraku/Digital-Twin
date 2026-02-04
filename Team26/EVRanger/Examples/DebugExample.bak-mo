within EVRanger.Examples;

model DebugExample
extends EVRanger.Icons.ExampleSymb;
  Components.Battery battery annotation(
    Placement(transformation(origin = {-52, 38}, extent = {{-10, -10}, {10, 10}})));
  Components.Consumer consumer annotation(
    Placement(transformation(origin = {-26, 38}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(battery.electricalPortOut, consumer.electricalPortin) annotation(
    Line(points = {{-44, 38}, {-32, 38}}));
end DebugExample;
