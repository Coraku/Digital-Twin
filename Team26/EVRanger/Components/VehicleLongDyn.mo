within EVRanger.Components;

model VehicleLongDyn "Models the total tractive forces of the vehicle"
  import EVRanger.Functions.*;
  import EVRanger.Constants;
  // gr->gear, mot->motor, veh->vehicle, tr -> tyre
  // example params of small EV
  parameter Real rho_air = Constants.rho_air;
  parameter Real g = Constants.g;
  parameter Real m = 1540;    //2 drivers + 1400 veh mass
  parameter Real mu_rr = 0.0048;
  parameter Real A_veh = 1.8;
  parameter Real C_d = 0.19;
  parameter Real I_mt = 0.0028;
  parameter Real G_gr = 11;//11:1
  parameter Real eta_gr = 0.95;
  parameter Real r_tr = 0.30;
  parameter Real phi_slope = 0;
  // torque and omega from motor
  EVRanger.Interfaces.MechanicalPort vehicleMechanicalPortIn annotation(
    Placement(visible = true, transformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  EVRanger.Interfaces.DistanceSignal distanceSignal annotation(
    Placement(visible = true, transformation(origin = {-80, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {26, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  EVRanger.Interfaces.AccelerationSignal accelerationSignal annotation(
    Placement(visible = true, transformation(origin = {-74, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-18, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output EVRanger.Interfaces.VelocitySignal velocitySignal annotation(
    Placement(visible = true, transformation(origin = {-64, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-64, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));


Real F_tr;
Real F_loss;

equation

  velocitySignal.vel = der(distanceSignal.x);
  accelerationSignal.acc = der(velocitySignal.vel);
  
  vehicleMechanicalPortIn.omega = velocitySignal.vel / r_tr;
  
  F_tr = motorTorqueToForce(G_gr = G_gr, r_tr = r_tr, tau_mot = vehicleMechanicalPortIn.tau);
  
  F_loss = fRollResistance(m = m, g = g, mu_rr = mu_rr) + fAeroDrag(rho_air = rho_air, A_veh = A_veh, C_d = C_d, v_act = velocitySignal.vel) + fHillClimbing(m = m, g = g, phi_slope = phi_slope);
  
  m * accelerationSignal.acc = F_tr - F_loss;
  
  
annotation(
    Icon(graphics = {Polygon(origin = {3, 1}, lineColor = {200, 133, 0}, fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-23, -39}, {-81, -39}, {-81, -1}, {-43, -1}, {-23, 39}, {57, 39}, {63, -1}, {81, -1}, {81, -39}, {-23, -39}}), Ellipse(origin = {-41, -41}, fillPattern = FillPattern.Solid, extent = {{-21, 21}, {21, -21}}, endAngle = 360), Ellipse(origin = {49, -43}, fillPattern = FillPattern.Solid, extent = {{-21, 21}, {21, -21}}, endAngle = 360), Ellipse(origin = {-41, -41}, fillColor = {209, 209, 209}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Ellipse(origin = {49, -43}, fillColor = {209, 209, 209}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Polygon(origin = {-21, 19}, lineColor = {170, 255, 255}, fillColor = {226, 255, 251}, fillPattern = FillPattern.Solid, points = {{-16, -18}, {24, -18}, {24, 18}, {2, 18}, {-16, -18}}), Polygon(origin = {40, 19}, lineColor = {226, 255, 251}, fillColor = {226, 255, 251}, fillPattern = FillPattern.Solid, points = {{-26, 18}, {-26, -18}, {22, -18}, {16, 18}, {-26, 18}})}));
end VehicleLongDyn;
