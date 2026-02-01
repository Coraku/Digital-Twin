within EVRanger.Examples;

model NewExample
  EVRanger.Components.DCMotor dCMotor annotation(
    Placement(visible = true, transformation(origin = {72, -16}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
  EVRanger.Components.VehicleLongDyn vehicleLongDyn annotation(
    Placement(visible = true, transformation(origin = {-14, -72}, extent = {{-44, -44}, {44, 44}}, rotation = 0)));
  EVRanger.Components.Environment environment annotation(
    Placement(transformation(origin = {-60.5, 11.4}, extent = {{-27.5, 11}, {27.5, 33}})));
  EVRanger.Components.MotorController motorController annotation(
    Placement(visible = true, transformation(origin = {9, 43}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  EVRanger.Components.MinimalDriver minimalDriver annotation(
    Placement(visible = true, transformation(origin = {-65, 73}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  EVRanger.Components.Battery.Battery battery(operationMode = EVRanger.Components.Battery.BatteryOperationModeTypes.BatteryOperationMode.Normal)  annotation(
    Placement(visible = true, transformation(origin = {75, 77}, extent = {{-39, -39}, {39, 39}}, rotation = 0)));
equation
  connect(minimalDriver.velocitySignal, motorController.velocitySignalEnvironment) annotation(
    Line(points = {{-41, 74}, {-15.5, 74}, {-15.5, 45}}));
  connect(motorController.torqueSignal, dCMotor.torqueSignal) annotation(
    Line(points = {{36, 44}, {36, 15}, {43, 15}, {43, -16}}));
  connect(dCMotor.mechanicalPortOut, vehicleLongDyn.vehicleMechanicalPortIn) annotation(
    Line(points = {{72, -45}, {72, -77}, {21, -77}}));
  connect(vehicleLongDyn.distanceSignal, minimalDriver.distanceSignalIn) annotation(
    Line(points = {{-50, -77}, {-96, -77}, {-96, 73}, {-89, 73}}));
  connect(vehicleLongDyn.distanceSignal, environment.distanceSignalIn) annotation(
    Line(points = {{-50, -77}, {-88, -77}, {-88, 33}}));
  connect(motorController.velocitySignalVehicle, vehicleLongDyn.velocitySignal) annotation(
    Line(points = {{-2, 25}, {-2, -9}, {7, -9}, {7, -50}}));
  connect(motorController.batteryAvailableSignal, battery.batteryAvailableSignal) annotation(
    Line(points = {{5, 70}, {38, 70}, {38, 40}, {68, 40}, {68, 55}}));
  connect(dCMotor.batteryAvailableSignal, battery.batteryAvailableSignal) annotation(
    Line(points = {{61, 11}, {68, 11}, {68, 55}}));
  connect(dCMotor.electricalPortIn, battery.electricalPortOut) annotation(
    Line(points = {{83, 11}, {83, 34.5}, {82, 34.5}, {82, 55}}));
  connect(environment.rollingResistanceSignal, vehicleLongDyn.rollingResistanceSignal) annotation(
    Line(points = {{-32, 20}, {-22, 20}, {-22, -50}}));
  connect(environment.slopeSignal, vehicleLongDyn.slopeSignal) annotation(
    Line(points = {{-32, 30}, {-8, 30}, {-8, -50}}));
  annotation(
    Diagram);
end NewExample;
