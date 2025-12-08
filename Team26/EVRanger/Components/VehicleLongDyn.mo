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

input Real phi_slope=0;
Real v;
Real a;

Real F_tr;
  EVRanger.Interfaces.MovementPort wheel annotation(
    Placement(visible = true, transformation(origin = {12, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {6, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  EVRanger.Interfaces.MovementPort vehicle annotation(
    Placement(visible = true, transformation(origin = {18, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {8, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation

wheel.x = vehicle.x; //wie qcm
v = der(vehicle.x);
a = der(v);
F_tr = fRollResistance(m=m, g=g, mu_rr=mu_rr) + 
          fAeroDrag(rho_air=rho_air, A_veh=A_veh, C_d=C_d, v_act=v) + 
          fHillClimbing(m=m, g=g, phi_slope=phi_slope) +
          fLinearAcceleration(m=m, a=a) + 
          fRotationalAcceleration(I_mt=I_mt, G_gr=G_gr, eta_gr=eta_gr, r_tr=r_tr, a=a);
vehicle.F = wheel.F-F_tr; //subtract traction Force from input wheel force

annotation(
    Icon(graphics = {Polygon(origin = {3, 1}, lineColor = {200, 133, 0}, fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-23, -39}, {-81, -39}, {-81, -1}, {-43, -1}, {-23, 39}, {57, 39}, {63, -1}, {81, -1}, {81, -39}, {-23, -39}}), Ellipse(origin = {-41, -41}, fillPattern = FillPattern.Solid, extent = {{-21, 21}, {21, -21}}, endAngle = 360), Ellipse(origin = {49, -43}, fillPattern = FillPattern.Solid, extent = {{-21, 21}, {21, -21}}, endAngle = 360), Ellipse(origin = {-41, -41}, fillColor = {209, 209, 209}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Ellipse(origin = {49, -43}, fillColor = {209, 209, 209}, fillPattern = FillPattern.Solid, extent = {{-10, 10}, {10, -10}}, endAngle = 360), Polygon(origin = {-21, 19}, lineColor = {170, 255, 255}, fillColor = {226, 255, 251}, fillPattern = FillPattern.Solid, points = {{-16, -18}, {24, -18}, {24, 18}, {2, 18}, {-16, -18}}), Polygon(origin = {40, 19}, lineColor = {226, 255, 251}, fillColor = {226, 255, 251}, fillPattern = FillPattern.Solid, points = {{-26, 18}, {-26, -18}, {22, -18}, {16, 18}, {-26, 18}})}));
end VehicleLongDyn;
