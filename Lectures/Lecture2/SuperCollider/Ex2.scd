

// ------ Let's make some noise -----

{ SinOsc.ar(440, 0, 0.2) }.play;


(
d = Server.local.boot;
{ SinOsc.ar(440, 0, 0.2) }.play(d);
)


// use control rate to control the amplitude the sound
(
  { var ampOsc;
	ampOsc = SinOsc.kr(0.5, 1.5pi, 0.5, 0.5);
	SinOsc.ar(440, 0, ampOsc);
}.play;
)

// visualization

{SinOsc.ar}.plot;
{SinOsc.ar}.scope;
{SinOsc.ar}.freqscope;



// ------ Deal with channels -----

// Arrays of UGens will be consider as a multichannel system
{ [SinOsc.ar(440, 0, 0.2), Saw.ar(880,0.2)] }.play;  // Stereo
{ [SinOsc.ar(440, 0, 0.2), SinOsc.ar(880, 0, 0.2)] }.play;  // Stereo

// If UGens are the same in the bith channels, they can be grouped
{SinOsc.ar([440,880], 0, 0.2)}.play;




// ------ Mix the channels -----


// Mix an array of channels down to a single channel ...

(
{
	Mix.new([SinOsc.ar(440, 0, 0.2), Saw.ar(660, 0.2)])
}.play;
)


// ... or an array of arrays of channels down to a single array of channels.

(
{
	var a, b;
	a = [SinOsc.ar(440, 0, 0.2), Saw.ar(662, 0.2)];
	b = [SinOsc.ar(442, 0, 0.2), Saw.ar(660, 0.2)];
	Mix([a, b]);
}.play;

)










