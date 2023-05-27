import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:hive/hive.dart';

main() async {
  runApp(MaterialApp(home: MyApp()));
  var path = Directory.current.path;
  var box = await Hive.openBox('testBox');

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  double percent = 0.0;
  late Timer timer;
  bool initialSwitchValue = false;
  PrayerTimes? prayerTimes;

  // variables to pick up Jamaat Time for prayer in the local mosque
  DateTime? fajr_chosenTime;
  DateTime? zuhr_chosenTime;
  DateTime? asr_chosenTime;
  DateTime? maghrib_chosenTime;
  DateTime? isha_chosenTime;

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
  initState() {

    super.initState();
    Coordinates coordinates = Coordinates(35.2227, 72.4258);
    dateTime = DateTime.now();
    CalculationParameters params = CalculationMethod.Karachi();
    prayerTimes = PrayerTimes(coordinates, dateTime!, params, precision: true);
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
                        DataCell(Text(
                            '${DateFormat("hh:mm aa").format(kfajrTime!)}')),
                        DataCell(GestureDetector(
                            onTap: () {
                              iosDatePicker(context, 1);
                            },
                            child: Text(fajr_chosenTime == null
                                    ? 'Pick time'
                                    : '${DateFormat("hh:mm aa").format(fajr_chosenTime!)}'
                                // ,
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
                        DataCell(Text(
                            '${DateFormat("hh:mm aa").format(kzuhrTime!)}')),
                        DataCell(GestureDetector(
                            onTap: () {
                              iosDatePicker(context, 2);
                            },
                            child: Text(zuhr_chosenTime == null
                                ? 'Pick time'
                                : '${DateFormat("hh:mm aa").format(zuhr_chosenTime!)}'))),
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
                        DataCell(Text(
                            '${DateFormat("hh:mm aa").format(kasrTime!)}')),
                        DataCell(GestureDetector(
                            onTap: () {
                              iosDatePicker(context, 3);
                            },
                            child: Text(asr_chosenTime == null
                                ? 'Pick time'
                                : '${DateFormat("hh:mm aa").format(asr_chosenTime!)}'))),
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
                            '${DateFormat("hh:mm aa").format(kmaghribTime!)}')),
                        DataCell(GestureDetector(
                            onTap: () {
                              iosDatePicker(context, 4);
                            },
                            child: Text(maghrib_chosenTime == null
                                ? 'Pick time'
                                : '${DateFormat("hh:mm aa").format(maghrib_chosenTime!)}'))),
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
                        DataCell(Text(
                            '${DateFormat("hh:mm aa").format(kishaTime!)}')),
                        DataCell(GestureDetector(
                            onTap: () {
                              iosDatePicker(context, 5);
                            },
                            child: Text(isha_chosenTime == null
                                ? 'Pick time'
                                : '${DateFormat("hh:mm aa").format(isha_chosenTime!)}'))),
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
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
            ),
            Expanded(
              child: Column(
                children: [
                  // const Text('Remaining time till the prayer is allowed'),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Text(
                  //   prayerTimes!.nextPrayer().toString().toUpperCase(),
                  //   style: TextStyle(fontSize: 22, color: Colors.orange[900]),
                  // ),
                  // StreamBuilder(
                  //     stream: remainingTimeTillAllowedTime(),
                  //     builder: (context, snapshot) {
                  //       return Text("${snapshot.data}",
                  //           style: TextStyle(
                  //               fontFamily: "Open-24-Display-St",
                  //               fontSize: 30,
                  //               letterSpacing: 5));
                  //     }),
                  SizedBox(
                    height: 10,
                  ),
                  const Text('Remaining time for Jamaat in your local mosque'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    prayerTimes!.nextPrayer().toString().toUpperCase(),
                    style: TextStyle(fontSize: 22, color: Colors.orange[900]),
                  ),
                  StreamBuilder(
                      stream: remainingTimeInLocalMosque(),
                      builder: (context, snapshot) {
                        return Text("${snapshot.data}",
                            style: TextStyle(
                                fontFamily: "Open-24-Display-St",
                                fontSize: 30,
                                letterSpacing: 5));
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // androidDatePicker(BuildContext context) async {
  //   fajr_chosenTime = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );
  // }

//ios date picker
  iosDatePicker(BuildContext context, int prayerNumber) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.transparent,
            child: CupertinoDatePicker(
              use24hFormat: false,
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (value) {
                switch (prayerNumber) {
                  case 1:
                    {
                      fajr_chosenTime = value;
                    }
                    break;

                  case 2:
                    {
                      zuhr_chosenTime = value;
                    }
                    break;

                  case 3:
                    {
                      asr_chosenTime = value;
                    }
                    break;

                  case 4:
                    {
                      maghrib_chosenTime = value;
                    }
                    break;

                  case 5:
                    {
                      isha_chosenTime = value;
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

  remainingTimeTillAllowedTime() async* {
    yield* Stream.periodic(Duration(seconds: 1), (t) {
      String prayer = prayerTimes?.nextPrayer();
      DateTime? nextPrayerTime = prayerTimes?.timeForPrayer(prayer)!.toLocal();
      DateTime now = DateTime.now();
      Duration? remains = nextPrayerTime?.difference(now);
      return secondToHour(remains!.inSeconds);
    });
  }

  remainingTimeInLocalMosque() async* {
    yield* Stream.periodic(Duration(seconds: 1), (t) {
      String nextPrayerTemp = prayerTimes?.nextPrayer();
      DateTime? theSupposedNextPrayer = null;
      // print(nextPrayerTemp);
      setState(() {
        switch (nextPrayerTemp) {
          case 'fajr':
            {
              theSupposedNextPrayer = fajr_chosenTime;
            }
            break;

          case 'dhuhr':
            {
              theSupposedNextPrayer = zuhr_chosenTime;
            }
            break;

          case 'asr':
            {
              theSupposedNextPrayer = asr_chosenTime;
            }
            break;

          case 'maghrib':
            {
              theSupposedNextPrayer = maghrib_chosenTime;
            }
            break;

          case 'isha':
            {
              theSupposedNextPrayer = isha_chosenTime;
            }
            break;
          default:
            {
              Text('wrong value for prayer time picker');
            }
        }
      });
      DateTime? nextLocalPrayerTime = theSupposedNextPrayer!.toLocal();
      DateTime now = DateTime.now();
      Duration? remains = nextLocalPrayerTime.difference(now);
      return secondToHour(remains.inSeconds);
    });
  }

  secondToHour(int seconds) {
    int minutes = seconds ~/ 60;
    int hours = minutes ~/ 60;
    seconds = seconds - minutes * 60;
    minutes = minutes - hours * 60;
    return "$hours:$minutes:$seconds";
  }
}

