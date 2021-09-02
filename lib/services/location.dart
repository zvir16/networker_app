import 'package:geolocator/geolocator.dart';

class Location {
  Position _position;
  double longtitude;
  double latitude;

  Future<void> getCurrentLocation() async {
    try {
      _position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      latitude = position.latitude;
      longtitude = position.longitude;
    } catch (e) {
      _position = null;
      print(e);
    }
  }

  Position get position {
    return this._position;
  }
}
