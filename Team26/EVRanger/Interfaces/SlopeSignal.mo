within EVRanger.Interfaces;

connector SlopeSignal
  Real slope; // in Degrees; 90 is Straigth up, -90 Straight down
  annotation(
    Diagram(graphics),
    Icon(graphics = {Ellipse(origin = {1, -18}, extent = {{-71, 62}, {71, -62}}), Ellipse(fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
end SlopeSignal;
