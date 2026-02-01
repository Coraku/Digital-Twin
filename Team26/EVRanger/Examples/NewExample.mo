within EVRanger.Examples;

model NewExample
  EVRanger.Components.DCMotor dCMotor annotation(
    Placement(visible = true, transformation(origin = {68, -14}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
  EVRanger.Components.VehicleLongDyn vehicleLongDyn annotation(
    Placement(visible = true, transformation(origin = {-28, -66}, extent = {{-44, -44}, {44, 44}}, rotation = 0)));
  EVRanger.Components.Environment environment annotation(
    Placement(transformation(origin = {-60.5, 11.4}, extent = {{-27.5, 11}, {27.5, 33}})));
  EVRanger.Components.MotorController motorController annotation(
    Placement(visible = true, transformation(origin = {3, 43}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  EVRanger.Components.MinimalDriver minimalDriver annotation(
    Placement(visible = true, transformation(origin = {-65, 73}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  EVRanger.Components.Battery.Battery battery(operationMode = EVRanger.Components.Battery.Battery.BatteryOperationModeTypes.BatteryOperationMode.ReducedSOH)  annotation(
    Placement(visible = true, transformation(origin = {67, 75}, extent = {{-39, -39}, {39, 39}}, rotation = 0)));
equation
  connect(minimalDriver.velocitySignal, motorController.velocitySignalEnvironment) annotation(
    Line(points = {{-41, 74}, {-21.5, 74}, {-21.5, 45}}));
  connect(motorController.torqueSignal, dCMotor.torqueSignal) annotation(
    Line(points = {{30, 44}, {30, -14}, {36, -14}}));
  connect(dCMotor.mechanicalPortOut, vehicleLongDyn.vehicleMechanicalPortIn) annotation(
    Line(points = {{68, -46}, {68, -71}, {7, -71}}));
  connect(vehicleLongDyn.distanceSignal, minimalDriver.distanceSignalIn) annotation(
    Line(points = {{-64, -71}, {-96, -71}, {-96, 73}, {-89, 73}}));
  connect(vehicleLongDyn.distanceSignal, environment.distanceSignalIn) annotation(
    Line(points = {{-64, -71}, {-88, -71}, {-88, 33}}));
  connect(environment.rollingResistanceSignal, vehicleLongDyn.rollingResistanceSignal) annotation(
    Line(points = {{-33, 29}, {-33, -9}, {-36, -9}, {-36, -44}}));
  connect(environment.slopeSignal, vehicleLongDyn.slopeSignal) annotation(
    Line(points = {{-33, 39}, {-33, -44}, {-22, -44}}));
  connect(motorController.velocitySignalVehicle, vehicleLongDyn.velocitySignal) annotation(
    Line(points = {{-8, 24}, {-8, -9}, {-6, -9}, {-6, -44}}));
  connect(motorController.batteryAvailableSignal, battery.batteryAvailableSignal) annotation(
    Line(points = {{-2, 70}, {38, 70}, {38, 40}, {60, 40}, {60, 54}}));
  connect(dCMotor.batteryAvailableSignal, battery.batteryAvailableSignal) annotation(
    Line(points = {{58, 12}, {60, 12}, {60, 54}}));
  connect(dCMotor.electricalPortIn, battery.electricalPortOut) annotation(
    Line(points = {{78, 14}, {74, 14}, {74, 54}}));
  annotation(
    Diagram);
end NewExample;
