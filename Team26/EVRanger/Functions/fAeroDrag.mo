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

annotation(
    Documentation(info = "<html><head></head><body><!--StartFragment--><p data-start=\"109\" data-end=\"147\"><strong data-start=\"109\" data-end=\"147\">Aerodynamic Drag Force Calculation</strong></p>
<p data-start=\"149\" data-end=\"568\">This function computes the aerodynamic drag force acting on a vehicle based on air density, frontal area, drag coefficient, and vehicle velocity. The drag force is calculated using the standard quadratic drag equation and accounts for the direction of motion by multiplying the velocity with its absolute value. The resulting force always opposes the vehicle’s motion and increases with the square of the vehicle speed.</p><p data-start=\"149\" data-end=\"568\"><b>Equation</b></p><p data-start=\"149\" data-end=\"568\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span><i>F<sub>ad</sub> = 1/2*rho<sub>air</sub>*A<sub>veh</sub>*C<sub>d</sub>*v<sup>2</sup></i></p><p data-start=\"149\" data-end=\"568\"><b>Input</b></p><p data-start=\"149\" data-end=\"568\"></p><ul><li>rho<sub>air</sub>: air density [kg/m<sup>3</sup>]</li><li>A<sub>veh</sub>: frontal vehicle area [m<sup>2</sup>]</li><li>C<sub>d</sub>: drag coefficient</li><li>v<sub>act</sub>: current vehicle velocity [m/s]</li></ul><div><b>Output</b></div><div><ul><li>F<sub>ad</sub>: aeordynamic force&nbsp;[N]</li></ul></div><p></p><p data-start=\"149\" data-end=\"568\"><br></p><!--EndFragment--></body></html>"));
end fAeroDrag;
