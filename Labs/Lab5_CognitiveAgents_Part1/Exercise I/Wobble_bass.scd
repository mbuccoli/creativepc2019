NetAddr.langPort

//Load Server
s.boot

ServerOptions.outDevices;

//s.options.outDevice_('Altoparlanti MacBook Pro');




// ------ Wobble bass complete -----
(
SynthDef(\dubstep, { arg note = 50, gate = 1,dur=2, detune = 0.01, lfo = 0, amp = 0;
	var trig, son, sweep, out, freq;

	// convert midi to frequency
	freq = note.midicps;

	// load trigger
	trig = CoinGate.kr(0.5, Impulse.kr(2));

	// sweep regulated by lfo
	sweep = Poll.kr(trig,LFSaw.ar(lfo).exprange(40, 5000));   /// Inf: number of different values to produce


	// wobble bass
	son = Mix.ar(LFSaw.ar(freq * [1-detune, 1, 1+detune]));
    son = LPF.ar(son, sweep);
    out = son + BPF.ar(son, 2000, 2);

	// envelope
	a = EnvGen.ar(Env.asr(0.01,1,dur),gate:gate,doneAction:2);

	// Output
	Out.ar(0, amp*Pan2.ar(FreeVerb.ar(out*a,room:0.3),0));
}).add;
)


// declare instance of the synth
h = Synth(\dubstep);

// class A params
h.set(\note,20);
h.set(\amp,0.5);

// class B params
h.set(\detune,0.001);
h.set(\lfo,0);

// start communication with hand_detector client

(
x = OSCFunc( { | msg, time, addr, port |
    var pyFreq,pyAmp,pyDetune,pyLfo;
	// Stop and free synthesizer

	if (msg[1] =='stop'){
		//...
	}
	{
		// handle class A message (freq and amplitude)
		if (msg[1]=='a'){
			// Parse message
			//...
			//...

			// set parameters
			 //...
			//...
		};
		// handle class B message (detune and lfo)
		if (msg[1]=='b'){
			/
			// Parse message
			//...
			//...

			// set parameters
			 //...
			//...
		};

	};
}, '/synth_control' );
)


// free synth
h.free

// close server
s.quit

