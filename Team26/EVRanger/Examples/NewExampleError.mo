within EVRanger.Examples;

model NewExampleError
  
  extends EVRanger.Icons.ExampleSymb;
  EVRanger.Components.DCMotor dCMotor annotation(
    Placement(visible = true, transformation(origin = {68, -14}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
  EVRanger.Components.VehicleLongDyn vehicleLongDyn annotation(
    Placement(visible = true, transformation(origin = {-18, -66}, extent = {{-44, -44}, {44, 44}}, rotation = 0)));
  EVRanger.Components.Environment environment annotation(
    Placement(transformation(origin = {-62.5, -6.6}, extent = {{-27.5, 11}, {27.5, 33}})));
  EVRanger.Components.MotorController motorController annotation(
    Placement(visible = true, transformation(origin = {13, 43}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  EVRanger.Components.Battery.Battery battery(operationMode = EVRanger.Components.Battery.BatteryOperationModeTypes.BatteryOperationMode.Normal, batteryType = EVRanger.Components.Battery.BatterySelectionTypes.BatterySelection.LFP_60kWh)  annotation(
    Placement(visible = true, transformation(origin = {71, 75}, extent = {{-39, -39}, {39, 39}}, rotation = 0)));
  Components.Driver.MinimalDriver minimalDriver(operationMode = EVRanger.Components.Driver.DriverOperationModeTypes.DriverOperationMode.Normal)  annotation(
    Placement(transformation(origin = {-59, 61}, extent = {{-23, -23}, {23, 23}})));
equation
  connect(battery.batteryAvailableSignal, motorController.batteryAvailableSignal) annotation(
    Line(points = {{64, 54}, {38, 54}, {38, 70}, {9, 70}}));
  connect(motorController.torqueSignal, dCMotor.torqueSignal) annotation(
    Line(points = {{40, 44}, {40, 15}, {36, 15}, {36, -14}}));
  connect(dCMotor.mechanicalPortOut, vehicleLongDyn.vehicleMechanicalPortIn) annotation(
    Line(points = {{68, -46}, {68, -71}, {17, -71}}));
  connect(vehicleLongDyn.distanceSignal, environment.distanceSignalIn) annotation(
    Line(points = {{-54, -71}, {-54, -65}, {-90, -65}, {-90, 15}}));
  connect(motorController.velocitySignalVehicle, vehicleLongDyn.velocitySignal) annotation(
    Line(points = {{2, 25}, {2, -9}, {3, -9}, {3, -44}}));
  connect(battery.electricalPortOut, dCMotor.electricalPortIn) annotation(
    Line(points = {{76, 54}, {78, 54}, {78, 14}}));
  connect(battery.batteryAvailableSignal, dCMotor.batteryAvailableSignal) annotation(
    Line(points = {{64, 54}, {58, 54}, {58, 12}}));
  connect(battery.batteryAvailableSignal, dCMotor.batteryAvailableSignal) annotation(
    Line(points = {{64, 54}, {58, 54}, {58, 12}}));
  connect(battery.electricalPortOut, dCMotor.electricalPortIn) annotation(
    Line(points = {{78, 54}, {78, 14}}));
  connect(battery.batteryAvailableSignal, motorController.batteryAvailableSignal) annotation(
    Line(points = {{64, 54}, {38, 54}, {38, 70}, {-2, 70}}));
  connect(vehicleLongDyn.rollingResistanceSignal, environment.rollingResistanceSignal) annotation(
    Line(points = {{-26, -44}, {-24, -44}, {-24, 12}, {-34, 12}}));
  connect(environment.slopeSignal, vehicleLongDyn.slopeSignal) annotation(
    Line(points = {{-34, 20}, {-12, 20}, {-12, -44}}));
  connect(minimalDriver.velocitySignal, motorController.velocitySignalEnvironment) annotation(
    Line(points = {{-38, 62}, {-12, 62}, {-12, 46}}));
  connect(minimalDriver.distanceSignalIn, vehicleLongDyn.distanceSignal) annotation(
    Line(points = {{-80, 62}, {-96, 62}, {-96, -72}, {-54, -72}}));
  connect(environment.ambientTemperatureSignal, battery.ambientTemperatureSignal) annotation(
    Line(points = {{-46, 6}, {22, 6}, {22, 28}, {88, 28}, {88, 47}, {90, 47}, {90, 84}}, color = {255, 255, 0}));
  annotation(
    Diagram);
end NewExampleError;
