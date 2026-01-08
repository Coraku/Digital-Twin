within EVRanger.Examples;

model NewExample
  EVRanger.Components.MinimalDriver minimalDriver annotation(
    Placement(visible = true, transformation(origin = {-79, 67}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  EVRanger.Components.Battery battery annotation(
    Placement(visible = true, transformation(origin = {16, 76}, extent = {{-34, -34}, {34, 34}}, rotation = 0)));
  EVRanger.Components.DCMotor dCMotor annotation(
    Placement(visible = true, transformation(origin = {72, -40}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
  EVRanger.Components.MotorController motorController annotation(
    Placement(visible = true, transformation(origin = {-8, 12}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  EVRanger.Components.VehicleLongDyn vehicleLongDyn annotation(
    Placement(visible = true, transformation(origin = {-10, -72}, extent = {{-44, -44}, {44, 44}}, rotation = 0)));
equation
  connect(motorController.torqueSignal, dCMotor.torqueSignal) annotation(
    Line(points = {{14, 13}, {25.5, 13}, {25.5, -13}, {63, -13}}));
  connect(minimalDriver.velocitySignal, motorController.velocitySignalDriver) annotation(
    Line(points = {{-79, 52}, {-79, 24}, {-28, 24}, {-28, 14}}));
  connect(vehicleLongDyn.velocitySignal, motorController.velocitySignalVehicle) annotation(
    Line(points = {{-40, -78}, {-54, -78}, {-54, -2}, {-16, -2}}));
  connect(dCMotor.mechanicalPortOut, vehicleLongDyn.vehicleMechanicalPortIn) annotation(
    Line(points = {{71, -67}, {20, -67}, {20, -80}}));
  connect(battery.electricalPortOut, dCMotor.electricalPortIn) annotation(
    Line(points = {{46, 78}, {73, 78}, {73, -12}}));
  connect(dCMotor.batteryAvailable, battery.batteryAvailable) annotation(
    Line(points = {{81, -13}, {81, 32}, {58, 32}, {58, 64}, {46, 64}}));
  annotation(
    Diagram);
end NewExample;
