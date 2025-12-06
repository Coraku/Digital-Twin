within EVRanger.Interfaces;

connector ElectricalPort
  flow Real I;
  // Current
  Real V;
  // Voltage
  annotation(
    Diagram(graphics),
    Icon(graphics = {Ellipse(fillColor = {0, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-94, 94}, {94, -94}}), Text(origin = {-3, 2}, extent = {{-131, 72}, {131, -72}}, textString = "E")}));
end ElectricalPort;
