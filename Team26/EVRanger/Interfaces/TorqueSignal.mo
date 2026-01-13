within EVRanger.Interfaces;

connector TorqueSignal
  Real tau; // % of max torque -> encapsulation, no back and forth
  annotation(
    Icon(graphics = {Ellipse(origin = {3, -3}, fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-95, 95}, {95, -95}}, endAngle = 360)}));
end TorqueSignal;
