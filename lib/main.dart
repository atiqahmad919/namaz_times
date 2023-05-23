import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:adhan_dart/adhan_dart.dart';

main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool initialSwitchValue = false;
  PrayerTimes? prayerTimes;
  // variables to pick up Jamaat Time for prayer in the local mosque
  DateTime? fajr_chosenDateTime;
  DateTime? zuhr_chosenDateTime;
  DateTime? asr_chosenDateTime;
  DateTime? maghrib_chosenDateTime;
  DateTime? isha_chosenDateTime;

  // variables for setting alarm
  bool _fajr_Alarm = true;
  bool _zuhr_Alarm = false;
  bool _asr_Alarm = false;
  bool _maghrib_Alarm = false;
  bool _isha_Alarm = false;

// variables to get allowed times for each prayer
  DateTime? dateTime;
  DateTime? kfajrTime;
  DateTime? kzuhrTime;
  DateTime? kasrTime;
  DateTime? kmaghribTime;
  DateTime? kishaTime;

  // if(DateTime)

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Coordinates coordinates = Coordinates(35.2227, 72.4258);
    dateTime = DateTime.now();
    CalculationParameters params = CalculationMethod.Karachi();
    prayerTimes =
        PrayerTimes(coordinates, dateTime!, params, precision: true);
    params.madhab = Madhab.Hanafi;
    DateTime? fajrTime = prayerTimes?.fajr?.toLocal();
    DateTime? zuhrTime = prayerTimes?.dhuhr?.toLocal();
    DateTime? asrTime = prayerTimes?.asr?.toLocal();
    DateTime? maghribTime = prayerTimes?.maghrib?.toLocal();
    DateTime? ishaTime = prayerTimes?.isha?.toLocal();
    double degree = Qibla.qibla(coordinates);

    // print(asrTime);
    kfajrTime = fajrTime;
    kzuhrTime = zuhrTime;
    kasrTime = asrTime;
    kmaghribTime = maghribTime;
    kishaTime = ishaTime;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              'Prayer Times on ${dateTime?.day}/${dateTime?.month}/${dateTime?.year}'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DataTable(
                    // headingTextStyle: TextStyle(
                    //   color: Colors.red,
                    // ),
                    columnSpacing: 20.0,
                    columns: [
                      DataColumn(
                          label: Text('Prayer\nName',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Allowed\nTime',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Masjid \nTime',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Set \nAlarm',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('فجر')),
                        DataCell(
                            Text('${kfajrTime?.hour}:${kfajrTime?.minute}')),
                        DataCell(GestureDetector(
                            onTap: () {
                              iosDatePicker(context, 1);
                            },
                            child: Text(
                              fajr_chosenDateTime == null
                                  ? 'Pick time'
                                  : '${fajr_chosenDateTime!.hour}: ${fajr_chosenDateTime!.minute}',
                            ))),
                        DataCell(CupertinoSwitch(
                            value: _fajr_Alarm,
                            onChanged: (value) {
                              setState(() {
                                _fajr_Alarm = value;
                              });
                            })),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('ظہر')),
                        DataCell(
                            Text('${kzuhrTime?.hour}:${kzuhrTime?.minute}')),
                        DataCell(GestureDetector(
                            onTap: () {
                              iosDatePicker(context, 2);
                            },
                            child: Text(
                              zuhr_chosenDateTime == null
                                  ? 'Pick time'
                                  : '${zuhr_chosenDateTime!.hour}: ${zuhr_chosenDateTime!.minute}',
                            ))),
                        DataCell(CupertinoSwitch(
                            value: _zuhr_Alarm,
                            onChanged: (value) {
                              setState(() {
                                _zuhr_Alarm = value;
                              });
                            })),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('عصر')),
                        DataCell(Text('${kasrTime?.hour}:${kasrTime?.minute}')),
                        DataCell(GestureDetector(
                            onTap: () {
                              iosDatePicker(context, 3);
                            },
                            child: Text(
                              asr_chosenDateTime == null
                                  ? 'Pick time'
                                  : '${asr_chosenDateTime!.hour}: ${asr_chosenDateTime!.minute}',
                            ))),
                        DataCell(CupertinoSwitch(
                            value: _asr_Alarm,
                            onChanged: (value) {
                              setState(() {
                                _asr_Alarm = value;
                              });
                            })),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('مغرب')),
                        DataCell(Text(
                            '${kmaghribTime?.hour}:${kmaghribTime?.minute}')),
                        DataCell(GestureDetector(
                            onTap: () {
                              iosDatePicker(context, 4);
                            },
                            child: Text(
                              maghrib_chosenDateTime == null
                                  ? 'Pick time'
                                  : '${maghrib_chosenDateTime!.hour}: ${maghrib_chosenDateTime!.minute}',
                            ))),
                        DataCell(CupertinoSwitch(
                            value: _maghrib_Alarm,
                            onChanged: (value) {
                              setState(() {
                                _maghrib_Alarm = value;
                              });
                            })),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('عشأ')),
                        DataCell(
                            Text('${kishaTime?.hour}:${kishaTime?.minute}')),
                        DataCell(GestureDetector(
                            onTap: () {
                              iosDatePicker(context, 5);
                            },
                            child: Text(
                              isha_chosenDateTime == null
                                  ? 'Pick time'
                                  : '${isha_chosenDateTime!.hour}: ${isha_chosenDateTime!.minute}',
                            ))),
                        DataCell(CupertinoSwitch(
                            value: _isha_Alarm,
                            onChanged: (value) {
                              setState(() {
                                _isha_Alarm = value;
                              });
                            })),
                      ]),
                    ],
                  ),
                ),

              ],
            ),
            SizedBox(height: 50,),
            Divider(thickness: 1,),
            Expanded(
              child: Column(
                children: [
                  Text('Remaining time for upcoming prayer'),
                  SizedBox(height: 20,),
                  Text(prayerTimes!.nextPrayer().toString().toUpperCase()),
                  StreamBuilder(
                    stream: remainingTime(),
                    builder: (context, snapshot) {
                      return Text("${snapshot.data}");
                    }
                  ),
                ],
              ),
            ),
            Expanded(child: CircularPercentIndicator(
              circularStrokeCap: CircularStrokeCap.round,
              percent: 100,
              animation: true,
              animateFromLastPercent: true,
              radius: 250,
              lineWidth: 20,
              progressColor: Colors.deepPurple,
              center: Text('25', style: TextStyle(color: Colors.pink),),
            ),)
          ],
        ),
      ),
    );
  }

  // Widget customSwitch(int alarmNumber) {
  //   return Transform.scale(
  //     scale: 0.8,
  //     child: CupertinoSwitch(
  //       value: initialSwitchValue,
  //       onChanged: (value) {
  //         print('the value of switch is: $value');
  //           setState(() {
  //             switch(alarmNumber) {
  //               case 1: {
  //                 initialSwitchValue = value;
  //                 _fajr_Alarm = initialSwitchValue; }
  //               break;
  //
  //               case 2: {  _zuhr_Alarm = value; }
  //               break;
  //
  //               case 3: {  _asr_Alarm = value; }
  //               break;
  //
  //               case 4: {  _maghrib_Alarm = value; }
  //               break;
  //
  //               case 5: {  _isha_Alarm = value; }
  //               break;
  //               default: {print('wrong value for alarm');}
  //             }
  //           });
  //       },
  //     ),
  //   );
  // }

  androidDatePicker(BuildContext context) async {
    fajr_chosenDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

//ios date picker
  iosDatePicker(BuildContext context, int prayerNumber) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              use24hFormat: true,
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (value) {
                switch (prayerNumber) {
                  case 1:
                    {
                      fajr_chosenDateTime = value;
                    }
                    break;

                  case 2:
                    {
                      zuhr_chosenDateTime = value;
                    }
                    break;

                  case 3:
                    {
                      asr_chosenDateTime = value;
                    }
                    break;

                  case 4:
                    {
                      maghrib_chosenDateTime = value;
                    }
                    break;

                  case 5:
                    {
                      isha_chosenDateTime = value;
                    }
                    break;
                  default:
                    {
                      print('wrong value for prayer time picker');
                    }
                }
                setState(() {});
              },
              initialDateTime: DateTime.now(),
              minimumYear: 2000,
              maximumYear: 3000,
            ),
          );
        });
  }

  remainingTime() async*{
    yield* Stream.periodic(Duration(seconds: 1), (t){
      String prayer = prayerTimes?.nextPrayer();
      DateTime? nextPrayerTime = prayerTimes?.timeForPrayer(prayer)!.toLocal();
      DateTime now = DateTime.now();
      Duration? remains = nextPrayerTime?.difference(now);
      return secondToHour(remains!.inSeconds);
    });
  }

  secondToHour(int seconds){
    int minutes = seconds ~/ 60;
    int hours = minutes ~/ 60;
    seconds   = seconds - minutes * 60;
    minutes = minutes - hours * 60;
    return "$hours:$minutes:$seconds";
  }



}
