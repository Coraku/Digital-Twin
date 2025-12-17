within EVRanger.Examples;

model ExampleMinimalImplementation
  Components.Battery battery annotation(
    Placement(transformation(origin = {-55, 21}, extent = {{-29, -29}, {29, 29}})));
  Components.MotorController motorController annotation(
    Placement(transformation(origin = {54, 18}, extent = {{-30, -30}, {30, 30}})));
  Components.DCMotor dCMotor annotation(
    Placement(transformation(origin = {-64, -38}, extent = {{-28, -28}, {28, 28}})));
  Components.VehicleLongDyn vehicleLongDyn annotation(
    Placement(transformation(origin = {33, -47}, extent = {{-31, -31}, {31, 31}})));
  Components.MinimalDriver minimalDriver annotation(
    Placement(transformation(origin = {7, 77}, extent = {{-25, -25}, {25, 25}})));
equation
  connect(vehicleLongDyn.motor, dCMotor.motor) annotation(
    Line(points = {{20, -30}, {-16, -30}, {-16, -72}, {-30, -72}, {-30, -60}, {-65, -60}, {-65, -59}}));
  connect(vehicleLongDyn.vehicle, motorController.movementPortFeedback) annotation(
    Line(points = {{54, -28}, {45, -28}, {45, 2}}));
  connect(motorController.electricalPortOut, dCMotor.controller) annotation(
    Line(points = {{77, 19}, {7, 19}, {7, -14}, {-34, -14}, {-34, -3}, {-64, -3}, {-64, -16}}));
  connect(battery.electricalPortOut, motorController.electricalPortIn) annotation(
    Line(points = {{-30, 22}, {32, 22}, {32, 12}}));
  connect(minimalDriver.outputMovement, motorController.movementPortTarget) annotation(
    Line(points = {{8, 62}, {32, 62}, {32, 26}}));
end ExampleMinimalImplementation;
