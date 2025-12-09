within EVRanger.Components;

model MotorController
  Interfaces.ElectricalPort electricalPortIn annotation(
    Placement(transformation(origin = {-74, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-72, -18}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.MovementPort movementPortTarget annotation(
    Placement(transformation(origin = {-70, 40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-72, 24}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.ElectricalPort electricalPortOut annotation(
    Placement(transformation(origin = {74, -4}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {78, 4}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.MovementPort movementPortFeedback annotation(
    Placement(transformation(origin = {-70, 62}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-30, -54}, extent = {{-10, -10}, {10, 10}})));
  parameter Real K = 1;// Linear Gain
  Real v_diff;         // between Target and backfed velocity
  Real a_diff;
  
equation
electricalPortOut.V = electricalPortIn.V; // Voltage is taken from the Battery
v_diff = der(movementPortTarget.r) - der(movementPortFeedback.r);
a_diff = der(v_diff);
electricalPortOut.I = a_diff*K;           // Controller Term
electricalPortIn.I = 0;                   // Parameters not needed -> =0 so everything is defined
movementPortTarget.F = 0;

annotation(
    Icon(graphics = {Rectangle(origin = {0, 5}, lineThickness = 1, extent = {{-36, 17}, {36, -17}}), Text(origin = {0, 6}, extent = {{-26, 8}, {26, -8}}, textString = "Magic"), Text(origin = {-59, 4}, extent = {{-15, 6}, {15, -6}}, textString = "Input"), Text(origin = {54, 13}, extent = {{-14, 6}, {14, -6}}, textString = "Output"), Line(origin = {-50, 18}, points = {{-14, 6}, {-2, 6}, {-2, -6}, {14, -6}}), Line(origin = {-50, -12}, points = {{-14, -6}, {-2, -6}, {-2, 4}, {-2, 6}, {14, 6}}), Line(origin = {53, 4}, points = {{-17, 0}, {17, 0}, {17, 0}}), Line(origin = {-30, -29}, points = {{0, -17}, {0, 17}, {0, 17}}), Text(origin = {-7, -32}, extent = {{-19, 8}, {19, -8}}, textString = "Feedback")}),
  Diagram(graphics));
end MotorController;
