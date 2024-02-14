import 'package:flutter/material.dart';
import 'dart:async';
import 'package:game_of_life/domain/button_event.dart';
import 'package:game_of_life/presentation/gameboard.dart';

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

