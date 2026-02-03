within EVRanger.Functions;
function R_int_temp_factor

  
    input Real T;
  output Real factor;
algorithm
  if T < 0 then
    factor := 1 + 0.1 * abs(T); // sharper increase below zero, e.g. 10% per degree below zero
  elseif T < 25 then
    factor := 1 + 0.01 * (25 - T);
  else
    factor := 1 + 0.01 * (T - 25);
    
    end if;
  
end R_int_temp_factor;
