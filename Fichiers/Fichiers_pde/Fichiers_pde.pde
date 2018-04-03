import processing.pdf.*;
boolean drag = false;
void setup()
{
size(400, 400);
smooth();
beginRecord(PDF, "Cercles.pdf");
}
void draw() {
if (drag)
{
float r = dist(pmouseX, pmouseY, mouseX, mouseY) + 5;
ellipse(mouseX, mouseY, r, r);
}
}
void mouseDragged() {
drag = true;
}
void mouseReleased() {
drag = false;
}
void keyPressed() {
endRecord();
exit();
}