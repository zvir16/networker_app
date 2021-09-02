import 'package:flutter/services.dart';
import 'package:flutter_telephony/flutter_telephony.dart';

class Telephony {
  Future getFlutterTelephony() async {
    var cell;
    try {
      cell = await FlutterTelephonyInfo.getCellList;
    } on PlatformException {}

    return cell;
  }
}
