import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class LMap extends StatelessWidget {
  LMap({this.lat = 55.0, this.lon = -0.02});

  final double lat;
  final double lon;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(lat, lon),
        zoom: 15.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(lat, lon),
              builder: (ctx) => Container(
                child: Icon(Icons.close),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
