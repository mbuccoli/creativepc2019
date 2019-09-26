
// ------ SynthDef -----
(
SynthDef(\s1, {
	var out, freq = 440;
	out = SinOsc.ar(freq);
	Out.ar(0, out)
}).add;
)

Synth(\s1);


// Use play to add and play

(
SynthDef(\one_tone_only, {
	var out, freq = 440;
	out = SinOsc.ar(freq);
	Out.ar(0, out)
}).play
)


// Parameters of the Synth
(
SynthDef(\s1, {
	arg freq = 440;
	var out;
	out = SinOsc.ar(freq);
	Out.ar(0, out);
}).add
)

Synth(\s1,[\freq,550]);
Synth(\s1,[\freq,880]);


// Multichannel
(
SynthDef(\s1, {
	arg freq1 = 440, freq2 = 880;
	var out;
	out = SinOsc.ar([freq1,freq2]);
	Out.ar([0,1], out);
}).add
)

Synth(\s1,[\freq1,550,\freq2,1000]);



(
SynthDef(\s1, {
	arg freq1 = 4400, pan = 0;
	var out;
	out = SinOsc.ar(freq1);
	Out.ar(0, Pan2.ar(out,pan));
}).add
)

Synth(\s1,[\freq1,1000, \pan,-1]);



(
SynthDef(\s1, {
	arg freq = 1000, pan = 0;
	var out;
	freq = MouseY.kr(minval:60,maxval:6000);
	out = SinOsc.ar(freq);
	pan = MouseX.kr(minval:-1,maxval:1);
	Out.ar(0, Pan2.ar(out,pan));
}).add
)

(
Synth(\s1);
)




// Once the Synth it is added to the server it cannot ba changed. It is possible to interact with it by using arguments and the set message
// The use of variable allows many operations and create different independent instances of the same Synth
(
SynthDef(\s1, {
	arg freq = 440, amp = 0.5;
	var out;
	out = SinOsc.ar(freq,mul:amp);
	Out.ar(0, out)
}).add
)

a = Synth(\s1, [\freq, 64.midicps]);
b = Synth(\s1, [\freq, 67.midicps]);
c = Synth(\s1, [\freq, 72.midicps]);
a.set(\freq, 65.midicps);
c.set(\freq, 71.midicps);
a.set(\freq, 64.midicps);
c.set(\freq, 72.midicps);
a.free;    // erase the instance a from the server:
b.free;
c.free;


// LFO
(
SynthDef(\s1, {
	arg freq1 = 4400, pan = 0;
	var out, lfo;
	lfo = SinOsc.kr(MouseX.kr(0.1,20));
	out = LFSaw.ar(freq1,mul:0.1)+SinOsc.ar(freq1)+SinOsc.ar((freq1/2));
	Out.ar(0, Pan2.ar(out*lfo,pan));
}).add
)

Synth(\s1,[\freq1,40, \pan,0]);






