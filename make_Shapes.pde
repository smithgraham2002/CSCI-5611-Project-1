void makeShapes(){  
  lines = new Line[13];
  circles = new Circle[12];
  //Sidesr
  lines[0] = new Line(0, new Vec2(50, 500), new Vec2(50, 1000));
  lines[1] = new Line(0, new Vec2(0, 500), new Vec2(50, 500));
  lines[2] = new Line(0, new Vec2(950, 500), new Vec2(950, 1000));
  lines[3] = new Line(0, new Vec2(1000, 500), new Vec2(950, 500));
  lines[4] = new Line(0, new Vec2(0, 135), new Vec2(1000, 135));
  
  //rect(600, 450, 200, 50);
  
  //rectObjects
  lines[5] = new Line(0, new Vec2(600 ,450), new Vec2(800, 450));
  lines[6] = new Line(0, new Vec2(600 ,500), new Vec2(800, 500));
  lines[7] = new Line(0, new Vec2(600, 450), new Vec2(600, 500));
  lines[8] = new Line(0, new Vec2(800, 450), new Vec2(800, 500));

  lines[9] = new Line(0, new Vec2(850, 195), new Vec2(1000, 195));
  lines[10] = new Line(0, new Vec2(850, 215), new Vec2(1000, 215));
  lines[11] = new Line(0, new Vec2(850, 195), new Vec2(850, 215));
  lines[12] = new Line(0, new Vec2(1000, 195), new Vec2(1000, 215));
  
  
  
  //CircleBumpers
  circles[0] = new Circle(1, new Vec2(300, 300), 50);
  circles[1] = new Circle(1, new Vec2(400, 450), 50);
  circles[2] = new Circle(1, new Vec2(200, 450), 50);
  
  circles[3] = new Circle(1, new Vec2(950, 800), 150);
  circles[4] = new Circle(1, new Vec2(50, 800), 150);
  
  circles[5] = new Circle(1, new Vec2(700, 300), 50);
  //invisible Circles
  circles[6] = new Circle(0, new Vec2(600, 450), 1);
  circles[7] = new Circle(0, new Vec2(800, 450), 1);
  circles[8] = new Circle(0, new Vec2(600, 500), 1);
  circles[9] = new Circle(0, new Vec2(800, 500), 1);
  circles[10] = new Circle(0, new Vec2(850, 195), 1);
  circles[11] = new Circle(0, new Vec2(850, 215), 1);
}
