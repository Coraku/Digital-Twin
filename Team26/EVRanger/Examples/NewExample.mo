within EVRanger.Examples;

model NewExample
  Components.Battery battery annotation(
    Placement(transformation(origin = {26, 72}, extent = {{-34, -34}, {34, 34}})));
  EVRanger.Components.DCMotor dCMotor annotation(
    Placement(transformation(origin = {58, -16}, extent = {{-36, -36}, {36, 36}})));
  EVRanger.Components.VehicleLongDyn vehicleLongDyn annotation(
    Placement(transformation(origin = {-12, -70}, extent = {{-44, -44}, {44, 44}})));
  Components.Environment environment annotation(
    Placement(transformation(origin = {-73, 70.8}, extent = {{-23, -9.2}, {23, 9.2}})));
  Components.MotorController motorController annotation(
    Placement(transformation(origin = {-19, 9}, extent = {{-35, -35}, {35, 35}})));
equation
  connect(dCMotor.mechanicalPortOut, vehicleLongDyn.vehicleMechanicalPortIn) annotation(
    Line(points = {{57, -43}, {57, -77}, {19, -77}}));
  connect(battery.electricalPortOut, dCMotor.electricalPortIn) annotation(
    Line(points = {{55, 73}, {70, 73}, {70, 9}, {71, 9}}));
  connect(environment.velocitySignal, motorController.velocitySignalEnvironment) annotation(
    Line(points = {{-46, 71}, {-46, 11}, {-43.5, 11}}));
  connect(motorController.torqueSignal, dCMotor.torqueSignal) annotation(
    Line(points = {{8, 10}, {30, 10}, {30, 11}, {49, 11}}));
  connect(vehicleLongDyn.velocitySignal, motorController.velocitySignalVehicle) annotation(
    Line(points = {{-40, -76}, {-40, -41.5}, {-30, -41.5}, {-30, -9}}));
  connect(environment.distanceSignalIn, vehicleLongDyn.distanceSignal) annotation(
    Line(points = {{-73, 57}, {-73, -26}, {-1, -26}, {-1, -76}}));
  connect(battery.batteryAvailable, dCMotor.batteryAvailable) annotation(
    Line(points = {{56, 60}, {68, 60}, {68, 12}}));
  annotation(
    Diagram);
end NewExample;
