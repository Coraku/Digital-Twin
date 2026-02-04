within EVRanger.Functions;

function check_SOC

input Real SOC;
input Real SOC_min;
input Real SOC_max;
input Real I_port;

output Real I_batt;
algorithm

if SOC <= SOC_min then
I_batt := 0;
elseif SOC >= SOC_max then
I_batt := 0;
else
I_batt := I_port;
end if;

 /* I_batt := if SOC <= SOC_min then
             max(I_port, 0) // Allow only charging current if at min SOC
           elseif SOC >= SOC_max then
             min(I_port, 0) // Allow only discharging current if at max SOC
           else
             I_port; //Prevent battery current flow when SOC outside limits  I_batt = if SOC <= SOC_min then
*/

end check_SOC;
