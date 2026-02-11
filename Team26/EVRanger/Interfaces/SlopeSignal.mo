within EVRanger.Interfaces;

connector SlopeSignal
  Units.RoadSlope slope "Slope";   // in Degrees; 90 is Straigth up, -90 Straight down
  annotation(
    Diagram(graphics),
    Icon(graphics = {Ellipse(origin = {1, -18}, extent = {{-71, 62}, {71, -62}}, endAngle = 360), Ellipse( fillColor = {255, 255, 127}, fillPattern = FillPattern.Solid, extent = {{-98, 98}, {98, -98}}, endAngle = 360), Text(origin = {1, 16}, extent = {{-99, 80}, {99, -80}}, textString = "β")}));
end SlopeSignal;
