within EVRanger.Functions;

function fAeroDrag
// Compute aerodynamic drag force: F_ad = 1/2*roh_air*A*C_d*v^2

input Real rho_air "Air density";
input Real A_veh "Frontal vehicle area (ID.4)";
input Real C_d "Drag coefficient";
input Real v_act "Actual vehicle velocity";

output Real F_ad;

algorithm

F_ad := 0.5*rho_air*A_veh*C_d*(v_act*abs(v_act));

end fAeroDrag;
