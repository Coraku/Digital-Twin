within EVRanger.Functions;

function fRotationalAcceleration
// neglected for now as we have const speed
// Compute rotaional acceleration force: F_wa = I*G^2/(eta_g*r^2)
/* "However, for a more accurate picture of the force needed to accelerate the vehicle
 we should also consider the force needed to make the rotating parts turn faster." */

input Real I_mt "Moment of inertia of rotor of motor";
input Real G_gr "Gear ration";
input Real eta_gr "Gear system efficiency";
input Real r_tr "Tyre radius";
input Real a "Vehicle acc";

output Real F_wa;

algorithm

F_wa := I_mt*G_gr^2 / (eta_gr*r_tr^2) * a;

end fRotationalAcceleration;
