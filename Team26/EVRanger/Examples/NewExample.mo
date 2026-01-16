within EVRanger.Examples;

model NewExample
  Components.Battery battery annotation(
    Placement(transformation(origin = {34, 74}, extent = {{-34, -34}, {34, 34}})));
  EVRanger.Components.DCMotor dCMotor annotation(
    Placement(visible = true, transformation(origin = {60, -24}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
  EVRanger.Components.VehicleLongDyn vehicleLongDyn annotation(
    Placement(visible = true, transformation(origin = {-10, -72}, extent = {{-44, -44}, {44, 44}}, rotation = 0)));
  Components.Environment environment annotation(
    Placement(transformation(origin = {-65, 68.8}, extent = {{-23, -9.2}, {23, 9.2}})));
  Components.MotorController motorController annotation(
    Placement(transformation(origin = {-19, 7}, extent = {{-35, -35}, {35, 35}})));
equation
  connect(dCMotor.mechanicalPortOut, vehicleLongDyn.vehicleMechanicalPortIn) annotation(
    Line(points = {{60, -52}, {20, -52}, {20, -80}}));
  connect(battery.electricalPortOut, dCMotor.electricalPortIn) annotation(
    Line(points = {{63, 75}, {72, 75}, {72, 2}}));
  connect(environment.velocitySignal, motorController.velocitySignalEnvironment) annotation(
    Line(points = {{-38, 68}, {-43.5, 68}, {-43.5, 9}}));
  connect(motorController.torqueSignal, dCMotor.torqueSignal) annotation(
    Line(points = {{8, 8}, {52, 8}, {52, 2}}));
  connect(vehicleLongDyn.velocitySignal, motorController.velocitySignalVehicle) annotation(
    Line(points = {{-38, -78}, {-30, -78}, {-30, -11}}));
  connect(environment.distanceSignalIn, vehicleLongDyn.distanceSignal) annotation(
    Line(points = {{-64, 56}, {-64, -26}, {2, -26}, {2, -78}}));
  annotation(
    Diagram);
end NewExample;
