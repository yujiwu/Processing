PShape cn;

void setup() {
  size(1200, 900);
  // Load the shape
  cn = loadShape("china.svg");
}

void draw() {
    background(#121111);
    // Center where we will draw all the vertices
    translate(width/2 - cn.width/2, height/2- cn.height/2);
  
    int noChild = cn.getChildCount();
    for (int i=0; i<noChild; i++){
        PShape child = cn.getChild(i);
        int noVertex = child.getVertexCount();
        for (int j=0; j<noVertex; j++){
            PVector v = child.getVertex(j);
            stroke((frameCount + (i+1)*j) % 255);
            point(v.x, v.y);
        }
    }
}
