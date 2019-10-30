/* Markov Chain Experiment II
   Jacob Joaquin

   Get a visual representation of the Markov Chain here:
   http://codehop.com/supercollider-markov-chain/
*/

(
// Synthesizer
SynthDef(\my_synth, {|dur = 1.0, amp = 1.0, freq = 440|
	var env = EnvGen.ar(Env.new([1, 0.1, 0], [0.06, dur - 0.06]), doneAction: 2);
	Out.ar([0, 1], SinOsc.ar([freq * 0.995, freq * 1.005], 0, env * amp))
}).add;

{SinOsc.ar()}.play

// Create task
t = Task({
	// Set attributes of each node
	// [freq, dur, [[next_state, weighted_random],…]]
	var node_list = [
		[60, 1, [[1, 2]]],
		[62, 0.5, [[0, 1], [2, 1]]],
		[63, 1, [[0, 1], [3, 1]]],
		[65, 0.5, [[0, 1], [3, 4], [4, 1]]],
		[67, 1, [[5, 1]]],
		[70, 1.5, [[4, 1], [6, 2]]],
		[69, 1, [[4, 1], [7, 2]]],
		[72, 0.5, [[4, 1], [7, 4], [0, 2]]]
	];

	var node_index = 0;
	var bps = 133.0 / 60.0;  // Beats per second

	inf.do({
		var weight = 0;
		var random;
		var accumulator;
		var node = node_list[node_index];
		var freq = node[0].midicps;
		var dur = node[1] / bps;
		var paths = node[2];

		// Get total statistical weight of connected nodes
		(0 .. paths.size - 1).do {|i| weight = weight + paths[i][1]};

		// Generate random value for choosing next node
		random = weight.rand;

		// Choose next node based on statistical weights
		accumulator = paths[0][1];

		node_index = block {|break|
			paths.size.do {|i|
				if ((random < accumulator), {
					break.value(paths[i][0])
				}, {
					accumulator = accumulator + paths[i + 1][1]
				})
			}
		};

		// Play
		Synth(\my_synth, [\dur, dur, \amp, -3.dbamp, \freq, freq]);
		dur.wait;
	})
});

t.start;
)