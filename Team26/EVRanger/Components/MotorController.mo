within EVRanger.Components;

model MotorController
  // The Motor Controller is also the "Driver"
  import EVRanger.Functions.*;
  Units.Velocity vEnv "Velocity given by the Environment (max legal Velocity)";
  Units.Velocity vVeh "Measured velocity of the Car";
  Real tau "torque of the Motor [%]";
  parameter Real Kp = 100 "Proportional Gain";
  // controller outputs desired torque signal
  output EVRanger.Interfaces.TorqueSignal torqueSignal annotation(
    Placement(visible = true, transformation(origin = {40, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {78, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // desired velocity from the Environment
  input Interfaces.VelocitySignal velocitySignalEnvironment annotation(
    Placement(visible = true, transformation(origin = {-70, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // acutal velocity from the vehicle
  input Interfaces.VelocitySignal velocitySignalVehicle annotation(
    Placement(visible = true, transformation(origin = {-32, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-32, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // Signals if the Battery is empty
  input EVRanger.Interfaces.BatteryAvailableSignal batteryAvailableSignal annotation(
    Placement(visible = true, transformation(origin = {-10, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-12, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // connections
equation
  vEnv = velocitySignalEnvironment.vel;
  vVeh = velocitySignalVehicle.vel;
  torqueSignal.tau = tau;
  if batteryAvailableSignal.batteryAvailable then
//if the Battery is empty, the torque of the Motor becomes 0
    tau = min(Kp*(1 - (vVeh/vEnv)), 1);
  else
    tau = 0;
  end if;
  annotation(
    Icon(graphics = {Rectangle(origin = {0, 5}, lineThickness = 1, extent = {{-36, 17}, {36, -17}}), Text(origin = {0, 6}, extent = {{-26, 8}, {26, -8}}, textString = "Magic"), Text(origin = {-59, 22}, extent = {{-15, 6}, {15, -6}}, textString = "Input"), Text(origin = {54, 13}, extent = {{-14, 6}, {14, -6}}, textString = "Output"), Line(origin = {53, 4}, points = {{-17, 0}, {17, 0}, {17, 0}}), Line(origin = {-30, -29}, points = {{0, -17}, {0, 17}, {0, 17}}), Text(origin = {-7, -32}, extent = {{-19, 8}, {19, -8}}, textString = "Feedback"), Line(origin = {-49, 6}, points = {{13, 0}, {-13, 0}}), Line(origin = {-12, 46}, points = {{0, 24}, {0, -24}, {0, -24}}), Text(origin = {1, 54}, extent = {{-15, 6}, {15, -6}}, textString = "Input")}),
    Diagram(graphics),
    Documentation(info = "<html><head></head><body><p style=\"font-size: 12px;\"><strong><u>Information</u></strong></p><div class=\"textDoc\"><p style=\"font-family: 'Courier New'; font-size: 12px;\"></p></div><div class=\"htmlDoc\" style=\"font-family: 'MS Shell Dlg 2';\"><h4><b>Description</b></h4><h4><div style=\"font-weight: normal;\"><!--StartFragment-->This model represents the motor controller. It calculates the motor torque using a classical feedback control loop with a proportional gain controller. In the case of an empty battery, the motor controller outputs zero torque.<!--EndFragment-->&nbsp;&nbsp;</div><div style=\"font-weight: normal;\"><br></div><div style=\"font-weight: normal;\"><b>Process</b></div><div style=\"font-weight: normal;\"><b><br></b></div><div style=\"font-weight: normal;\"><!--StartFragment-->The controller calculates the motor torque by comparing the actual velocity of the car with the desired velocity provided by the driver. If the battery signals that it has reached the cut-off capacity, the controller stops the motor.<!--EndFragment-->&nbsp;&nbsp;</div></h4></div></body></html>"));
end MotorController;
