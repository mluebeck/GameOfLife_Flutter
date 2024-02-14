import 'cell.dart';

class Playground {
  Set<Cell> cellSet = <Cell>{};
  Set<Cell> newCellSet = <Cell>{};

  void cellCopy() {
    cellSet.clear();
    for (Cell c in newCellSet) {
      cellSet.add(c);
    }
  }

  void from(List<List<bool>> list) {
    int all_x = list.length;
    int all_y = list[0].length;
    for (int x=0;x<all_x;x++) {
      for (int y=0;y<all_y;y++) {
        if (list[x][y]==false) {
          cellSet.remove(Cell(x, y));
        }
        else {
          cellSet.add(Cell(x,y));
        }
      }
    }
  }

  List<List<bool>> toList(int columns, int rows) {
    List<List<bool>> aList = List.generate(rows, (_) => List.filled(columns, false));
    for (int x=0;x<rows;x++) {
      for (int y=0;y<columns;y++) {
        aList[x][y] = cellAt(x, y);
      }
    }
    return aList;
  }

  bool cellAt(int x,int y) {
    if (cellSet.contains(Cell(x,y))) {
      return true;
    } else {
      return false;
    }
  }

  bool newCellAt(int x,int y) {
    if (newCellSet.contains(Cell(x,y))) {
      return true;
    } else {
      return false;
    }
  }

  void setNewCellAt(int x,int y, bool value) {
    if (value == false) {
      newCellSet.remove(Cell(x, y));
    }
    else {
      newCellSet.add(Cell(x, y));
    }
    return;
  }

  void setCellAt(int x,int y, bool value) {
    if (value==false) {
      cellSet.remove(Cell(x, y));
    }
    else { 
      cellSet.add(Cell(x,y));
    }
    return;
  }

  Set<Cell> copyCells(Set<Cell> oldCell) {
    Set<Cell> aNewCell = <Cell>{};
    for (Cell cell in oldCell) {
      aNewCell.add(Cell(cell.x,cell.y));
    }
    return aNewCell;
  }

  Set<Cell> getEmptyNeighbors(Cell cell) {
    Set<Cell> emptyCells = <Cell>{};

    // links oben
    Cell cellLeftTop = Cell(cell.x-1, cell.y-1);
    if (cellSet.contains(cellLeftTop)==false && cell.x-1>=0 && cell.y-1>=0) {
        emptyCells.add(cellLeftTop);
    }
    Cell cellLeftMiddle = Cell(cell.x-1, cell.y);
    if (cellSet.contains(cellLeftMiddle)==false && cell.x-1>=0 && cell.y>=0) {
      emptyCells.add(cellLeftMiddle);
    }
    Cell cellLeftBottom = Cell(cell.x-1, cell.y+1);
    if (cellSet.contains(cellLeftBottom)==false && cell.x-1>=0 && cell.y>=0) {
      emptyCells.add(cellLeftBottom);
    }
    Cell cellRightTop = Cell(cell.x+1, cell.y-1);
    if (cellSet.contains(cellRightTop)==false && cell.y-1>=0) {
      emptyCells.add(cellRightTop);
    }
    Cell cellRightMiddle = Cell(cell.x+1, cell.y);
    if (cellSet.contains(cellRightMiddle)==false  && cell.y>=0) {
      emptyCells.add(cellRightMiddle);
    }
    Cell cellRightBottom = Cell(cell.x+1, cell.y+1);
    if (cellSet.contains(cellRightBottom)==false) {
      emptyCells.add(cellRightBottom);
    }
    Cell cellTop = Cell(cell.x,cell.y+1);
    if (cellSet.contains(cellTop)==false  && cell.y>=0) {
      emptyCells.add(cellTop);
    }
    Cell cellBottom = Cell(cell.x,cell.y);
    if (cellSet.contains(cellBottom)==false && cell.y>=0) {
      emptyCells.add(cellBottom);
    }
    for (Cell c in emptyCells) {
      print("Adding empty cell ${c.x} ${c.y}");
    }
    print(emptyCells);
    return emptyCells;
  }
  // calculate next round by iterating over all cell elements
  void calculateNextRound() {
    newCellSet.clear();
    Set<Cell> emptyCells = <Cell>{};

    for (Cell cell in cellSet) {
      calculateNextStepAndWriteItToNewCellSet(cell.x, cell.y,true);
      emptyCells.addAll(getEmptyNeighbors(cell));
    }
    for (Cell c in emptyCells) {
      calculateNextStepAndWriteItToNewCellSet(c.x, c.y,false);
    }
    cellSet = copyCells(newCellSet);
    newCellSet.clear();
  }

  void calculateNextStepAndWriteItToNewCellSet(int x, int y, bool isAlive) {
    int count = neighborsCount(x,y);
    if (isAlive) {
      if (count < 2) {
        setNewCellAt(x, y, false);
      } else if (count == 2 || count == 3) {
        setNewCellAt(x, y, true);
      } else if (count > 3) {
        setNewCellAt(x, y, false);
      }
    } else {
      if (count == 3) {
        setNewCellAt(x, y, true);
      }
    }
  }

  int neighborsCount(int x, int y) {
    int counter = 0;
    if (cellAt(x-1, y-1)==true) {
      counter++;
    }
    if (cellAt(x, y-1)==true) {
      counter++;
    }
    if (cellAt(x+1, y-1)==true) {
      counter++;
    }
    if (cellAt(x-1, y)==true) {
      counter++;
    }
    if (cellAt(x+1, y)==true) {
      counter++;
    }
    if (cellAt(x-1, y+1)==true) {
      counter++;
    }
    if (cellAt(x, y+1)==true) {
      counter++;
    }
    if (cellAt(x+1, y+1)==true) {
      counter++;
    }
    return counter;
  }
}
