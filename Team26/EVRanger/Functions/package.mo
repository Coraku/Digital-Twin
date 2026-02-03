within EVRanger;

package Functions
extends EVRanger.Icons.Function;
annotation(
  Documentation(info = "<html>
  <head></head>
  <body>
    <h4><b>EVRanger.Functions Overview</b></h4>
    <p>This package contains various utility functions for vehicle dynamics, battery management, and environmental modeling in the EVRanger system.</p>
    <table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
      <tr><th>Function</th><th>Description</th><th>Main Inputs</th><th>Main Outputs</th></tr>

      <tr>
        <td><b>checkSOC</b></td>
        <td>Calculates terminal voltage based on state of charge and internal resistance. Returns zero voltage if SOC ≤ 0.</td>
        <td>SOC, battery current (I_batt), electromotive force (E_m), internal resistance (R_int)</td>
        <td>Terminal voltage (V_t)</td>
      </tr>

      <tr>
        <td><b>check_SOC</b></td>
        <td>Limits battery current based on minimum and maximum SOC thresholds to prevent overcharging/discharging.</td>
        <td>SOC, SOC_min, SOC_max, current at port (I_port)</td>
        <td>Battery current (I_batt)</td>
      </tr>

      <tr>
        <td><b>fAeroDrag</b></td>
        <td>Computes aerodynamic drag force on the vehicle.</td>
        <td>Air density (rho_air), frontal vehicle area (A_veh), drag coefficient (C_d), vehicle velocity (v_act)</td>
        <td>Aerodynamic drag force (F_ad)</td>
      </tr>

      <tr>
        <td><b>fHillClimbing</b></td>
        <td>Computes force required to climb a slope based on vehicle mass, gravity, and slope angle.</td>
        <td>Mass (m), slope angle (slope), gravitational acceleration (g)</td>
        <td>Hill climbing force (F_hc)</td>
      </tr>

      <tr>
        <td><b>fLinearAcceleration</b></td>
        <td>Calculates force required for linear acceleration.</td>
        <td>Mass (m), acceleration (a)</td>
        <td>Linear acceleration force (F_la)</td>
      </tr>

      <tr>
        <td><b>fRollResistance</b></td>
        <td>Calculates rolling resistance force depending on rolling resistance coefficient and velocity.</td>
        <td>Mass (m), gravity (g), rolling resistance coefficient (mu_rr), velocity (vel)</td>
        <td>Rolling resistance force (F_rr)</td>
      </tr>

      <tr>
        <td><b>fRotationalAcceleration</b></td>
        <td>Computes force due to rotational acceleration of motor and drivetrain components.</td>
        <td>Rotor inertia (I_mt), gear ratio (G_gr), gear efficiency (eta_gr), tyre radius (r_tr), vehicle acceleration (a)</td>
        <td>Rotational acceleration force (F_wa)</td>
      </tr>

      <tr>
        <td><b>fSlopeGenerator</b></td>
        <td>Generates road slope based on longitudinal position for route simulation.</td>
        <td>Position along route (position)</td>
        <td>Slope value (slope)</td>
      </tr>

      <tr>
        <td><b>fSpeedLimit</b></td>
        <td>Provides speed limit based on vehicle position along a route.</td>
        <td>Position along route (position)</td>
        <td>Speed limit (speed_limit)</td>
      </tr>

      <tr>
        <td><b>minCurrValue</b></td>
        <td>Determines minimum allowed current considering demand, armature current, and limits.</td>
        <td>Demanded current (I_demand), armature current (I_amature), current limit (I_lim)</td>
        <td>Minimum current value (minValue)</td>
      </tr>

      <tr>
        <td><b>motorTorqueToForce</b></td>
        <td>Converts motor torque to tractive force at the wheels.</td>
        <td>Gear ratio (G_gr), tyre radius (r_tr), motor torque (tau_mot)</td>
        <td>Tractive force (F_tr)</td>
      </tr>

      <tr>
        <td><b>OCV_from_SOC</b></td>
        <td>Calculates open-circuit voltage based on battery state of charge using a quadratic approximation.</td>
        <td>State of charge (SOC)</td>
        <td>Open-circuit voltage (V_oc)</td>
      </tr>

      <tr>
        <td><b>Q_nom_temp</b></td>
        <td>Computes effective battery capacity adjusted by temperature effects.</td>
        <td>Temperature (T), nominal capacity (Q_nom)</td>
        <td>Effective capacity (Q_eff)</td>
      </tr>

      <tr>
        <td><b>R_int_temp_factor</b></td>
        <td>Calculates temperature-based factor to adjust internal resistance.</td>
        <td>Temperature (T)</td>
        <td>Resistance factor (factor)</td>
      </tr>

      <tr>
        <td><b>fFrictionGenerator</b></td>
        <td>Generates constant friction value (placeholder for more detailed friction models).</td>
        <td>Position</td>
        <td>Friction value</td>
      </tr>

    </table>
  </body>
  </html>")
);

end Functions;
