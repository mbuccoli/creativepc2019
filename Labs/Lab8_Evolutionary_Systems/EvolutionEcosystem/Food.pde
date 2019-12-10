// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Evolution EcoSystem

// A collection of food in the world

class Food {
  ArrayList<PVector> food;
 
  Food(int num) {
    // Start with some food
    food = new ArrayList();
    for (int i = 0; i < num; i++) {
       //...
    }
  } 
  
  // Add some food at a position
  void add(PVector l) {
     //..
  }
  
  // Display the food
  void run() {
    for (PVector f : food) {
      //...
    } 
    
    // There's a small chance food will appear randomly
    //...
  }
  
  // Return the list of food
  ArrayList getFood() {
    return food; 
  }
}
