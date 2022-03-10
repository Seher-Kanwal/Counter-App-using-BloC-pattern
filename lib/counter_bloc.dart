import 'dart:async';


enum Counteraction{
  increment,
  decrement,
  reset,
}

class Counterbloc{
  late int counter;


  Counterbloc(){
    counter=0;
    //we are actually hearing whether there occurs any event or not
    eventStream.listen((event) {
      if(event== Counteraction.increment)
        {
          counter++;
        }
      else if(event==Counteraction.decrement) {
        if(counter> 0)
          {
            counter--;
          }
      }
      else if(event==Counteraction.reset)
        {
          counter=0;
        }
      //as of now we have to pass counter to first counter stream so we will use sink
      counterSink.add(counter);
    });


  }

  //int is the value which the controller will return
  //make stream controller private so that other can't access it by placing ( '_' )
  final _stateStreamController= StreamController<int>();
  //for input, we use stream sink
  StreamSink <int> get counterSink => _stateStreamController.sink;
  //for output, we use stream
   Stream<int>  get counterStream => _stateStreamController.stream;

  final _eventStreamController= StreamController<Counteraction>();
  //for input, we use stream sink
  StreamSink <Counteraction> get eventSink => _eventStreamController.sink;
  //for output, we use stream
  Stream<Counteraction>  get eventStream => _eventStreamController.stream;
}