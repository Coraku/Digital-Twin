within EVRanger.Examples;

model NewExample
  Components.VehicleLongDyn vehicleLongDyn annotation(
    Placement(transformation(origin = {-33, -53}, extent = {{-39, -39}, {39, 39}})));
  Components.MinimalDriver minimalDriver annotation(
    Placement(transformation(origin = {-47, 57}, extent = {{-27, -27}, {27, 27}})));
  Components.Battery battery annotation(
    Placement(transformation(origin = {20, 58}, extent = {{-34, -34}, {34, 34}})));
  Components.DCMotor dCMotor annotation(
    Placement(transformation(origin = {52, -18}, extent = {{-36, -36}, {36, 36}})));
  Components.MotorController motorController annotation(
    Placement(transformation(origin = {-28, 6}, extent = {{-28, -28}, {28, 28}})));
equation
  connect(minimalDriver.outputMovement, motorController.DriverInput) annotation(
    Line(points = {{-46, 42}, {-48, 42}, {-48, 8}}));
  connect(vehicleLongDyn.vehicleMovementPortOut, motorController.movementPortIn) annotation(
    Line(points = {{-58, -58}, {-36, -58}, {-36, -8}}));
  connect(motorController.mechanicalPortOut, dCMotor.mechanicalPortIn) annotation(
    Line(points = {{-6, 8}, {40, 8}, {40, 4}}));
  connect(dCMotor.mechanicalPortOut, vehicleLongDyn.vehicleMechanicalPortIn) annotation(
    Line(points = {{52, -46}, {-6, -46}, {-6, -60}}));
  connect(battery.electricalPortOut, dCMotor.electricalPortIn) annotation(
    Line(points = {{50, 60}, {64, 60}, {64, 8}}));
end NewExample;
