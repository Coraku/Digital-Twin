within EVRanger.Functions;

function fHillClimbing
// Compute hill climbing force: F_hc = m*g*sin(phi)

input Real m;
input Real slope;
input Real g;

output Real F_hc;

algorithm

F_hc := m*g*sin(slope);

annotation(
    Documentation(info = "<html><head></head><body><!--StartFragment--><p data-start=\"126\" data-end=\"161\"><strong data-start=\"126\" data-end=\"161\">Hill Climbing Force Calculation</strong></p>
<p data-start=\"163\" data-end=\"538\">This function computes the hill climbing force acting on a vehicle due to road inclination. The force represents the component of gravitational force acting along the slope and depends on the vehicle mass, gravitational acceleration, and road slope angle. It captures the additional traction demand required when driving uphill and the assisting effect when driving downhill.</p>
<p data-start=\"540\" data-end=\"552\"><strong data-start=\"540\" data-end=\"552\">Equation</strong></p><p data-start=\"540\" data-end=\"552\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span><i>F<sub>hc</sub> = m*g*sin(slope)</i></p><p data-start=\"597\" data-end=\"606\"><strong data-start=\"597\" data-end=\"606\">Input</strong></p>
<ul data-start=\"608\" data-end=\"723\">
<li data-start=\"608\" data-end=\"638\">
<p data-start=\"610\" data-end=\"638\"><span data-start=\"610\" data-end=\"615\">m</span>: vehicle mass [kg]</p>
</li>
<li data-start=\"639\" data-end=\"678\">
<p data-start=\"641\" data-end=\"678\"><span data-start=\"641\" data-end=\"650\">slope</span>: road slope angle [rad]</p>
</li>
<li data-start=\"679\" data-end=\"723\">
<p data-start=\"681\" data-end=\"723\"><span data-start=\"681\" data-end=\"686\">g</span>: gravitational acceleration [m/s<sup>2</sup>]</p>
</li>
</ul>
<p data-start=\"725\" data-end=\"735\"><strong data-start=\"725\" data-end=\"735\">Output</strong></p>
<ul data-start=\"737\" data-end=\"773\">
<li data-start=\"737\" data-end=\"773\">
<p data-start=\"739\" data-end=\"773\"><span data-start=\"739\" data-end=\"746\">F<sub>hc</sub></span>: hill climbing force [N]</p>
</li>
</ul>
<!--EndFragment--></body></html>"));
end fHillClimbing;
