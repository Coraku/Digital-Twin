within EVRanger.Examples;

model Examples_NMC_Battery
extends EVRanger.Icons.ExampleSymb;
  EVRanger.Components.DCMotor dCMotor annotation(
    Placement(visible = true, transformation(origin = {66, -16}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
  EVRanger.Components.VehicleLongDyn vehicleLongDyn annotation(
    Placement(visible = true, transformation(origin = {-14, -72}, extent = {{-44, -44}, {44, 44}}, rotation = 0)));
  EVRanger.Components.Environment environment annotation(
    Placement(transformation(origin = {-60.5, 11.4}, extent = {{-27.5, 11}, {27.5, 33}})));
  EVRanger.Components.MotorController motorController annotation(
    Placement(visible = true, transformation(origin = {3, 45}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  EVRanger.Components.Battery.Battery battery(operationMode = EVRanger.Components.Battery.BatteryOperationModeTypes.BatteryOperationMode.Normal, batteryType = EVRanger.Components.Battery.BatterySelectionTypes.BatterySelection.NMC_60kWh)  annotation(
    Placement(visible = true, transformation(origin = {71, 69}, extent = {{-39, -39}, {39, 39}}, rotation = 0)));
  Components.Driver.MinimalDriver minimalDriver(operationMode = EVRanger.Components.Driver.DriverOperationModeTypes.DriverOperationMode.Normal)  annotation(
    Placement(transformation(origin = {-67, 75}, extent = {{-27, -27}, {27, 27}})));
equation
  connect(motorController.torqueSignal, dCMotor.torqueSignal) annotation(
    Line(points = {{30, 46}, {30, 15}, {37, 15}, {37, -16}}));
  connect(dCMotor.mechanicalPortOut, vehicleLongDyn.vehicleMechanicalPortIn) annotation(
    Line(points = {{66, -45}, {66, -77}, {21, -77}}));
  connect(vehicleLongDyn.distanceSignal, environment.distanceSignalIn) annotation(
    Line(points = {{-50, -77}, {-88, -77}, {-88, 33}}));
  connect(motorController.velocitySignalVehicle, vehicleLongDyn.velocitySignal) annotation(
    Line(points = {{-8, 27}, {-8, -9}, {7, -9}, {7, -50}}));
  connect(motorController.batteryAvailableSignal, battery.batteryAvailableSignal) annotation(
    Line(points = {{-1, 72}, {38, 72}, {38, 40}, {64, 40}, {64, 47}}));
  connect(dCMotor.batteryAvailableSignal, battery.batteryAvailableSignal) annotation(
    Line(points = {{55, 11}, {64, 11}, {64, 47}}));
  connect(dCMotor.electricalPortIn, battery.electricalPortOut) annotation(
    Line(points = {{77, 11}, {77, 34.5}, {78, 34.5}, {78, 47}}));
  connect(environment.rollingResistanceSignal, vehicleLongDyn.rollingResistanceSignal) annotation(
    Line(points = {{-32, 20}, {-22, 20}, {-22, -50}}));
  connect(environment.slopeSignal, vehicleLongDyn.slopeSignal) annotation(
    Line(points = {{-32, 30}, {-8, 30}, {-8, -50}}));
  connect(minimalDriver.velocitySignal, motorController.velocitySignalEnvironment) annotation(
    Line(points = {{-43, 76}, {-26, 76}, {-26, 47}, {-21.5, 47}}));
  connect(minimalDriver.distanceSignalIn, vehicleLongDyn.distanceSignal) annotation(
    Line(points = {{-92, 76}, {-98, 76}, {-98, -78}, {-50, -78}}));
  connect(battery.ambientTemperatureSignal, environment.ambientTemperatureSignal) annotation(
    Line(points = {{90, 78}, {98, 78}, {98, 94}, {-38, 94}, {-38, 2}, {-44, 2}, {-44, 16}}));
  annotation(
    Diagram,
    Icon,
  Documentation(info = "<html><head></head><body><!--StartFragment--><p>Example simulation with the NMC battery parameterisation.</p><p><b><u>Parameterisation</u>&nbsp;</b></p><p><b>Battery:</b></p><p></p><ul><li>NMC Battery Parameter</li><li>Initial SOH = 1 (no production faults, battery is 100% healthy)</li></ul><div><b>Environment:</b></div><div><ul><li>Ambient Temperature = 25°C</li><li>Slope = 0</li></ul><div><b>Driver:</b></div></div><div><ul><li>Normal (adheres to speed limit)</li></ul></div><p></p><p><b>DC Motor &amp; Vehicle:&nbsp;</b></p><p></p><ul><li>Default Parameter</li></ul><div><b><u>Description</u></b></div><p></p><p>This example demonstrates a simplified electric vehicle range simulation using an NMC (Nickel Manganese Cobalt) battery model from the EVRanger library.</p><p>The vehicle drivetrain consists of a DC motor, motor controller, and longitudinal vehicle dynamics, operating within a basic environmental model including road slope (set to zero), rolling resistance and ambient temperature at 25°C.</p><p>A minimal driver is set to a 'normal' driver model, which adheres to speed limits. The driver provides the desired velocity while the NMC battery supplies electrical power to the drivetrain and reacts to load and temperature conditions. The example is intended to showcase how battery models can be integrated into a digital twin–based EV simulation to estimate vehicle range at an early development stage.</p><p>The model assumes a lossless motor, no regenerative braking, and a simplified environment, focusing on battery behavior rather than full vehicle complexity.</p><!--EndFragment--></body></html>"));
end Examples_NMC_Battery;
