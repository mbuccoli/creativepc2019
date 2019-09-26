

// ---- FUNCTIONS -----

(
f = {"Hello World".postln};
f.value;
)


// Arguments

(
g = { arg input; input*2 } ;
g.value(3) ;
)

(
g = { arg input=3; input*2 } ;    // Set default arguments
g.value() ;
)

(
g = { arg input=3; input*2 } ;    // Argumente here is predefined
g.value(10) ;                     // Override the argument
)

(
h = { arg a, b; sqrt((a.pow(2)+b.pow(2))) } ;
h.value(a:4,b:3);
)


// Variables

(
f = { arg a, b;
      var firstResult, finalResult;
      firstResult = a + b;
      finalResult = firstResult * 2;
};
f.value(2, 3);
)


// Variables scope

(
c = 5;
f = { arg a, b;
      var finalResult;
      finalResult = a+b+c;
};
f.value(2, 3);
)

(
var temp = 5;         // If we execute line by line we get an error
f = { arg a, b;
      var finalResult;
      finalResult = a+b+temp;
};
f.value(2, 3);
)



// Nesting functions
f = { arg a; a.value + 3 };
f.value(3);
g = { 3.0.rand; };
f.value(g);     // here the arg is a Function.
f.value(g);     // try it again, different result
