import 'package:adhan_dart/adhan_dart.dart';
import 'package:intl/intl.dart';
enum Prayer{
  fajr,
  zuhr,
  asr,
  maghrib,
  isha
}

class Awqate_Namaz {
  Awqate_Namaz({required this.prayerName, this.prayerTimePicked});



  String prayerName;
  DateTime? prayerTimeFromAPI;
  DateTime? prayerTimePicked;
  DateTime? timeNow = DateTime.now();

  String waqte_namaz() {
    return DateFormat("hh:mm aa").format(prayerTimeFromAPI!);
  }
}
