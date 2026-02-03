within EVRanger;

package Interfaces
extends EVRanger.Icons.InterfacesSymb;
annotation(
  Documentation(info = "<html>
  <head></head>
  <body>
    <h4><b>EVRanger.Interfaces Connectors</b></h4>
    <p>This package contains connector definitions used to represent various physical and signal interfaces in the EVRanger models.</p>
    <table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
      <tr><th>Connector</th><th>Description</th></tr>

      <tr>
        <td><b>AccelerationSignal</b></td>
        <td>Represents acceleration as a real-valued signal (m/s²). Contains a single variable <code>acc</code>.</td>
      </tr>

      <tr>
        <td><b>BatteryAvailableSignal</b></td>
        <td>Indicates battery availability status as a boolean <code>batteryAvailable</code>.</td>
      </tr>

      <tr>
        <td><b>DistanceSignal</b></td>
        <td>Represents distance or position as a real value <code>x</code> (meters).</td>
      </tr>

      <tr>
        <td><b>ElectricalPort</b></td>
        <td>Represents an electrical interface with current (<code>I</code>, flow variable, Amperes) and voltage (<code>V</code>, Volts).</td>
      </tr>

      <tr>
        <td><b>MechanicalPort</b></td>
        <td>Represents a mechanical interface with torque (<code>tau</code>, flow variable, Nm) and angular velocity (<code>omega</code>, rad/s).</td>
      </tr>

      <tr>
        <td><b>MovementPort</b></td>
        <td>Represents a mechanical movement interface with force (<code>F</code>, flow variable, Newtons) and position (<code>r</code>, meters).</td>
      </tr>

      <tr>
        <td><b>RollingResistanceSignal</b></td>
        <td>Represents rolling resistance coefficient as a real value <code>mu_rr</code>.</td>
      </tr>

      <tr>
        <td><b>SlopeSignal</b></td>
        <td>Represents the slope angle in degrees (<code>slope</code>), where 90° is straight up and -90° is straight down.</td>
      </tr>

      <tr>
        <td><b>TorqueSignal</b></td>
        <td>Represents torque demand as a real value <code>tau</code>, typically as a percentage of maximum torque.</td>
      </tr>

      <tr>
        <td><b>VelocitySignal</b></td>
        <td>Represents velocity as a real value <code>vel</code> (m/s).</td>
      </tr>
    </table>
  </body>
  </html>")
);

end Interfaces;
