
// ------ Envelopes -----


// We now want a varying filter cutoff over time.
{Line.kr(10000,1000,10)}.plot; // start, end, duration

Env([1,0,1],[1,1,2]).plot        // Specify points of the lines (Y,X)
Env.linen(0.03,0.5,0.1).plot     //linen has attackTime, sustainTime, releaseTime
Env.adsr(0.01, 0.5, 0.5, 0.1, 1.0, 0).plot  //attackTime, decayTime, sustainLevel, releaseTime,peakLevel, curve
Env.perc(0.05,0.5,1.0,0).plot   //arguments attackTime, releaseTime, level, curve: good for percussive hit envelopes


{SinOsc.ar(440,0,0.1)}.scope						//Sine Oscillator goes on forever
{SinOsc.ar(440,0,Line.kr(0.1,0.0,1.0))}.scope
{SinOsc.ar(440,0,Line.kr(0.1,0,1,doneAction:2))}.scope  //doneAction:2 causes the Synth to be terminated once the line generator gets to the end of its line



// To generate an envelope we use EnvGen
// Envelope for Frequency and Amplitude

{
	Saw.ar(
		EnvGen.kr(Env([10000,20],[0.5])),
		EnvGen.kr(Env.perc([0.1,0],[2.0])))
}.scope




