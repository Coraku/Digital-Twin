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
  parameter Real G_gr = 11 "Gear ratio";
  //11:1
  parameter Real eta_gr = 0.95 "Gear system efficiency";
  parameter Real r_tr = 0.30 "Tyre radius";
  //parameter Real phi_slope = 0 "Slope [deg]";    //sobald wir eine Straße haben, wird das zu einem Signal
  //input Real SOC "Battery State of Charge";

  //Flow/Potential Stuff torque and omega from motor
  EVRanger.Interfaces.MechanicalPort vehicleMechanicalPortIn annotation(
    Placement(visible = true, transformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Signals
  EVRanger.Interfaces.DistanceSignal distanceSignal annotation(
    Placement(visible = true, transformation(origin = {-80, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-92, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  EVRanger.Interfaces.AccelerationSignal accelerationSignal annotation(
    Placement(visible = true, transformation(origin = {-74, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output EVRanger.Interfaces.VelocitySignal velocitySignal annotation(
    Placement(visible = true, transformation(origin = {-64, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {30, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

// Forces
  Real F_tr "Tractive force";
  Real F_loss "Sum off all forces opposing F_tr";
  Real F_roll;
  Real F_aero;
  Real F_hill;
  input EVRanger.Interfaces.SlopeSignal slopeSignal annotation(
    Placement(visible = true, transformation(origin = {-88, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
//Signal relations
  velocitySignal.vel = der(distanceSignal.x);
//  zero if SOC too low
//velocitySignal.vel = if SOC > SOC_min then der(distanceSignal.x) else 0;
  accelerationSignal.acc = der(velocitySignal.vel);
//omega_mot relation with tyre radius and vehicle velocity (not 100% correct)
  vehicleMechanicalPortIn.omega = velocitySignal.vel / r_tr;
//conversion of motor torque to a force)
  F_tr = motorTorqueToForce(G_gr = G_gr, r_tr = r_tr, tau_mot = vehicleMechanicalPortIn.tau);

// forces opposing the tractive force
  F_roll = fRollResistance(m = m, g = g, mu_rr = mu_rr, vel = velocitySignal.vel);
  F_aero = fAeroDrag(rho_air = rho_air, A_veh = A_veh, C_d = C_d, v_act = velocitySignal.vel);
  F_hill = fHillClimbing(m = m, g = g, slope = slopeSignal.slope);
  F_loss =  F_roll+F_aero  +F_hill;
// Force balance (0 = F_tr - F_los - m*a)
  m * accelerationSignal.acc = F_tr - F_loss;  
annotation(
    Icon(graphics = {Polygon(origin = {-1, 9}, lineColor = {200, 133, 0}, fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-23, -39}, {-81, -39}, {-81, -1}, {-43, -1}, {-23, 39}, {57, 39}, {63, -1}, {81, -1}, {81, -39}, {-23, -39}}), Ellipse(origin = {-45, -33}, fillPattern = FillPattern.Solid, extent = {{-21, 21}, {21, -21}}, endAngle = 360), Ellipse(origin = {45, -35}, fillPattern = FillPattern.Solid, extent = {{-21, 21}, {21, -21}}, endAngle = 360), Ellipse(origin = {-45, -33}, fillColor = {209, 209, 209}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Ellipse(origin = {45, -35}, fillColor = {209, 209, 209}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Polygon(origin = {-25, 27}, lineColor = {170, 255, 255}, fillColor = {226, 255, 251}, fillPattern = FillPattern.Solid, points = {{-16, -18}, {24, -18}, {24, 18}, {2, 18}, {-16, -18}}), Polygon(origin = {36, 27}, lineColor = {226, 255, 251}, fillColor = {226, 255, 251}, fillPattern = FillPattern.Solid, points = {{-26, 18}, {-26, -18}, {22, -18}, {16, 18}, {-26, 18}}), Rectangle(origin = {-0.846999, -2.13058}, lineThickness = 0.5, extent = {{-88.8994, 62.7404}, {88.8994, -62.7404}})}));
end VehicleLongDyn;
