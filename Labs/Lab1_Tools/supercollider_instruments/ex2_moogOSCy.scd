(
SynthDef("moog0", {
	arg freq=440, amp=0;
	var osc1;

	osc1=Saw.ar(freq);


	Out.ar([0,1], amp*osc1);}).add;
)

(var instr = Synth(\moog0);
instr.set(\amp,1);)

(
SynthDef("moog1", {
	arg freq=440, amp=0;
	var osc1, osc2, osc;

	osc1=Saw.ar(1.0013*freq);
	osc2=Saw.ar(0.998*freq);
	osc=osc1+osc2;
	Out.ar([0,1], amp*osc);}).add;
)

(var instr = Synth(\moog1);
instr.set(\amp,1);)

(
SynthDef("moog2", {
	arg freq=440, amp=0;
	var osc1, osc2, osc3, osc;

	osc1=Saw.ar(1.0013*freq);
	osc2=Saw.ar(0.998*freq);
	osc3=Saw.ar(0.5*freq);
	osc=osc1+osc2+osc3;
	Out.ar([0,1], amp*osc);}).add;
)

(var instr = Synth(\moog2);
instr.set(\amp,1);)


//set the server
NetAddr("127.0.0.1",57120);

// online use
(
var instr;
instr = Synth(\moog2);


OSCdef('OSCreceiver',
	{
		arg msg;

		var freq=msg[1];


		instr.set(\freq,freq, \amp,1));
	},
	"/proc2");
)

OSCdef('OSCreceiver',
	{
		arg msg;

		var freq, lPosX, lPosY, lPosZ, lRotR, lRotP, lRotY;
		var rBool, rPosX, rPosY, rPosZ, rRotR, rRotP, rRotY;
		var lGrab, rGrab;
		var freq, cutoff;
		var pentatonic;
		pentatonic=[36, 38, 40, 43, 45, 48, 50, 52, 55, 57, 60, 62, 64, 67, 69, 72, 74, 76, 79, 81, 84];
		lBool=msg[1];
		lPosX=msg[2];
		lPosY=msg[3];
		lPosZ=msg[4];
		rRotR=msg[5];
		rRotP=msg[6];
		rRotY=msg[7];

		rBool=msg[8];
		rPosX=msg[9];
		rPosY=msg[10];
		rPosZ=msg[11];
		rRotR=msg[12];
		rRotP=msg[13];
		rRotY=msg[14];
		//rBool.postln;

		lGrab=msg[15];
		rGrab=msg[16];

		// not pentatonic
		//freq=(round((rPosX*48)+36)).midicps;

		// pentatonic
		freq=(pentatonic.at(rPosX*pentatonic.size)).midicps;
		cutoff=1;

		instr.set(\freq,freq, \cutoff,rPosZ, \vibr, rRotP, \amp,rPosY*rBool*(1-rGrab));
	},
	"/hand");
)

(
SynthDef("moog3", {
	arg freq=440, amp=0;
	var osc1, osc2, osc3, osc;
	var cutoff_freq=6*freq;
	var lp_osc;
	osc1=Saw.ar(1.0013*freq);
	osc2=Saw.ar(0.998*freq);
	osc3=Saw.ar(0.5*freq);
	osc=osc1+osc2+osc3;
	lp_osc = BLowPass.ar(in: osc, freq: cutoff_freq);
	Out.ar([0,1], amp*lp_osc);}).add;
)

(var instr = Synth(\moog3);
instr.set(\amp,1);)



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
	//delay=DelayN.ar(in:fil_osc, delaytime:0.5)+fil_osc;//!2;

	Out.ar([0,1], amp*fil_osc);}).add;
)


(
var instr;
instr= Synth(\moog);
instr.set(\amp,1);
)

// offline test (skip when online)









