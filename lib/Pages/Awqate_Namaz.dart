import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Awqate_Namaz extends StatefulWidget {
  const Awqate_Namaz({Key? key}) : super(key: key);

  @override
  State<Awqate_Namaz> createState() => _Awqate_NamazState();
}

class _Awqate_NamazState extends State<Awqate_Namaz> {
  // final _prayerTimesBox = Hive.box("prayerTimesBox");

  // void saveTimeInHive(int pryrName, String pryrTime) async{
  //   // await Hive.openBox('prayerTimesBox');
  //   await _prayerTimesBox.putAt(pryrName, pryrTime);
  // }
  //
  // String getUserPrayerTimeFromHive(int pryrName) {
  //   String abc = _prayerTimesBox.getAt(pryrName).toString();
  //     print('saved pryer time in hive for $pryrName is: ' + _prayerTimesBox.get(pryrName).toString());
  //     setState(() {
  //
  //     });
  //   return abc;
  // }

  DateTime? tempChosenTime;
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
  DateTime? fajrTimeFromAPI;
  DateTime? zuhrTimeFromAPI;
  DateTime? asrTimeFromAPI;
  DateTime? maghribTimeFromAPI;
  DateTime? ishaTimeFromAPI;

  @override
  initState() {
    super.initState();
    // later on these coordinates should be set automatically from user location
    Coordinates coordinates = Coordinates(35.2227, 72.4258);
    dateTime = DateTime.now();
    CalculationParameters params = CalculationMethod.Karachi();
    prayerTimes = PrayerTimes(coordinates, dateTime!, params, precision: true);
    params.madhab = Madhab.Hanafi;
    fajrTimeFromAPI = prayerTimes?.fajr?.toLocal();
    zuhrTimeFromAPI = prayerTimes?.dhuhr?.toLocal();
    asrTimeFromAPI = prayerTimes?.asr?.toLocal();
    maghribTimeFromAPI = prayerTimes?.maghrib?.toLocal();
    ishaTimeFromAPI = prayerTimes?.isha?.toLocal();
    // double degree = Qibla.qibla(coordinates);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  columns: const [
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
                          '${DateFormat("hh:mm aa").format(fajrTimeFromAPI!)}')),
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
                          '${DateFormat("hh:mm aa").format(zuhrTimeFromAPI!)}')),
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
                          '${DateFormat("hh:mm aa").format(asrTimeFromAPI!)}')),
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
                          '${DateFormat("hh:mm aa").format(maghribTimeFromAPI!)}')),
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
                          '${DateFormat("hh:mm aa").format(ishaTimeFromAPI!)}')),
                      DataCell(GestureDetector(
                          onTap: () {
                            setState(() {
                              // saveTimeInHive(5,
                                  iosDatePicker(context, 5).toString();
                              // );
                              // getUserPrayerTimeFromHive(2);
                            });
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
          const SizedBox(
            height: 20,
          ),
          const Divider(
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
                const SizedBox(
                  height: 10,
                ),
                const Text('Remaining time for Jamaat in your local mosque'),
                const SizedBox(
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
                          style: const TextStyle(
                              fontFamily: "Open-24-Display-St",
                              fontSize: 30,
                              letterSpacing: 5));
                    }),
                // Text(getUserPrayerTimeFromHive(2)),
              ],
            ),
          ),
        ],
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
  DateTime? iosDatePicker(BuildContext context, int prayerNumber) {
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
                // print('temp time is ${tempTime?.hour}; ${tempTime?.minute}');
                setState(() {
                  switch (prayerNumber) {
                    case 1:
                      {
                        tempChosenTime = fajr_chosenTime = value;
                      }
                      break;

                    case 2:
                      {
                        tempChosenTime = zuhr_chosenTime = value;
                      }
                      break;

                    case 3:
                      {
                        tempChosenTime = asr_chosenTime = value;
                      }
                      break;

                    case 4:
                      {
                        tempChosenTime = maghrib_chosenTime = value;
                      }
                      break;

                    case 5:
                      {
                        tempChosenTime = isha_chosenTime = value;
                      }
                      break;
                    default:
                      {
                        const Text('wrong value for prayer time picker');
                      }
                  }
                });
              },
              initialDateTime: DateTime.now(),
              minimumYear: 2000,
              maximumYear: 3000,
            ),
          );
        });
    print('temp time is ${tempChosenTime?.hour}: ${tempChosenTime?.minute}');
    return tempChosenTime;
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
              const Text('wrong value for prayer time picker');
            }
        }
      });
      theSupposedNextPrayer = theSupposedNextPrayer!.toLocal();
      Duration? remains = theSupposedNextPrayer?.difference(DateTime.now());
      return secondToHour(remains!.inSeconds);
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
