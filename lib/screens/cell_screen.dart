import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:networker_app/models/cell.dart';
import 'package:provider/provider.dart';

class BSTab extends StatefulWidget {
  @override
  _BSTabState createState() => _BSTabState();
}

class _BSTabState extends State<BSTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CellsData>(builder: (context, cellsData, child) {
      return ListView.builder(
        itemCount: cellsData.cells.length,
        itemBuilder: (context, index) {
          var cell = cellsData.cells[index];
          Position position = cell.statePosition
              ? cell.position
              : Position(
                  longitude: 0.0,
                  latitude: 0.0,
                  timestamp: DateTime.now(),
                  accuracy: 0,
                  altitude: 0.0,
                  heading: 0.0,
                  speed: 0.0,
                  speedAccuracy: 0.0,
                );
          return Card(
            child: ListTile(
              leading: LevelSignal(level: cell.level),
              title: Text('MCC: ${cell.mcc} MNC: ${cell.mnc} TAC: ${cell.tac} '
                  '\nCI: ${cell.ci} PCI: ${cell.pci} Power: ${cell.dbm}dBm \nASU: ${cell.asu}dBm '),
              subtitle: Text(
                  'Longitude: ${position.longitude} Latitude: ${position.latitude}'),
              trailing: cell.statePosition
                  ? Icon(
                      Icons.gps_fixed_outlined,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.gps_fixed_outlined,
                      color: Colors.red,
                    ),
            ),
          );
        },
      );
    });
  }
}

class LevelSignal extends StatelessWidget {
  LevelSignal({this.level});
  final dynamic level;

  @override
  Widget build(BuildContext context) {
    if (level == '1') {
      return Icon(
        Icons.signal_cellular_alt_sharp,
        color: Colors.red,
      );
    }
    if (level == '2') {
      return Icon(
        Icons.signal_cellular_alt_sharp,
        color: Colors.yellowAccent,
      );
    }
    if (level == '3') {
      return Icon(Icons.signal_cellular_alt_sharp, color: Colors.orange);
    }
    if (level == '4') {
      return Icon(
        Icons.signal_cellular_alt_sharp,
        color: Colors.green,
      );
    } else
      return Icon(Icons.no_cell);
  }
}
