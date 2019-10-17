(
SynthDef("moog", {
	arg midinote=60, amp=0;
	var osc1, osc2, osc3, osc, freq;
	freq=midicps(midinote);
	osc1=Saw.ar(1.0013*freq);
	osc2=Saw.ar(0.998*freq);
	osc3=Saw.ar(0.5*freq);
	osc=osc1+osc2+osc3;
	Out.ar([0,1], amp*osc);}).add;
)


// offline test
(var instr = Synth(\moog);
instr.set(\amp,1);)


//set the server
NetAddr("127.0.0.1",57120);

// online use
(
var instr= Synth(\moog);

OSCdef('OSCreceiver',
	{
		arg msg;

		var freq=msg[1];
		var amp=msg[2];
		freq.postln;
		instr.set(\midinote,freq, \amp, amp);
	},
	"/moog");
)










