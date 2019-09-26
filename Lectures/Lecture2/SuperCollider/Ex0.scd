

// Use SuperCollider as Matlab...

2+2
pow(2,8);
sqrt(2);


// Messages and Arguments

(
a = 10;
pow(a,2);   // pow is a message and a is the receiver
)


// Nesting

dup({exprand(1.0,1000.0)},10);   // dup return array with 10 evaluation of the function


// Receiver.message

(
a = [10,20,30];
a.postln;
)

[10,20,30].postln;

[10,40,30].sort;

"Hello World!!".postln

{exprand(1.0,1000.0)}.dup(10);


// Receiver.message Nesting
{exprand(1.0,1000.0)}.dup(10).postln;



// Use of array
(
a = [2,3,4];
a = a+4;
a[2] = 3;
a.at(2);
)

// Use of matrix
(
a = [[3,4,5], [6,7,8], [0,1,2]];
a = a+3;
a[1][2];
)

// In the Post Windows the result of the last operation is shown
// If we want to use the message postln

(
a = [[3,4,5], [6,7,8], [0,1,2]];
a = a+3;
postln(a);
postln(a[1][2]);
)


// Other messages exist:
(
a = [2,3,4,3,4,2,1];
plot(a);
)


// Array are classe and takes methods
(
a = [1,2,3,4,5];

postln("Original");
postln(a);

postln("Reversed");
postln(a.reverse);

postln("Mirrored");
postln(a.mirror);

postln("Add 10");
postln(a.add(10));

postln("Put 10");
postln(a.put(2, 10));

postln("Insert 10");
postln(a.insert(2, 10));

postln("Delete 2");
a.removeAt(4);
postln(a);
)


// if statement - all the variable should always decleared
(
var a = 2, z;
z = if (a < 5, { 100 },{ 200 });
postln(z);
)


// while statement
(
i = 0;
while ( { i < 5 }, {
	i = i + 1;
	postln([i, "boing"]);
});
)


// for statement
for (3, 7, {
	arg i; postln(i)
});


// forby statement∏
forBy (0, 8, 2, {
	arg i; postln(i);
});


var at;
at=10;
(
at =at+1;
)







