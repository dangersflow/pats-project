import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:pats_project/components/tile.dart';

class PATSSimulation {
  final int x;
  final int y;
  final List<Tile> mainGrid;
  final List<Tile> leftGlueColumn;
  final List<Tile> bottomGlueRow;
  final List<Tile> resultingGrid;
  PATSSimulation({
    required this.x,
    required this.y,
    required this.mainGrid,
    required this.leftGlueColumn,
    required this.bottomGlueRow,
    required this.resultingGrid,
  });

  PATSSimulation copyWith({
    int? x,
    int? y,
    List<Tile>? mainGrid,
    List<Tile>? leftGlueColumn,
    List<Tile>? bottomGlueRow,
    List<Tile>? resultingGrid,
  }) {
    return PATSSimulation(
      x: x ?? this.x,
      y: y ?? this.y,
      mainGrid: mainGrid ?? this.mainGrid,
      leftGlueColumn: leftGlueColumn ?? this.leftGlueColumn,
      bottomGlueRow: bottomGlueRow ?? this.bottomGlueRow,
      resultingGrid: resultingGrid ?? this.resultingGrid,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory PATSSimulation.fromJson(String source) =>
      PATSSimulation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PATSSimulation(x: $x, y: $y, mainGrid: $mainGrid, leftGlueColumn: $leftGlueColumn, bottomGlueRow: $bottomGlueRow, resultingGrid: $resultingGrid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is PATSSimulation &&
        other.x == x &&
        other.y == y &&
        listEquals(other.mainGrid, mainGrid) &&
        listEquals(other.leftGlueColumn, leftGlueColumn) &&
        listEquals(other.bottomGlueRow, bottomGlueRow) &&
        listEquals(other.resultingGrid, resultingGrid);
  }

  @override
  int get hashCode {
    return x.hashCode ^
        y.hashCode ^
        mainGrid.hashCode ^
        leftGlueColumn.hashCode ^
        bottomGlueRow.hashCode ^
        resultingGrid.hashCode;
  }

  // Map<Tile> simulate(){

  // }
}
