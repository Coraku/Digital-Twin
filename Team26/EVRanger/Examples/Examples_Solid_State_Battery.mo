within EVRanger.Examples;

model Examples_Solid_State_Battery
  extends Icons.ExampleSymb;
  Components.DCMotor dCMotor annotation(
    Placement(visible = true, transformation(origin = {72, -16}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
  Components.VehicleLongDyn vehicleLongDyn annotation(
    Placement(visible = true, transformation(origin = {-14, -72}, extent = {{-44, -44}, {44, 44}}, rotation = 0)));
  Components.Environment environment annotation(
    Placement(transformation(origin = {-60.5, 11.4}, extent = {{-27.5, 11}, {27.5, 33}})));
  Components.MotorController motorController annotation(
    Placement(visible = true, transformation(origin = {9, 43}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Components.Battery.Battery battery(operationMode = Components.Battery.BatteryOperationModeTypes.BatteryOperationMode.Normal, batteryType = EVRanger.Components.Battery.BatterySelectionTypes.BatterySelection.SolidState_60kWh) annotation(
    Placement(visible = true, transformation(origin = {75, 77}, extent = {{-39, -39}, {39, 39}}, rotation = 0)));
  Components.Driver.MinimalDriver minimalDriver(operationMode = Components.Driver.DriverOperationModeTypes.DriverOperationMode.Normal) annotation(
    Placement(transformation(origin = {-67, 75}, extent = {{-27, -27}, {27, 27}})));
equation
  connect(motorController.torqueSignal, dCMotor.torqueSignal) annotation(
    Line(points = {{36, 44}, {36, 15}, {43, 15}, {43, -16}}));
  connect(dCMotor.mechanicalPortOut, vehicleLongDyn.vehicleMechanicalPortIn) annotation(
    Line(points = {{72, -45}, {72, -77}, {21, -77}}));
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
  connect(minimalDriver.velocitySignal, motorController.velocitySignalEnvironment) annotation(
    Line(points = {{-43, 76}, {-26, 76}, {-26, 46}, {-16, 46}}));
  connect(minimalDriver.distanceSignalIn, vehicleLongDyn.distanceSignal) annotation(
    Line(points = {{-92, 76}, {-98, 76}, {-98, -78}, {-50, -78}}));
  connect(environment.ambientTemperatureSignal, battery.ambientTemperatureSignal) annotation(
    Line(points = {{-44, 24}, {94, 24}, {94, 86}}, color = {255, 255, 0}));
   annotation(
    Diagram,
    Documentation(info = "<html><head></head><body><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">Example simulation with the Solid State battery parameterisation.</p><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">It showcases the easy switch between battery parametrisations, to estimate the range of the specified model.</p><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><b><u>Parameterisation</u>&nbsp;</b></p><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><b>Battery:</b></p><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"></p><ul style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><li>Solid State Battery Parameter</li><li>Initial SOH = 1 (no production faults, battery is 100% healthy)</li></ul><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><b>Environment:</b></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><ul><li>Ambient Temperature = 25°C</li><li>Slope = 0</li></ul><div><b>Driver:</b></div></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><ul><li>Normal (adheres to speed limit)</li></ul></div><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"></p><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><b>DC Motor &amp; Vehicle:&nbsp;</b></p><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"></p><ul style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><li>Default Parameter</li></ul></body></html>"));
end  Examples_Solid_State_Battery;
