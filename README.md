#About

Moses is mouse gesture recognition library implemented in ActionScript 3.

# How it works?

Core elements of library are:

* _Samplers_ (handles mouse event and dispatch SamplerEvent with sampling data)
* _Recognizers_ (handles SamplerEvent and process recognition on each registered pattern)
* _Patterns_ (provide information about mouse gesture)
* _Algorithm_ (recognition algorithm)

_Pattern_ is a simple objects with name, data that describes pattern (it could be for example list of points) and _algorithm_ used for recognition. _Patterns_ are registered in _recognizer_. _Recognizer_ handles _sampler_ event for getting user data and examine it with each pattern's _algorithm_.

## Example

    // 1. create sampler
    var sampler:Sampler = new DistanceSampler(displayObjectToDraw);
    // 2. create recognizer
    var recognizer:Recognizer = new DefaultRecognizer();
    // 3. register some patterns
    recognizer.register(patternOne);
    recognizer.register(patternTwo);
    // 4. handle recognizer event
    recognizer.addEventListener(RecognizerEvent.RECOGNITION_PROCEEDED, recognitionProceeded)
    // 5. inject samplet to recognizer
    recognizer.sampler = sampler
    // 6. activate sampler
    sampler.activate();

next you should define handler for recognizer event:

    private function recognitionProceeded(e:RecognizerEvent):void {
        if (e.recognized) {
            trace("Pattern", e.recognitionData.bestMatching.pattern.name, "recognized");
        }
        else {
            trace("No pattern recognized");
        }	
    }

pattern could be defined as:

    var patternOne:Pattern = new FlatPointsPattern("one", [0,0,10,10,20,20], new new DefaultMosesAlgorithm(0.6, 4));

You can use your own pattern definitions and own algorithms.

# What kind of recognition algorithms are implemented in Moses library?

Moses library implements set of _Moses algorithms_. They are described [on wiki](https://github.com/ifrost/moses/wiki/Moses-algorithms)

# How can I implement my own algorithm?

You must implement Algorithm interface which provides match method. It must return Matching object which include information about how much user data is similar to pattern. You can use DistanceSampler and DefaultRecognizer or implements your own.  

# Thanks

Thanks to Didier Brun and his [Mouse Gesture Recognition](http://www.bytearray.org/?p=91). I did not use his code but his concept gave me some inspirations. Thanks!



