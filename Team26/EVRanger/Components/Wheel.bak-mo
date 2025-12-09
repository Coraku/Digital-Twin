within EVRanger.Components;

model Wheel
"Torque to Force conversion"

parameter Real r_tr "tire radius";
Real v; //vehicle vel

  EVRanger.Interfaces.MovementPort wheel annotation(
    Placement(visible = true, transformation(origin = {4, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  EVRanger.Interfaces.MechanicalPort axle annotation(
    Placement(visible = true, transformation(origin = {2, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
wheel.F = axle.tau / r_tr;
v = axle.omega*r_tr;
v = der(wheel.x);

annotation(
    Icon(graphics = {Ellipse(origin = {1, -1}, fillColor = {209, 209, 209}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Ellipse(origin = {-1.42109e-14, 1}, fillPattern = FillPattern.Solid, extent = {{-98, 97}, {98, -97}}, endAngle = 360), Ellipse(origin = {3, 1}, fillColor = {209, 209, 209}, fillPattern = FillPattern.Solid, extent = {{-56, 54}, {56, -54}}, endAngle = 360)}));
end Wheel;
