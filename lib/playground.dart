import 'cell.dart';

class Playground {
  Set<Cell> cellSet = <Cell>{};

  bool cellAt(int x,int y) {
    if (cellSet.contains(Cell(x,y))) {
      return true;
    } else {
      return false;
    }
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

  void calculateNextStep(int x, int y) {
    //WHEN #neighbors < 2
    int count = neighborsCount(x,y);

    if (count < 2) {
      // THEN die.
      setCellAt(x,y,false);
      return;
    }
    //WHEN
    if (count == 3) {
      // THEN
      setCellAt(x,y,true);
      return;
    }

    //WHEN #neighbors < 2
    if (count == 2) {
      setCellAt(x,y,true);
      return;
    }

    //WHEN #neighbors < 2
    if (count == 3) {
      setCellAt(x,y,true);
      return;
    }

    //WHEN #neighbors > 2
    if (count > 3) {
      setCellAt(x,y,false);
      return;
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
