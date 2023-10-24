import 'package:flutter/material.dart';
import 'dart:async';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({Key? key}) : super(key: key);

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Timer? _timer;
  int _time =0;
  bool _isRunning = false;

  List<String> _lapTimes = [];

  void _clickButton(){
    _isRunning = !_isRunning;
    if (_isRunning){
      _start();
    } else{
      _pause();
    }

  }

  void _start(){
    _timer = Timer.periodic(const Duration(milliseconds : 10 ), (timer){
      setState(() {
        _time++;
      });
    });
  }
  void _pause(){
    _timer?.cancel();
  }
  void _reset(){
    _isRunning = false;
    _timer?.cancel();
    _lapTimes.clear();
    _time =0;
  }
  void _recordLapTime(String time){
    _lapTimes.insert(0, '${_lapTimes.length + 1}등 $time');
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int sec = _time ~/ 100;
    String hundredth = '${_time % 100}'.padLeft(2, '0');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: Column(
        children: [
          const SizedBox(height:30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$sec',
                style: TextStyle(fontSize: 50),
              ),
              Text(
                '$hundredth',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          SizedBox(
            width : 100,
            height: 200,
            child : ListView(
              children: _lapTimes.map((time) => Center(child: Text(time))).toList(),

            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.orange,
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
                child: Icon(Icons.refresh),),
              FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () {
                  setState(() {
                    _clickButton();
                  });
                },
                child: _isRunning ? Icon(Icons.pause) :Icon(Icons.play_arrow)),
              FloatingActionButton(

                backgroundColor: Colors.green,
                onPressed: () {
                  setState(() {
                    _recordLapTime('$sec.$hundredth');
                  });
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height:30),
        ],

      ),
    );
  }
}
