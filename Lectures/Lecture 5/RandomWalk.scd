

(
SynthDef(\help_sinegrain,
    { arg out=0, freq=440, sustain=0.05;
        var env;
        env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction: Done.freeSelf);
        Out.ar(out, SinOsc.ar(freq, 0, env))
    }).add;
)


// Prand - Embed one item from the list at random for each repeat
(
a = Prand(#[60, 61, 63, 65, 72], inf).asStream;
Routine({
    loop({
        Synth(\help_sinegrain, [\freq, a.next.midicps]);
        0.2.wait;
    })
}).play;
)


// Pxrand - Like Prand, returns one item from the list at random for each repeat, but Pxrand never repeats the same element twice in a row.
(
a = Pxrand(#[60, 61, 63, 65, 72], inf).asStream;
Routine({
    loop({
        Synth(\help_sinegrain, [\freq, a.next.midicps]);
        0.1.wait;
    })
}).play;
)

//Pwalk - A one-dimensional random walk over a list of values that are embedded

(
a = Pwalk(
    [60, 64, 67, 72, 76, 79, 84].midicps,    // C major
    Pseq([1], inf),
    Pseq([1, -1], inf),    // turn around at either end
    0);
x = a.asStream;

SynthDef(\help_walk, { |out, freq|
    Out.ar(out, Saw.ar([freq, freq+1], 0.5) * EnvGen.kr(Env.perc(0.01, 0.1), doneAction: Done.freeSelf))
}).add;
)

(
r = Task({
    {
        Synth.new(\help_walk, [\freq, x.next]);
        0.1.wait;
    }.loop;
}).play(SystemClock);
)

r.stop;



// Pwrand - Returns one item from the list at random for each repeat, the probability for each item is determined by a list of weights which should sum to 1.0.

(
SynthDef(\help_sinegrain,
    { arg out=0, freq=440, sustain=0.05;
        var env;
        env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction: Done.freeSelf);
        Out.ar(out, SinOsc.ar(freq, 0, env))
    }).add;
)


(
a = Pwrand([60, 61, 63, 65, 72], [10, 2, 3, 1, 3].normalizeSum, inf).asStream;
Routine({
    loop({
        Synth(\help_sinegrain, [\freq, a.next.midicps]);
        0.1.wait;
    })
}).play;
)
