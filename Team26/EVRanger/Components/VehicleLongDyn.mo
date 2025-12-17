within EVRanger.Components;

model VehicleLongDyn
"Models the total tractive forces of the vehicle"
import EVRanger.Functions.*;
import EVRanger.Constants;

// gr->gear, mot->motor, veh->vehicle, tr -> tyre
// example params of small EV

parameter Real rho_air = Constants.rho_air;
parameter Real g = Constants.g;
parameter Real m = 1540; //2 drivers + 1400 veh mass
parameter Real mu_rr = 0.0048;
parameter Real A_veh = 1.8;
parameter Real C_d = 0.19;
parameter Real I_mt = 0.0028;
parameter Real G_gr = 11; //11:1
parameter Real eta_gr = 0.95;
parameter Real r_tr = 0.30;

parameter Real phi_slope=0;
Real v(start=0, fixed=false) "Vehicle velocity";
Real a;

Real F_tr;
Real F_loss;

Interfaces.MechanicalPort motor annotation(
    Placement(visible = true, transformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.MovementPort vehicle annotation(
    Placement(visible = true, transformation(origin = {66, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {66, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation


v = der(vehicle.r);
a = der(v);
//der(motor.omega) = G_gr*(a/r_tr);
vehicle.F = m*a;

F_tr = motorTorqueToForce(G_gr=G_gr, r_tr=r_tr, tau_mot=motor.tau);

F_loss = fRollResistance(m=m, g=g, mu_rr=mu_rr) + 
          fAeroDrag(rho_air=rho_air, A_veh=A_veh, C_d=C_d, v_act=v) + 
          fHillClimbing(m=m, g=g, phi_slope=phi_slope);
          fLinearAcceleration(m=m, a=a);
          
vehicle.F = F_tr - F_loss;


annotation(
    Icon(graphics = {Polygon(origin = {3, 1}, lineColor = {200, 133, 0}, fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-23, -39}, {-81, -39}, {-81, -1}, {-43, -1}, {-23, 39}, {57, 39}, {63, -1}, {81, -1}, {81, -39}, {-23, -39}}), Ellipse(origin = {-41, -41}, fillPattern = FillPattern.Solid, extent = {{-21, 21}, {21, -21}}, endAngle = 360), Ellipse(origin = {49, -43}, fillPattern = FillPattern.Solid, extent = {{-21, 21}, {21, -21}}, endAngle = 360), Ellipse(origin = {-41, -41}, fillColor = {209, 209, 209}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Ellipse(origin = {49, -43}, fillColor = {209, 209, 209}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Polygon(origin = {-21, 19}, lineColor = {170, 255, 255}, fillColor = {226, 255, 251}, fillPattern = FillPattern.Solid, points = {{-16, -18}, {24, -18}, {24, 18}, {2, 18}, {-16, -18}}), Polygon(origin = {40, 19}, lineColor = {226, 255, 251}, fillColor = {226, 255, 251}, fillPattern = FillPattern.Solid, points = {{-26, 18}, {-26, -18}, {22, -18}, {16, 18}, {-26, 18}})}));
end VehicleLongDyn;
