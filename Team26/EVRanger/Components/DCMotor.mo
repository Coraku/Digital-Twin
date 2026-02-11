within EVRanger.Components;

model DCMotor "Basic Lynch Type DC Motor"
  import Modelica.Constants.pi;
  import EVRanger.Functions.*;
  //typical data sheet information
  parameter Units.MotorSpeedConstant motor_speed = 70 "Motor speed";
  parameter Units.Resistance R_a = 0.016 "Armature resistance";
  parameter Units.Current I_lim = 250 "Current limit";
  parameter Units.Torque tau_max = -34 "Maximum torque";
  //Flow&Potential
  EVRanger.Interfaces.ElectricalPort electricalPortIn annotation(
    Placement(visible = true, transformation(origin = {-2, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {30, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  EVRanger.Interfaces.MechanicalPort mechanicalPortOut annotation(
    Placement(visible = true, transformation(origin = {-2, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // Signals
  input EVRanger.Interfaces.TorqueSignal torqueSignal annotation(
    Placement(visible = true, transformation(origin = {-24, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  input EVRanger.Interfaces.BatteryAvailableSignal batteryAvailableSignal annotation(
    Placement(visible = true, transformation(origin = {-88, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-30, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Variables
  Units.MotorConstant KmPhi;
  // K_m*Phi -> motor const*total flux passing through coil
  Units.Voltage V_b "Voltage opposing supply voltage";
  Units.Current I_amature "Amature current";
  Units.Current I_demand "Current necessary to meet torque demand from controller";
  Units.Current I_actual "Possible current, considering I_max, I_demand & I_amature";
  Units.Torque tau_des "Desired torque value, considering the max torque of the motor & controller demand";
equation
//motor constant
  KmPhi = 60/(motor_speed*2*pi);
// tau_des = max torque times the procentual signal
  tau_des = tau_max*torqueSignal.tau;
// Current required to meet controller torque demand
  I_demand = tau_des/KmPhi;
// Voltage opposing supply voltage
  V_b = KmPhi*mechanicalPortOut.omega;
// Check battery availability
  if batteryAvailableSignal.batteryAvailable then
// Amature current for the voltage from the battery
    I_amature = (electricalPortIn.V - V_b)/R_a;
// Limit current to battery capability & motor possibilities
    I_actual = minCurrValue(I_demand, I_amature, I_lim);
  else
    I_amature = 0;
    I_actual = 0;
  end if;
// Assign signal & flow values
  mechanicalPortOut.tau = KmPhi*I_actual;
  electricalPortIn.I = I_actual;
  annotation(
    Icon(graphics = {Ellipse(lineColor = {109, 55, 164}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-30, 30}, {30, -30}}, endAngle = 360), Polygon(origin = {-56, 0}, lineColor = {109, 55, 164}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}}), Polygon(origin = {0, 58}, rotation = -90, lineColor = {109, 55, 164}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}}), Polygon(origin = {59, 0}, rotation = 180, lineColor = {109, 55, 164}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}}), Polygon(origin = {0, -58}, rotation = 90, lineColor = {109, 55, 164}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-20, 20}, {20, 20}, {16, 16}, {12, 10}, {12, 0}, {12, -8}, {16, -16}, {20, -20}, {-20, -20}, {-20, 20}}), Ellipse(origin = {1.03, 0.02}, lineColor = {109, 55, 164}, lineThickness = 2, extent = {{-79.53, 79.21}, {79.53, -79.21}}, endAngle = 360)}),
    Documentation(info = "<html><head></head><body><h4><b>Description</b></h4><div>This model represents a simplified brushed permanent-magnet DC motor of the Lynch type. The motor converts electrical energy supplied by a DC source into mechanical torque. The model captures some of the fundamental behaviour including torque generation, back electromotive force and current limiting.&nbsp;</div><div>The motor is controlled through a nomalised torque demand signal.</div><div><br></div><div><b>Adjustable Parameter</b></div><div><ul><li>motor_speed: Refers to the no load speed [rpm/V].</li><li>R_a: Armature resistance [Ohm].</li><li>I_lim: Limit on the current [A].</li><li>tau_max: Maximum torque the motor can provide [Nm].&nbsp;</li></ul></div><div><b>Process</b></div><div><br></div><div>1. Electromechanical energy conversion</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>The DC motor is modeled using the linear relationship between current, torque and rotational speed. The electromagnetic torque <span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>produced&nbsp;by the motor is proportional to the armature current (I) and the motor constant (K_m):</div><div><div><span class=\"Apple-tab-span\" style=\"white-space: pre;\">							</span><i>tau = K_m*I.</i></div><div><span class=\"Apple-tab-span\" style=\"white-space: pre;\">	</span>The motor constant depends on the magnetic flux, number of turns and the motor geometry.</div><div><br></div><div>2. Back EMF-force</div></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>The rotation of the motor generates a back electromotive force that opposes the applied voltage:</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">							</span><i>V_b = K_m*omega</i></div><div><br></div><div>3. Torque demand &amp; current calculation</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>The motor receives a torque signal from a controller. The demanded torque is then converted into the required armature current, to meet the request of the controller.&nbsp;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>Simultaneously, the physically achievable armature current is computed:</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">							</span><i>I = (V_s-V_b)/R_a</i></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>The actual motor current is then determined by considering the minimum of:</div><div>&nbsp; <span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>- The demanded current</div><div>&nbsp; <span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>- The voltage-limited armature current</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>-&nbsp;The maximum allowable current of the motor.</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>This ensures that the motor operates within the electrical limits while attempting to satisfy the torque request.</div><div><br></div><div>4. Electrical supply availability</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>The model explicitly accounts for battery availability. If the electrical supply is unavailable, the armature current and output torque are set to zero.&nbsp;</div><div><br></div><div><b>Limitations</b></div><div><ul><li>Armature inductance and commutation dynamics are neglected, resulting in instantaneous current response.</li><li>Mechanical losses such as bearing friction, brush losses, and windage are not explicitly modeled.</li><li>Magnetic saturation and nonlinear flux effects are ignored.</li><li>Thermal effects, including temperature-dependent resistance and current derating, are not considered.</li><li>Regenerative operation is not explicitly modeled beyond sign changes in speed and torque.</li></ul></div><div><b>Assumptions</b></div><div><ul><li>The motor operates with constant magnetic flux provided by permanent magnets.</li><li>The armature resistance is constant and independent of temperature.</li><li>The motor operates within the linear torque–speed region described by classical DC motor theory.</li></ul></div><div><b>Literature</b></div><div>Larminie, J., &amp; Lowry, J. (2012). Electric vehicle technology explained. John Wiley &amp; Sons.</div></body></html>"));
end DCMotor;
