within EVRanger.Functions;

function minCurrValue
input Real I_demand;
input Real I_amature;
input Real I_lim;

output Real minValue;
algorithm

if I_demand > I_amature then
 minValue := min(I_amature, I_lim);
else
 minValue := min(I_demand, I_lim);
end if;

end minCurrValue;
