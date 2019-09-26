
// ------ Wobble bass -----

(
SynthDef(\dubstep, { arg note = 22,gate = 1,dur=2;
	var trig, son, sweep, out, freq;

	freq = note.midicps;

	son = Mix.ar(LFSaw.ar(freq * [0.99, 1, 1.01]));
    son = LPF.ar(son, 300);
    out = son + BPF.ar(son, 2000, 2);

	a = EnvGen.ar(Env.asr(0.01,1,dur),gate:gate,doneAction:2);

	Out.ar(0, Pan2.ar(FreeVerb.ar(out*a,room:0.3),0));
}).add;
)


x = Synth(\dubstep,[\note,22]);
x.set(\gate,0);




// ------ Wobble bass complete -----

(
SynthDef(\dubstep, { arg note = 22,gate = 1,dur=2, detune = 0.01;
	var trig, son, sweep, out, freq;

	freq = note.midicps;

	trig = CoinGate.kr(0.5, Impulse.kr(2));
	//trig = Impulse.kr(2);

	sweep = Poll.kr(trig,LFSaw.ar(Demand.kr(trig, 0, Drand([1, 2, 2, 3, 4, 5, 6, 8, 16], inf))).exprange(40, 5000));   /// Inf: number of different values to produce

	son = Mix.ar(LFSaw.ar(freq * [1-detune, 1, 1+detune]));
    son = LPF.ar(son, sweep);
    out = son + BPF.ar(son, 2000, 2);

	a = EnvGen.ar(Env.asr(0.01,1,dur),gate:gate,doneAction:2);

	Out.ar(0, Pan2.ar(FreeVerb.ar(out*a,room:0.3),0));
}).add;
)


x = Synth(\dubstep,[\note,22]);
x.set(\note,30);
x.set(\note,40);
x.set(\gate,0);

(
Routine({
	var a;
	var note = [22, 40, 60, 20, 80, 42];
	var dur = [3, 3, 3, 3, 3, 3];

	note.do{arg i;
		a = Synth(\dubstep);
		(i).postln;
		a.set(\note, i);
		5.wait;
		a.set(\gate,0,\dur,1);
		2.wait;
	};

	a.set(\gate,0);

	"done".postln;
}).play;
)