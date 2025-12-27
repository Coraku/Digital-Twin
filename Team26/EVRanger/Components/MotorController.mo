within EVRanger.Components;

model MotorController
  parameter Real K = -250; //5
  //parameter Real I = 0.02;
  //Real InputIntegral;
  //Real FeedbackIntegral;
  // controller outputs desired torque signal
  output EVRanger.Interfaces.TorqueSignal torqueSignal annotation(
    Placement(visible = true, transformation(origin = {40, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {78, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // desired velocity from the driver
  input Interfaces.VelocitySignal velocitySignalDriver annotation(
    Placement(visible = true, transformation(origin = {-70, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // acutal velocity from the vehicle
  input Interfaces.VelocitySignal velocitySignalVehicle annotation(
    Placement(visible = true, transformation(origin = {-32, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-32, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  //der(InputIntegral) = velocitySignalDriver.vel;
  //der(FeedbackIntegral) = velocitySignalVehicle.vel;
  torqueSignal.tau = K * (velocitySignalDriver.vel - velocitySignalVehicle.vel)//+ I * ( InputIntegral - FeedbackIntegral);
  annotation(
    Icon(graphics = {Rectangle(origin = {0, 5}, lineThickness = 1, extent = {{-36, 17}, {36, -17}}), Text(origin = {0, 6}, extent = {{-26, 8}, {26, -8}}, textString = "Magic"), Text(origin = {-59, 22}, extent = {{-15, 6}, {15, -6}}, textString = "Input"), Text(origin = {54, 13}, extent = {{-14, 6}, {14, -6}}, textString = "Output"), Line(origin = {53, 4}, points = {{-17, 0}, {17, 0}, {17, 0}}), Line(origin = {-30, -29}, points = {{0, -17}, {0, 17}, {0, 17}}), Text(origin = {-7, -32}, extent = {{-19, 8}, {19, -8}}, textString = "Feedback"), Line(origin = {-49, 6}, points = {{13, 0}, {-13, 0}})}),
    Diagram(graphics));
end MotorController;
