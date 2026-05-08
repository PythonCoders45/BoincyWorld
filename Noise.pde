PImage mapImage;

void setup() {
  size(512, 512, P3D); // P3D allows us to see depth if needed
  mapImage = loadImage("your_image.png"); // Make sure image is 256x256
  mapImage.resize(256, 256); // Force size just in case
  noLoop();
}

void draw() {
  background(0);
  
  // Define our elevation colors
  color low = color(34, 139, 34);    // Green (Smallest)
  color mid = color(220, 20, 60);    // Red (Middle)
  color high = color(255, 255, 255); // White (High)

  mapImage.loadPixels();
  
  // Scale the drawing so a 256px image fills the 512px window
  float scl = width / mapImage.width; 

  for (int x = 0; x < mapImage.width; x++) {
    for (int y = 0; y < mapImage.height; y++) {
      
      // Get the brightness of the current pixel (0 to 255)
      int loc = x + y * mapImage.width;
      float bright = brightness(mapImage.pixels[loc]);
      
      // Normalize brightness to a 0.0 - 1.0 scale
      float norm = bright / 255.0;
      
      // Determine the color based on the "height" (brightness)
      color pixelColor;
      if (norm < 0.5) {
        float inter = map(norm, 0, 0.5, 0, 1);
        pixelColor = lerpColor(low, mid, inter);
      } else {
        float inter = map(norm, 0.5, 1, 0, 1);
        pixelColor = lerpColor(mid, high, inter);
      }
      
      // Draw the "height" as a point or a rectangle
      fill(pixelColor);
      noStroke();
      rect(x * scl, y * scl, scl, scl);
    }
  }
}
