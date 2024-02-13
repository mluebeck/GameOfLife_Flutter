import 'package:flutter/material.dart';
import 'dart:async';

enum ButtonEvent {
    start, stop, pause, nextstep , refresh
}



void drucken() {
  print("Drucken");
}

void main() {
  runApp( GameOfLife(pressed: drucken,streamController: StreamController<ButtonEvent>()));
}


class GameOfLife extends StatelessWidget {

  final StreamController<ButtonEvent>? streamController;
  StreamSink<ButtonEvent> get eventSink => streamController!.sink;
  Stream<ButtonEvent> get eventStream => streamController!.stream;

  final VoidCallback? pressed;

  const GameOfLife({super.key, this.pressed ,this.streamController});

  @override
  Widget build(BuildContext context) {
    print("build");

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Game of Life'),
        ),
        body: Column(
          children: [
             Expanded(
              child: Center(
                child:

                GameBoard(
                  //onPressedStart: pressed,
                  streamController: streamController
                  ),




                ),
              ),
              Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      ButtonEvent event = ButtonEvent.start;
                      streamController!.sink.add(event);
                    },
                    child: const Text('Start'),
                  ),
                  TextButton(
                    onPressed: () {
                      ButtonEvent event = ButtonEvent.pause;
                      streamController!.sink.add(event);
                    },
                    child: const Text('Pause'),
                  ),
                  TextButton(
                    onPressed: () {
                      ButtonEvent event = ButtonEvent.refresh;
                      streamController!.sink.add(event);
                    },
                    child: const Text('Refresh'),
                  ),
                ],
              ),     
            ),
          ],
        ),
      ),
    );
  }
}

class GameBoard extends StatefulWidget {
  //final VoidCallback? onPressedStart;

  final StreamController<ButtonEvent>?  streamController;
  StreamSink<ButtonEvent> get sink => streamController!.sink;
  Stream<ButtonEvent> get stream => streamController!.stream;

  //const GameBoard({super.key, required this.onPressedStart,this.streamController});
  const GameBoard({super.key, this.streamController});

  @override
  GameBoardState createState() =>  GameBoardState();
}

class GameBoardState extends State<GameBoard> {
  List<List<bool>> _grid = [[false]];
  final int _rows = 20;
  final int _columns = 20;
  

  @override
  void initState() {
    super.initState();
    _initializeGrid();
    widget.stream.listen((event) {
      print("Listen to event:: ${event}");
      _grid[0][0] = false;
    });
  }

  void _initializeGrid() {
    _grid = List.generate(_rows, (_) => List.filled(_columns, false));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _rows * _columns,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _columns,
      ),
      itemBuilder: (context, index) {
        int row = index ~/ _columns;
        int col = index % _columns;
        return GestureDetector(
          onTap: () {
            setState(() {
              _grid[row][col] = !_grid[row][col];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: _grid[row][col] ? Colors.black : Colors.white,
              border: Border.all(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}