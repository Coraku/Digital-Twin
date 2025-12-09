within EVRanger.Functions;

function motorTorqueToForce

input Real G_gr "Gear ratio";
input Real r_tr "Tyre radius";
input Real tau_mot "Motor torque";

output Real F_tr "tractive force";

algorithm

F_tr := (G_gr/r_tr)*tau_mot;

end motorTorqueToForce;
