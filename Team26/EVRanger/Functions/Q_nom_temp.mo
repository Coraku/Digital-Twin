within EVRanger.Functions;

function Q_nom_temp
 //input Real T;      // battery temperature
  //input Real Q_nom;  // nominal capacity passed in
 // output Real Q_eff; // effective capacity
//algorithm
//  if T < 0 then
//    Q_eff := Q_nom * (1 - 0.2 * abs(T)/25);
 // elseif T < 25 then
   // Q_eff := Q_nom * (1 - 0.1 * (25 - T)/25);
  //else
    //Q_eff := Q_nom;
  //end if;
  


  
   input Real T;
  input Real Q_nom;
  output Real Q_eff;
algorithm
  if T < 0 then
    Q_eff := Q_nom * 0.5; // Capacity drops to 50% below freezing
  elseif T < 15 then
    Q_eff := Q_nom * (0.5 + 0.0333 * T); // Linear interpolation from 0.5 (0°C) to 1 (15°C)
  else
    Q_eff := Q_nom;



end if;

end Q_nom_temp;
