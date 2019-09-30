
(
SynthDef("moog", {
	arg vibr=0, cutoff=0.5, freq=440, amp=0;
	var osc1, osc2, osc3, f0, vib_int, cutoff_freq, delay, fil_osc;
	vib_int=0.7;

	f0=exp(vibr*(0.05*vib_int))*freq;

	osc1=Saw.ar(f0*1.0013);
	osc2=Saw.ar(f0*0.998);
	osc3=Saw.ar(f0*0.5);


	cutoff_freq=((cutoff+0.5)*6)*freq;

	fil_osc=BLowPass.ar(in:osc1+osc2+osc3, freq:cutoff_freq);
	Out.ar([0,1], amp*fil_osc);}).add;

)

(var instr;
instr=Synth(\moog);
instr.set(\amp,1);
)

//set the server
NetAddr("127.0.0.1",57120);

(
var instr;
instr=Synth(\moog);
OSCdef('OSCreceiver',
	{
		arg msg;
		var freq,amp, vibr, cutoff;
		msg.postln;
		freq=msg[1];
		amp=msg[2];
		vibr=msg[3];
		cutoff=msg[4];
		instr.set(\freq,freq, \cutoff,cutoff, \vibr, vibr, \amp,amp);
	},
	"/seabord");
)











