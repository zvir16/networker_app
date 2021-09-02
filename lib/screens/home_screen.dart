import 'package:flutter/material.dart';
import 'package:networker_app/const/const.dart';
import 'package:networker_app/models/cell.dart';
import 'package:networker_app/services/location.dart';
import 'package:networker_app/services/telephony.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool isGetLocation = true;
  Location location = Location();
  Telephony telephony = Telephony();

  void getPosition() async {
    await location.getCurrentLocation();
    setState(() {
      isGetLocation = false;
    });
  }

  void requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.phone,
    ].request();
  }

  @override
  void initState() {
    super.initState();
    this.requestPermission();
    this.getPosition();
  }

  void _onItemTaped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getCellData() async {
    this.getPosition();
    var cell = await telephony.getFlutterTelephony();
    for (var c in cell) {
      Provider.of<CellsData>(context, listen: false).addCell(
          c.mcc,
          c.mnc,
          c.radio,
          c.tac,
          c.ci,
          c.pci,
          c.dbm,
          c.asu,
          c.level,
          location.position);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network cell information'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          this.getCellData();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.signal_cellular_alt_sharp), label: 'Cells'),
          BottomNavigationBarItem(icon: Icon(Icons.map_sharp), label: 'Map'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTaped,
      ),
      body: SafeArea(
        child: Center(
          child: widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
