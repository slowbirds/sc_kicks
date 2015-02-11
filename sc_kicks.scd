(
//add server
s = Server.local;
s.boot;
s.makeWindow;

// Sine
SynthDef('kick0',{
  arg freq;
  var subosc1, subenv1, suboutput1, subosc2, subenv2, suboutput2;

  subosc1 = {SinOsc.ar(50)};
  subenv1 = {Line.ar(1, 0, 1, doneAction: 2)};

  subosc2 = {SinOsc.ar(38)};
  subenv2 = {Line.ar(0.2, 0.1, 0.8, doneAction: 2)};

  suboutput1 = (subosc1 * subenv1);
  suboutput2 = (subosc2 * subenv2);

  Out.ar(0,
      Pan2.ar(suboutput1, 0)
  );
}).load(s);

// Sine + attack by whotenoise
SynthDef('kick1',{
  arg freq;
  var subosc, subenv, suboutput, clickosc, clickenv, clickoutput;

  subosc = {SinOsc.ar(50)};
  subenv = {Line.ar(1, 1, 1, doneAction: 2)};

  clickosc = {LPF.ar(WhiteNoise.ar(1),20)};
  clickenv = {Line.ar(1, 0, 0.05)};

  suboutput = (subosc * subenv);
  clickoutput = (clickosc * clickenv);

  Out.ar(0,
      Pan2.ar(suboutput + clickoutput, 0)
  );
}).load(s);

// Sine + attack by Saw
SynthDef('kick2',{
  arg freq;
  var subosc, subenv, suboutput, clickosc, clickenv, clickoutput;

  subosc = {HPF.ar({LPF.ar(SinOsc.ar(50),100)},80)};
  subenv = {Line.ar(1, 0, 0.8, doneAction: 2)};


  clickosc = {LPF.ar(Saw.ar(120),200)};
  clickenv = {Line.ar(1, 0, 0.02)};

  suboutput = (subosc * subenv);
  clickoutput = (clickosc * clickenv);

  Out.ar(0,
      Pan2.ar(suboutput*1.5 + clickoutput/2, 0)
  );
}).load(s);


// Sine + attack by whotenoise
SynthDef('kick3',{
  arg freq;
  var subosc, subenv, suboutput, clickosc, clickenv, clickoutput;

  subosc = {HPF.ar({LPF.ar(WhiteNoise.ar(1),100)},80)};
  subenv = {Line.ar(1, 0, 0.2, doneAction: 2)};

  clickosc = {HPF.ar({LPF.ar(WhiteNoise.ar(1),180)},160)};
  clickenv = {Line.ar(1, 0, 0.05)};

  suboutput = (subosc * subenv);
  clickoutput = (clickosc * clickenv);

  Out.ar(0,
      Pan2.ar(suboutput + clickoutput, 0)
  );
}).load(s);


// Sine + attack by whotenoise
SynthDef('bass',{|freq=80, amp=1|
  var subosc, subenv, suboutput, clickosc, clickenv, clickoutput, env;

  subosc = {LPF.ar(SinOsc.ar(freq),freq*2)};
  env = Env.new([0, 0.8, 0.9, 0.2], [0.1, 0.5, 1],[-5, 0, -5]);
  subenv = EnvGen.kr(env, doneAction: 2);


  suboutput = (subosc);

  Out.ar(0,
      Pan2.ar(suboutput, 0)
  );
}).load(s);


//Synth('kick0');
//Synth('kick1');
//Synth('kick2');
//Synth('kick3');
//b = Synth('bass');
//b.set(\freq,80);

(
Routine({
  loop{
    var length = [0.2,0.4,0.8,1.6,3.2].choose;
    var base_freq = 110;
    var freq_pipe = [0.5,0.8,1.0,1.2,1.5].choose;
    var freq = (base_freq * freq_pipe);
    b = Synth('bass');
    b.set(\freq,freq/2);
    length.yield;
    b.free;
  }
}).play;
);
(
Routine({
  loop{
    var length = [0.1,0.2,0.4,0.8].choose;
    Synth('kick3');
    Synth('kick1');
    length.yield;
  }
}).play;
);

)
