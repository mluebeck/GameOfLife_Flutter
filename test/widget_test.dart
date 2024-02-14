// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:game_of_life/domain/playground.dart';

Playground getTestPlaygroundWithCellAt(int x, int y,bool value) {
  Playground playground = Playground();
  playground.setNewCellAt(x, y, value);
  return playground;
}

void main() {
  // rule 1
  // GIVEN: an empty playground
  // WHEN: a dead cell has 3 neighbors
  // THEN: the dead cell becomes a living cell

  group("Test playground group", () {
    test("Add three active cells and test if there are really three.", () {
      // Given
      Playground playground = Playground();
      playground.setCellAt(0, 0, true);
      playground.setCellAt(1, 0, true);
      playground.setCellAt(2, 0, true);
      expect(playground.cellSet.length, 3);
    });

    test("Add six active cells and test if there are really six.", () {
      Playground playground = Playground();
      playground.setCellAt(0, 0, true);
      playground.setCellAt(1, 0, true);
      playground.setCellAt(2, 0, true);
      playground.setCellAt(0, 1, true);
      playground.setCellAt(1, 1, true);
      playground.setCellAt(2, 1, true);
      expect(playground.cellSet.length, 6);
    });

    test("number of active cells keeps constant if we add active cells multiple times.", () {
      Playground playground = Playground();
      playground.setCellAt(0, 1, true);
      playground.setCellAt(1, 1, true);
      playground.setCellAt(2, 1, true);
      playground.setCellAt(0, 0, true);
      playground.setCellAt(1, 0, true);
      playground.setCellAt(2, 0, true);
      playground.setCellAt(0, 1, true);
      playground.setCellAt(1, 1, true);
      playground.setCellAt(2, 1, true);
      expect(playground.cellSet.length, 6);
    });
  });
  group("Test Rule 1 group", () {
    test("Rule 1", () {
      // Given a playground with a dead cell
      Playground playground = getTestPlaygroundWithCellAt(1, 1, false);
      // When a cell has three neighbors....
      playground.setCellAt(0, 0, true);
      playground.setCellAt(1, 0, true);
      playground.setCellAt(2, 0, true);
      playground.calculateNextStepAndWriteItToNewCellSet(1, 1, false);
      // THEN the cell shall be born
      expect(playground.newCellAt(1, 1), true);
    });
  });

  group("Test Rule 2", () {
    // 2. A living cell dies in the next generation  if it has less than 2 neighbors
    test("Rule 2", () {
      // Given a playground with a living cell
      Playground playground = getTestPlaygroundWithCellAt(1, 1, true);
      // WHEN a cell has only one neighbor
      playground.setCellAt(0, 0, true);
      playground.calculateNextStepAndWriteItToNewCellSet(1, 1, true);
      // THEN the cell becomes dead

      expect(playground.cellAt(1, 1), false);
    });
  });

  group("Test Rule 3", () {
    // 3. A living cell keeps alive in the next generation if it has 2 or 3 neighbors
    test("Rule 3.1", () {
      // Given a playground with a living cell at 1,1
      Playground playground = getTestPlaygroundWithCellAt(1, 1, true);
      // WHEN a cell has two neighbors
      playground.setCellAt(0, 0, true);
      playground.setCellAt(2, 0, true);
      playground.calculateNextStepAndWriteItToNewCellSet(1, 1, true);
      // THEN the cell keeps alive
      expect(playground.newCellAt(1, 1), true);
    });

    test("Rule 3.2", () {
      // Given: a living cell at 1,1
      Playground playground = getTestPlaygroundWithCellAt(1, 1, true);
      // WHEN a cell has three neighbors
      playground.setCellAt(0, 0, true);
      playground.setCellAt(2, 0, true);
      playground.setCellAt(2, 2, true);
      playground.calculateNextStepAndWriteItToNewCellSet(1, 1, true);
      // THEN the cell keeps alive
      expect(playground.newCellAt(1, 1), true);
    });
  });

  group("Test Rule 4", ()
  {
    // 4. A living cell dies in the next generation if it has more than 3 neighbors
    test("Rule 4.1", () {
      // Given: a living cell at 1,1
      Playground playground = getTestPlaygroundWithCellAt(1, 1, true);
      // WHEN a cell has four neighbors
      playground.setCellAt(0, 1, true);
      playground.setCellAt(0, 0, true);
      playground.setCellAt(2, 0, true);
      playground.setCellAt(2, 2, true);
      playground.calculateNextStepAndWriteItToNewCellSet(1, 1, true);
      // THEN the cell dies
      expect(playground.newCellAt(1, 1), false);
    });
    // 4. A living cell dies in the next generation if it has more than 3 neighbors
    test("Rule 4.2", () {
      // Given: a living cell at 1,1
      Playground playground = getTestPlaygroundWithCellAt(1, 1, true);
      // WHEN a cell has six neighbors
      playground.setCellAt(0, 1, true);
      playground.setCellAt(0, 0, true);
      playground.setCellAt(2, 0, true);
      playground.setCellAt(1, 0, true);
      playground.setCellAt(2, 2, true);
      playground.setCellAt(1, 2, true);
      playground.calculateNextStepAndWriteItToNewCellSet(1, 1, true);
      // THEN the cell dies
      expect(playground.newCellAt(1, 1), false);
    });
  });

  group("Test playground glider", () {
    test("glider", () {
      int x = 0;
      int y = 0;
      Playground playground = Playground(); //getTestPlaygroundWithCellAt(x+1, y, true);
      playground.setCellAt(x+1, y, true);
      playground.setCellAt(x+2, y+1, true);
      playground.setCellAt(x+2, y+2, true);
      playground.setCellAt(x+1, y+2, true);
      playground.setCellAt(x, y+2, true);
      playground.calculateNextRound();

      bool line1 =
          playground.cellAt(x, y) == false &&
          playground.cellAt(x, y+1) == true &&
          playground.cellAt(x, y+2) == false &&
          playground.cellAt(x, y+3) == false;

      bool line2 =
          playground.cellAt(x+1, y) == false &&
          playground.cellAt(x+1, y+1) == false &&
          playground.cellAt(x+1, y+2) == true &&
          playground.cellAt(x+1, y+3) == true &&
          playground.cellAt(x+1, y+4) == false;

      bool line3 =
          playground.cellAt(x+2, y) == false &&
          playground.cellAt(x+2, y+1) == true &&
          playground.cellAt(x+2, y+2) == true &&
          playground.cellAt(x+2, y+3) == false &&
          playground.cellAt(x+2, y+4) == false;

      bool line4 =
          playground.cellAt(x+3, y) == false &&
          playground.cellAt(x+3, y+1) == false &&
          playground.cellAt(x+3, y+2) == false &&
          playground.cellAt(x+3, y+3) == false &&
          playground.cellAt(x+3, y+4) == false;

      expect(line1 && line2 && line3 && line4, true);
    });
  });
}
