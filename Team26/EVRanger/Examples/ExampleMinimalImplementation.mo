within EVRanger.Examples;

model ExampleMinimalImplementation
  Components.Battery battery annotation(
    Placement(transformation(origin = {-85, 9}, extent = {{-29, -29}, {29, 29}})));
  Components.DCMotor dCMotor annotation(
    Placement(transformation(origin = {66, -30}, extent = {{-28, -28}, {28, 28}})));
  Components.VehicleLongDyn vehicleLongDyn annotation(
    Placement(transformation(origin = {-5, -59}, extent = {{-31, -31}, {31, 31}})));
  Components.MinimalDriver minimalDriver annotation(
    Placement(transformation(origin = {-51, 45}, extent = {{-25, -25}, {25, 25}})));
  Components.MotorController motorController annotation(
    Placement(transformation(origin = {17, 25}, extent = {{-27, -27}, {27, 27}})));
equation
  connect(vehicleLongDyn.vehicleMechanicalPortIn, dCMotor.mechanicalPortOut) annotation(
    Line(points = {{32, -42}, {32, -72}, {-30, -72}, {-30, -60}, {-65, -60}, {-65, -59}}));
  connect(vehicleLongDyn.vehicleMovementPortOut, motorController.movementPortIn) annotation(
    Line(points = {{65, -40}, {65, 2}, {45, 2}}));
  connect(motorController.mechanicalPortOut, dCMotor.mechanicalPortIn) annotation(
    Line(points = {{77, 19}, {7, 19}, {7, -14}, {-34, -14}, {-34, -3}, {-64, -3}, {-64, -16}}));
  connect(motorController.mechanicalPortOut, battery.electricalPortIn) annotation(
    Line(points = {{78, 20}, {78, 63}, {29, 63}}));
  connect(battery.electricalPortOut, dCMotor.electricalPortIn) annotation(
    Line(points = {{-60, 10}, {-54, 10}, {-54, -10}, {76, -10}}));
  connect(minimalDriver.outputMovement, motorController.DriverInput) annotation(
    Line(points = {{-50, 30}, {-2, 30}, {-2, 26}}));
  connect(motorController.mechanicalPortOut, dCMotor.mechanicalPortIn) annotation(
    Line(points = {{38, 26}, {56, 26}, {56, -13}}));
  connect(dCMotor.mechanicalPortOut, vehicleLongDyn.vehicleMechanicalPortIn) annotation(
    Line(points = {{66, -52}, {16, -52}, {16, -64}}));
  connect(vehicleLongDyn.vehicleMovementPortOut, motorController.movementPortIn) annotation(
    Line(points = {{-24, -64}, {8, -64}, {8, 10}}));
end ExampleMinimalImplementation;
