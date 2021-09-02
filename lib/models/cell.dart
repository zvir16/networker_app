import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Cell {
  var radio;
  var mcc;
  var mnc;
  var tac;
  var ci;
  var pci;
  var address;
  var dbm;
  var asu;
  var level;
  Position _position;

  Cell(
    this.mcc,
    this.mnc,
    this.radio,
    this.tac,
    this.ci,
    this.pci,
    this.dbm,
    this.asu,
    this.level,
    this._position,
  );

  bool get statePosition {
    return this._position == null ? false : true;
  }

  Position get position {
    return this._position;
  }
}

class CellsData extends ChangeNotifier {
  List<Cell> _cells = [];

  UnmodifiableListView<Cell> get cells {
    return UnmodifiableListView(this._cells);
  }

  void addCell(mcc, mnc, radio, tac, ci, pci, dbm, asu, level, position) {
    var cell = Cell(mcc, mnc, radio, tac, ci, pci, dbm, asu, level, position);
    this._cells.add(cell);
    notifyListeners();
  }
}
