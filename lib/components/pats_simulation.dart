import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:pats_project/components/tile.dart';

class PATSSimulation {
  final int x;
  final int y;
  final List<Tile> mainGrid;
  final List<Tile> leftGlueColumn;
  final List<Tile> bottomGlueRow;
  final List<Tile> resultingGrid;
  final List<Tile> tilePool;
  PATSSimulation({
    required this.x,
    required this.y,
    required this.mainGrid,
    required this.leftGlueColumn,
    required this.bottomGlueRow,
    required this.resultingGrid,
    required this.tilePool,
  });

  PATSSimulation copyWith({
    int? x,
    int? y,
    List<Tile>? mainGrid,
    List<Tile>? leftGlueColumn,
    List<Tile>? bottomGlueRow,
    List<Tile>? resultingGrid,
    List<Tile>? tilePool,
  }) {
    return PATSSimulation(
      x: x ?? this.x,
      y: y ?? this.y,
      mainGrid: mainGrid ?? this.mainGrid,
      leftGlueColumn: leftGlueColumn ?? this.leftGlueColumn,
      bottomGlueRow: bottomGlueRow ?? this.bottomGlueRow,
      resultingGrid: resultingGrid ?? this.resultingGrid,
      tilePool: tilePool ?? this.tilePool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'x': x,
      'y': y,
      'mainGrid': mainGrid.map((x) => x.toMap()).toList(),
      'leftGlueColumn': leftGlueColumn.map((x) => x.toMap()).toList(),
      'bottomGlueRow': bottomGlueRow.map((x) => x.toMap()).toList(),
      'resultingGrid': resultingGrid.map((x) => x.toMap()).toList(),
      'tilePool': tilePool.map((x) => x.toMap()).toList(),
    };
  }

  factory PATSSimulation.fromMap(Map<String, dynamic> map) {
    return PATSSimulation(
      x: map['x']?.toInt() ?? 0,
      y: map['y']?.toInt() ?? 0,
      mainGrid: List<Tile>.from(map['mainGrid']?.map((x) => Tile.fromMap(x))),
      leftGlueColumn:
          List<Tile>.from(map['leftGlueColumn']?.map((x) => Tile.fromMap(x))),
      bottomGlueRow:
          List<Tile>.from(map['bottomGlueRow']?.map((x) => Tile.fromMap(x))),
      resultingGrid:
          List<Tile>.from(map['resultingGrid']?.map((x) => Tile.fromMap(x))),
      tilePool: List<Tile>.from(map['tilePool']?.map((x) => Tile.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PATSSimulation.fromJson(String source) =>
      PATSSimulation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PATSSimulation(x: $x, y: $y, mainGrid: $mainGrid, leftGlueColumn: $leftGlueColumn, bottomGlueRow: $bottomGlueRow, resultingGrid: $resultingGrid, tilePool: $tilePool)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PATSSimulation &&
        other.x == x &&
        other.y == y &&
        listEquals(other.mainGrid, mainGrid) &&
        listEquals(other.leftGlueColumn, leftGlueColumn) &&
        listEquals(other.bottomGlueRow, bottomGlueRow) &&
        listEquals(other.resultingGrid, resultingGrid) &&
        listEquals(other.tilePool, tilePool);
  }

  @override
  int get hashCode {
    return x.hashCode ^
        y.hashCode ^
        mainGrid.hashCode ^
        leftGlueColumn.hashCode ^
        bottomGlueRow.hashCode ^
        resultingGrid.hashCode ^
        tilePool.hashCode;
  }

  void simulate() {
    //perform simulation
    int z_index = 0;
    int currentGridIndex = x * y;
    int currentGlueColumnPointer = 0;
    int currentGlueRowPointer = 0;

    for (int current_y = 0; current_y < y; current_y++) {
      for (int current_x = 0; current_x < x; current_x++) {
        //go through the row
        int currentIndex = current_x * x + current_y;
        bool indexFilled = false;

        while (!indexFilled) {
          //grab a random tile from the tile pool
          List<Tile> sample = tilePool.sample(1);
          Tile grabbedTile = sample[0];

          //check if grabbed tile is able to be placed in current position

          //get tile left of current pos
          Tile leftTile;
          if (current_x - 1 == -1) {
            leftTile = leftGlueColumn[currentGlueColumnPointer];
          } else {
            leftTile = resultingGrid[currentIndex - 1];
          }
          //get bottom tile
          Tile bottomTile;
          if (current_y - 1 == -1) {
            bottomTile = bottomGlueRow[currentGlueRowPointer];
          } else {
            bottomTile = resultingGrid[currentIndex - x];
          }

          //compare if the tile glues match the current grabbed tile

        }
      }
      z_index++;
    }
  }
}
