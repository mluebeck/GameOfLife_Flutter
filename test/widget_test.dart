// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:game_of_live/domain/playground.dart';

Playground getTestPlaygroundWithCellAt(int x, int y,bool value) {
  Playground playground = Playground();
  playground.setCellAt(x, y, value);
  return playground;
}

void main() {
  // rule 1
  // GIVEN: an empty playground
  // WHEN: a dead cell has 3 neighbors
  // THEN: the dead cell becomes a living cell
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

  test("Rule 1", () {
    // Given a playground with a living cell
    Playground playground = getTestPlaygroundWithCellAt(1, 1, false);
    // When a cell has three neighbors....
    playground.setCellAt(0, 0, true);
    playground.setCellAt(1, 0, true);
    playground.setCellAt(2, 0, true);

    playground.calculateNextStep(1, 1);
    // THEN the cell shall keep alive 
    expect(playground.cellAt(1,1), true);
  });

  // 2. A living cell dies in the next generation  if it has less than 2 neighbors
  test("Rule 2", () {
    // Given a playground with a living cell
    Playground playground = getTestPlaygroundWithCellAt(1, 1, true);
    // WHEN a cell has only one neighbor
    playground.setCellAt(0,0, true);
    playground.calculateNextStep(1,1);
    // THEN the cell becomes dead 
    expect(playground.cellAt(1,1), false);
  });

  // 3. A living cell keeps alive in the next generation if it has 2 or 3 neighbors
  test("Rule 3.1", () {
    // Given a playground with a living cell at 1,1 
    Playground playground = getTestPlaygroundWithCellAt(1, 1, true);
    // WHEN a cell has two neighbors
    playground.setCellAt(0, 0, true);
    playground.setCellAt(2, 0, true);
    playground.calculateNextStep(1, 1);
    // THEN the cell keeps alive 
    expect(playground.cellAt(1,1), true);
  });

  test("Rule 3.2", () {
    // Given: a living cell at 1,1
    Playground playground = getTestPlaygroundWithCellAt(1, 1, true);
    // WHEN a cell has three neighbors
    playground.setCellAt(0, 0, true);
    playground.setCellAt(2, 0, true);
    playground.setCellAt(2, 2, true);
    playground.calculateNextStep(1, 1);
    // THEN the cell keeps alive 
    expect(playground.cellAt(1,1), true);
  });

  // 4. A living cell dies in the next generation if it has more than 3 neighbors
  test("Rule 4.1", () {
    // Given: a living cell at 1,1
    Playground playground = getTestPlaygroundWithCellAt(1, 1, true);
    // WHEN a cell has four neighbors
    playground.setCellAt(0, 1, true);
    playground.setCellAt(0, 0, true);
    playground.setCellAt(2, 0, true);
    playground.setCellAt(2, 2, true);
    playground.calculateNextStep(1, 1);
    // THEN the cell dies 
    expect(playground.cellAt(1,1), false);
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
    playground.calculateNextStep(1, 1);
    // THEN the cell dies 
    expect(playground.cellAt(1,1), false);
  });

  }
