PShape cn;
PShape js;

void setup() {
  size(1200, 900);  
  cn = loadShape("china.svg");
  js = cn.getChild("Jiangsu");
}

void draw() {
  background(255);
  
  // Draw the full map
  shape(cn, -600, -180);
  
  // Disable the colors found in the SVG file
  js.disableStyle();
  // Set our own coloring
  fill(0, 51, 102);
  noStroke();
  // Draw a single state
  shape(js, -600, -180); 
}
