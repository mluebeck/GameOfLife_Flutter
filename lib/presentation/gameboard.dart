import 'package:flutter/material.dart';
import 'dart:async';
import 'package:game_of_life/domain/playground.dart';
import 'package:game_of_life/domain/button_event.dart';

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
  Playground playground = Playground();
  List<List<bool>> _grid = [[false]];
  final int _rows = 20;
  final int _columns = 20;


  @override
  void initState() {
    super.initState();
    _initializeGrid();
    widget.stream.listen((event) {
      print("Listen to event:: ${event}");
      playground.from(_grid);
      playground.calculateNextRound();
      setState(() {
        _grid = playground.toList(_rows, _columns);
      });
    });
  }

  void _initializeGrid() {
    _grid = List.generate(_rows, (_) => List.filled(_columns, false));
    glider();
  }

  void glider() {
    int x = 0;
    int y = 0;
    _grid[x+1][y]=true;
    _grid[x+2][y+1]=true;
    _grid[x+2][y+2]=true;
    _grid[x+1][y+2]=true;
    _grid[x][y+2]=true;
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
              playground.setNewCellAt(row, col, _grid[row][col]);
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