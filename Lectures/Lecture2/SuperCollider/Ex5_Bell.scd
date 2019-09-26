

// Bell

SynthDef(\bell,
	{
		var out;
		f = [0.56, 0.56, 0.92, 0.92, 1.19, 1.7, 2, 2.74, 3, 3.76, 4.07];
		a = [1, 0.67, 1, 1.8, 2.67, 1.67, 1.46, 1.33, 1.33, 1, 1.33];
		out = Mix(
			SinOsc.ar(500*f,0,0.1*a))*EnvGen.kr(Env.perc(0.005, 4, 1, -4.5),doneAction: 2);
		Out.ar(0,Pan2.ar(out,0));
	}
).add;

Synth(\bell);




// Complete Bell
(
SynthDef(\risset, { arg out= 0, pan= 0, freq= 400, amp= 0.1, dur= 2, t_trig=1;
	var amps= [1, 0.67, 1, 1.8, 2.67, 1.67, 1.46, 1.33, 1.33, 1, 1.33];
	var durs= [1, 0.9, 0.65, 0.55, 0.325, 0.35, 0.25, 0.2, 0.15, 0.1, 0.075];
	var frqs= [0.56, 0.56, 0.92, 0.92, 1.19, 1.7, 2, 2.74, 3, 3.76, 4.07];
	var dets= [0, 1, 0, 1.7, 0, 0, 0, 0, 0, 0, 0];    // Detune
	var src= Mix.fill(11, {|i|
		var env= EnvGen.ar(Env.perc(0.005, dur*durs[i], amps[i], -4.5),t_trig);
		SinOsc.ar(freq*frqs[i]+dets[i], 0, amp*env);
	});
	Out.ar(out, Pan2.ar(src, pan));
}).add;
)

a= Synth(\risset, [\freq, 72.midicps, \dur, 10])
a.set(\freq, 100.midicps, \dur, 3, \t_trig,1)
a.set(\freq, 60.midicps, \dur, 2,\t_trig,1)
a.set(\freq, 90.midicps, \dur, 0.5,\t_trig,1)
a.free

(
Routine({
	a= Synth(\risset);
	20.do{
		var dur= 0.2.exprand(3.0);
		var fre= 60.0.exprand(5000.0);
		("dur:"+dur+"fre:"+fre).postln;
		a.set(\freq, fre, \dur, dur, \t_trig,1);
		dur.wait;
	};
	a.free;
	"done".postln;
}).play;
)