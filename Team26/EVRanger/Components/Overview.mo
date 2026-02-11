within EVRanger.Components;

class Overview
  extends EVRanger.Icons.InfoSymbol;
annotation(
    Documentation(info = "<html><head></head><body><p>
The following components are included within the library:</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody><tr><th>Library Components</th> <th>Description</th></tr>

<tr><td>
 <a href=\"modelica://EVRanger.Components.Battery\">Battery</a>
 </td>
 <td>
 It includes different battery types with their parameters and simulates charge, health, temperature, and electrical behavior.
 </td>
</tr>


<tr><td>
 <a href=\"modelica://EVRanger.Components.DCMotor\">DCMotor</a>
 </td>
 <td>
 It models a simplified Lynch-type brushed DC motor that converts electrical energy into mechanical torque, accounting for torque generation, back-EMF, current limiting, and battery availability.
 </td>
</tr>

<tr><td>
 <a href=\"modelica://EVRanger.Components.Environment\">Environment</a>
 </td>
 <td>
 It models a simple road environment by calculating slope and rolling resistance based on distance, providing key inputs for vehicle dynamics.
 </td>
</tr>

<tr><td>
 <a href=\"modelica://EVRanger.Components.MotorController\">MotorController</a>
 </td>
 <td>
 The controller adjusts torque proportionally to the speed error when the battery is available.
 </td>
</tr>

<tr><td>
 <a href=\"modelica://EVRanger.Components.VehicleLongDyn\">VehicleLongDyn</a>
 </td>
 <td>
 It calculates the vehicle’s total tractive force by combining motor torque with resistive forces like rolling resistance, air drag, and slope, to model longitudinal dynamics.
 </td>
</tr>

<tr><td>
 <a href=\"modelica://EVRanger.Components.Driver\">Driver</a>
 </td>
 <td>
 It models a driver that sets vehicle speed based on legal limits, with options for normal driving or speeding by increasing speed by 20%.
 </td>
</tr>

</tbody></table>

</body></html>"));
end Overview;
