import 'package:flutter/material.dart';
import 'package:game_of_live/playground.dart';

void main() {
  runApp(const GameOfLife());
}

 
 class GameOfLife extends StatelessWidget {
  const GameOfLife({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Game of Life'),
        ),
        body: Column(
          children: [
            const Expanded(
              child: Center(
                child: GameBoard(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      // Hier die Logik für den Start-Button hinzufügen
                      print('Start button pressed');
                    },
                    child: const Text('Start'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Hier die Logik für den Pause-Button hinzufügen
                      print('Pause button pressed');
                    },
                    child: const Text('Pause'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Hier die Logik für den Refresh-Button hinzufügen
                      print('Refresh button pressed');
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
  const GameBoard({super.key});
  @override
  GameBoardState createState() => GameBoardState();
}

class GameBoardState extends State<GameBoard> {

  List<List<bool>> _grid = [[false]];
  final int _rows = 20;
  final int _columns = 20;

  @override
  void initState() {
    super.initState();
    _initializeGrid();
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
              playground.setCellAt(row, col, _grid[row][col]);
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