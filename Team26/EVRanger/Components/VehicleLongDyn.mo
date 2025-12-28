within EVRanger.Components;

model VehicleLongDyn "Models the total tractive forces of the vehicle"
  import EVRanger.Functions.*;
  import EVRanger.Constants;
  // gr->gear, mot->motor, veh->vehicle, tr -> tyre
  // example params of small EV
  parameter Real rho_air = Constants.rho_air "";
  parameter Real g = Constants.g;
  parameter Real m = 1540 "Vehicle mass (passengers+vehicle+battery etc) [kg]"; 
  parameter Real mu_rr = 0.0048 "Rolling resistance coefficient";
  parameter Real A_veh = 1.8 "Frontal area of vehicle [m^2]";
  parameter Real C_d = 0.19 "Drag coefficient";
  parameter Real G_gr = 11 "Gear ratio";//11:1
  parameter Real eta_gr = 0.95 "Gear system efficiency";
  parameter Real r_tr = 0.30 "Tyre radius";
  parameter Real phi_slope = 0 "Slope [deg]"; //sobald wir eine Straße haben, wird das zu einem Signal
  
  //Flow/Potential Stuff torque and omega from motor
  EVRanger.Interfaces.MechanicalPort vehicleMechanicalPortIn annotation(
    Placement(visible = true, transformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  //Signals
  EVRanger.Interfaces.DistanceSignal distanceSignal annotation(
    Placement(visible = true, transformation(origin = {-80, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {26, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  EVRanger.Interfaces.AccelerationSignal accelerationSignal annotation(
    Placement(visible = true, transformation(origin = {-74, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-18, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output EVRanger.Interfaces.VelocitySignal velocitySignal annotation(
    Placement(visible = true, transformation(origin = {-64, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-64, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  // Forces
  Real F_tr "Tractive force";
  Real F_loss "Sum off all forces opposing F_tr";

equation
  
  //Signal relations
  velocitySignal.vel = der(distanceSignal.x);
  accelerationSignal.acc = der(velocitySignal.vel);
  
  //omega_mot relation with tyre radius and vehicle velocity (not 100% correct) 
  vehicleMechanicalPortIn.omega = velocitySignal.vel / r_tr;
  
  //conversion of motor torque to a force)
  F_tr = motorTorqueToForce(G_gr = G_gr, r_tr = r_tr, tau_mot = vehicleMechanicalPortIn.tau);
  
  // forces opposing the tractive force
  F_loss = fRollResistance(m = m, g = g, mu_rr = mu_rr) + fAeroDrag(rho_air = rho_air, A_veh = A_veh, C_d = C_d, v_act = velocitySignal.vel) + fHillClimbing(m = m, g = g, phi_slope = phi_slope);
  
  // Force balance (0 = F_tr - F_los - m*a)
  m * accelerationSignal.acc = F_tr - F_loss;
  
  
annotation(
    Icon(graphics = {Polygon(origin = {3, 1}, lineColor = {200, 133, 0}, fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-23, -39}, {-81, -39}, {-81, -1}, {-43, -1}, {-23, 39}, {57, 39}, {63, -1}, {81, -1}, {81, -39}, {-23, -39}}), Ellipse(origin = {-41, -41}, fillPattern = FillPattern.Solid, extent = {{-21, 21}, {21, -21}}, endAngle = 360), Ellipse(origin = {49, -43}, fillPattern = FillPattern.Solid, extent = {{-21, 21}, {21, -21}}, endAngle = 360), Ellipse(origin = {-41, -41}, fillColor = {209, 209, 209}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Ellipse(origin = {49, -43}, fillColor = {209, 209, 209}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Polygon(origin = {-21, 19}, lineColor = {170, 255, 255}, fillColor = {226, 255, 251}, fillPattern = FillPattern.Solid, points = {{-16, -18}, {24, -18}, {24, 18}, {2, 18}, {-16, -18}}), Polygon(origin = {40, 19}, lineColor = {226, 255, 251}, fillColor = {226, 255, 251}, fillPattern = FillPattern.Solid, points = {{-26, 18}, {-26, -18}, {22, -18}, {16, 18}, {-26, 18}})}));
end VehicleLongDyn;
