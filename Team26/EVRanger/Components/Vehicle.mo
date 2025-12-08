within EVRanger.Components;

model Vehicle
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

input Real v_act;
input Real a;
input Real phi_slope;

output Real F_total;

equation

F_total = fRollResistance(m=m, g=g, mu_rr=mu_rr) + 
          fAeroDrag(rho_air=rho_air, A_veh=A_veh, C_d=C_d, v_act=v_act) + 
          fHillClimbing(m=m, g=g, phi_slope=phi_slope) +
          fLinearAcceleration(m=m, a=a) + 
          fRotationalAcceleration(I_mt=I_mt, G_gr=G_gr, eta_gr=eta_gr, r_tr=r_tr, a=a);


end Vehicle;
