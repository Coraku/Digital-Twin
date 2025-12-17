within EVRanger.Components;

model MotorController
  parameter Real K = 100;
  Real v_diff;
  //Real a_diff;
  Interfaces.MechanicalPort mechanicalPortOut annotation(
    Placement(transformation(origin = {0, -58}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {78, 4}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.MovementPort movementPortIn annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-30, -52}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.MovementPort DriverInput annotation(
    Placement(transformation(origin = {-66, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-70, 6}, extent = {{-10, -10}, {10, 10}})));
equation
  
  v_diff = der(DriverInput.r) - der(movementPortIn.r);
  //a_diff = 1;
//der(v_diff);
  mechanicalPortOut.tau = v_diff*K;
  mechanicalPortOut.omega = der(movementPortIn.r);
  DriverInput.F = 0;
  
  annotation(
    Icon(graphics = {Rectangle(origin = {0, 5}, lineThickness = 1, extent = {{-36, 17}, {36, -17}}), Text(origin = {0, 6}, extent = {{-26, 8}, {26, -8}}, textString = "Magic"), Text(origin = {-59, 22}, extent = {{-15, 6}, {15, -6}}, textString = "Input"), Text(origin = {54, 13}, extent = {{-14, 6}, {14, -6}}, textString = "Output"), Line(origin = {53, 4}, points = {{-17, 0}, {17, 0}, {17, 0}}), Line(origin = {-30, -29}, points = {{0, -17}, {0, 17}, {0, 17}}), Text(origin = {-7, -32}, extent = {{-19, 8}, {19, -8}}, textString = "Feedback"), Line(origin = {-49, 6}, points = {{13, 0}, {-13, 0}})}),
    Diagram(graphics));
end MotorController;
