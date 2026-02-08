within EVRanger.Functions;

function fRollResistance
//Compute rolling resistance force: F_rr = mu_rr*m*g

input Real m;
input Real g;
input Real mu_rr "rolling resistance coefficient";
input Real vel;

output Real F_rr;

algorithm

if vel <= 0.0001 then
F_rr := 0;
else
F_rr := mu_rr*m*g;
end if;

annotation(
    Documentation(info = "<html><head></head><body><!--StartFragment--><p data-start=\"78\" data-end=\"118\"><strong data-start=\"78\" data-end=\"118\">Rolling Resistance Force Calculation</strong></p>
<p data-start=\"120\" data-end=\"442\">This function computes the rolling resistance force acting on a vehicle due to tire–road interaction. The force depends on the rolling resistance coefficient, vehicle mass, and gravitational acceleration. To avoid numerical issues at standstill, the rolling resistance force is set to zero for very low vehicle velocities.</p>
<p data-start=\"444\" data-end=\"456\"><strong data-start=\"444\" data-end=\"456\">Equation</strong></p><p data-start=\"444\" data-end=\"456\"><span data-start=\"499\" data-end=\"508\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span><i>F<sub>rr</sub> =&nbsp;</i></span><span data-start=\"590\" data-end=\"597\"><i>μ<sub>rr</sub>*m*g</i></span></p><p data-start=\"444\" data-end=\"456\"><strong data-start=\"499\" data-end=\"508\">Input</strong></p>
<ul data-start=\"510\" data-end=\"681\">
<li data-start=\"510\" data-end=\"540\">
<p data-start=\"512\" data-end=\"540\"><span data-start=\"512\" data-end=\"517\">m</span>: vehicle mass [kg]</p>
</li>
<li data-start=\"541\" data-end=\"587\">
<p data-start=\"543\" data-end=\"587\"><span data-start=\"543\" data-end=\"548\">g</span>: gravitational acceleration [m/s<sup>2</sup>]</p>
</li>
<li data-start=\"588\" data-end=\"637\">
<p data-start=\"590\" data-end=\"637\"><span data-start=\"590\" data-end=\"597\">μ<sub>rr</sub></span>: rolling resistance coefficient <span class=\"katex\"><br></span></p>
</li>
<li data-start=\"638\" data-end=\"681\">
<p data-start=\"640\" data-end=\"681\"><span data-start=\"640\" data-end=\"647\">vel</span>: current vehicle velocity [m/s]</p>
</li>
</ul>
<p data-start=\"683\" data-end=\"693\"><strong data-start=\"683\" data-end=\"693\">Output</strong></p>
<ul data-start=\"695\" data-end=\"736\">
<li data-start=\"695\" data-end=\"736\">
<p data-start=\"697\" data-end=\"736\">F<sub>rr</sub>: rolling resistance force [N]</p></li></ul><!--EndFragment--></body></html>"));
end fRollResistance;
