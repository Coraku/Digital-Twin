within EVRanger.Examples;

model NewExampleError
  
  extends EVRanger.Icons.ExampleSymb;
  EVRanger.Components.DCMotor dCMotor annotation(
    Placement(visible = true, transformation(origin = {68, -14}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
  EVRanger.Components.VehicleLongDyn vehicleLongDyn annotation(
    Placement(visible = true, transformation(origin = {-18, -66}, extent = {{-44, -44}, {44, 44}}, rotation = 0)));
  EVRanger.Components.Environment environment annotation(
    Placement(visible = true, transformation(origin = {-64.5, 11.4}, extent = {{-27.5, 11}, {27.5, 33}}, rotation = 0)));
  EVRanger.Components.MotorController motorController annotation(
    Placement(visible = true, transformation(origin = {13, 43}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  EVRanger.Components.MinimalDriver minimalDriver annotation(
    Placement(visible = true, transformation(origin = {-67, 73}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  EVRanger.Components.Battery.Battery battery(operationMode = EVRanger.Components.Battery.BatteryOperationModeTypes.BatteryOperationMode.ReducedSOH)  annotation(
    Placement(visible = true, transformation(origin = {71, 75}, extent = {{-39, -39}, {39, 39}}, rotation = 0)));
equation
  connect(minimalDriver.velocitySignal, motorController.velocitySignalEnvironment) annotation(
    Line(points = {{-43, 74}, {-11.5, 74}, {-11.5, 45}}));
  connect(battery.batteryAvailableSignal, motorController.batteryAvailableSignal) annotation(
    Line(points = {{64, 54}, {38, 54}, {38, 70}, {9, 70}}));
  connect(motorController.torqueSignal, dCMotor.torqueSignal) annotation(
    Line(points = {{40, 44}, {40, 15}, {36, 15}, {36, -14}}));
  connect(dCMotor.mechanicalPortOut, vehicleLongDyn.vehicleMechanicalPortIn) annotation(
    Line(points = {{68, -46}, {68, -71}, {17, -71}}));
  connect(vehicleLongDyn.distanceSignal, minimalDriver.distanceSignalIn) annotation(
    Line(points = {{-54, -71}, {-96, -71}, {-96, 73}, {-91, 73}}));
  connect(vehicleLongDyn.distanceSignal, environment.distanceSignalIn) annotation(
    Line(points = {{-54, -71}, {-92, -71}, {-92, 25}}));
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
  connect(environment.rollingResistanceSignal, vehicleLongDyn.rollingResistanceSignal) annotation(
    Line(points = {{-36, 20}, {-26, 20}, {-26, -44}}));
  connect(environment.slopeSignal, vehicleLongDyn.slopeSignal) annotation(
    Line(points = {{-36, 30}, {-12, 30}, {-12, -44}}));
  annotation(
    Diagram);
end NewExampleError;
