within EVRanger.Examples;

model NewExample
  EVRanger.Components.Battery battery annotation(
    Placement(visible = true, transformation(origin = {70, 74}, extent = {{-34, -34}, {34, 34}}, rotation = 0)));
  EVRanger.Components.DCMotor dCMotor annotation(
    Placement(visible = true, transformation(origin = {68, -14}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
  EVRanger.Components.VehicleLongDyn vehicleLongDyn annotation(
    Placement(visible = true, transformation(origin = {-32, -66}, extent = {{-44, -44}, {44, 44}}, rotation = 0)));
  EVRanger.Components.Environment environment annotation(
    Placement(visible = true, transformation(origin = {-64.5, 17.4}, extent = {{-27.5, 11}, {27.5, 33}}, rotation = 0)));
  EVRanger.Components.MotorController motorController annotation(
    Placement(visible = true, transformation(origin = {3, 43}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  EVRanger.Components.MinimalDriver minimalDriver annotation(
    Placement(visible = true, transformation(origin = {-65, 73}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
equation
  connect(minimalDriver.velocitySignal, motorController.velocitySignalEnvironment) annotation(
    Line(points = {{-41, 74}, {-21.5, 74}, {-21.5, 45}}));
  connect(vehicleLongDyn.velocitySignal, motorController.velocitySignalVehicle) annotation(
    Line(points = {{-18, -38}, {-18, -8.5}, {-8, -8.5}, {-8, 25}}));
  connect(battery.batteryAvailableSignal, motorController.batteryAvailableSignal) annotation(
    Line(points = {{64, 54}, {42, 54}, {42, 80}, {-1, 80}, {-1, 70}}));
  connect(battery.batteryAvailableSignal, dCMotor.batteryAvailableSignal) annotation(
    Line(points = {{64, 54}, {57, 54}, {57, 18}}));
  connect(battery.electricalPortOut, dCMotor.electricalPortIn) annotation(
    Line(points = {{76, 54}, {86, 54}, {86, 18}}));
  connect(motorController.torqueSignal, dCMotor.torqueSignal) annotation(
    Line(points = {{30, 44}, {30, -14}, {36, -14}}));
  connect(dCMotor.mechanicalPortOut, vehicleLongDyn.vehicleMechanicalPortIn) annotation(
    Line(points = {{68, -46}, {68, -68}, {8, -68}}));
  connect(environment.slopeSignal, vehicleLongDyn.slopeSignal) annotation(
    Line(points = {{-37, 31}, {-37, -22}, {-54, -22}, {-54, -38}}));
  connect(vehicleLongDyn.distanceSignal, minimalDriver.distanceSignalIn) annotation(
    Line(points = {{-72, -68}, {-96, -68}, {-96, 73}, {-89, 73}}));
  connect(vehicleLongDyn.distanceSignal, environment.distanceSignalIn) annotation(
    Line(points = {{-72, -68}, {-96, -68}, {-96, 31}, {-92, 31}}));
  annotation(
    Diagram);
end NewExample;
