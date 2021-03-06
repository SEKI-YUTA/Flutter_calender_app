import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  DateFormat _formatter = DateFormat('yyyy-MM-dd');
  DateTime? _nowDate;
  int? _lastDay;
  String? _nowDay;
  List<String> weekDays = ["sun", 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];
  @override
  void initState() {
    super.initState();
    _nowDate = DateTime.now();
    _lastDay = DateTime(_nowDate!.year, _nowDate!.month + 1, 0).day;
    _nowDay = DateTime.now().day.toString();
    print('lastday: ${_lastDay}');
    print(_nowDate!.weekday);
    setState(() {
      _lastDay = _lastDay;
      _nowDate = _nowDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー'),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text((_formatter.format(_nowDate ?? DateTime.now()) ==
              //         _formatter.format(DateTime.now()))
              //     .toString()),
              Text(
                '${_nowDate!.year.toString()}年${_nowDate!.month.toString()}月',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              _createCalender(),
              Row(
                children: [
                  ElevatedButton(onPressed: prevMonth, child: Text('先月')),
                  Spacer(),
                  ElevatedButton(onPressed: nextMonth, child: Text('来月')),
                ],
              )
            ],
          )),
    );
  }

  void nextMonth() {
    DateTime nextMonth = DateTime(_nowDate!.year, _nowDate!.month + 1);
    print('newMonth: ${nextMonth.month}');
    int nextMonthLastDay = DateTime(nextMonth.year, nextMonth.month + 1, 0).day;
    print('nextMonth' + nextMonthLastDay.toString());
    setState(() {
      _nowDate = nextMonth;
      _lastDay = nextMonthLastDay;
    });
  }

  void prevMonth() {
    DateTime prevMonth = DateTime(_nowDate!.year, _nowDate!.month - 1);
    int nextMonthLastDay = DateTime(prevMonth.year, prevMonth.month + 1, 0).day;
    setState(() {
      _nowDate = prevMonth;
      _lastDay = nextMonthLastDay;
    });
  }

  Widget _createCalender() {
    int created = 0;
    int offset = DateTime(_nowDate!.year, _nowDate!.month, 1).weekday;
    return Column(children: [
      _createCalenderHeader(weekDays),
      _createWeek([
        ...List.generate(offset, (index) => "0"),
        ...List.generate(7 - offset, (index) {
          if (index + 1 == 7 - offset) {
            created = 7 - offset;
          }
          return (index + 1).toString();
        }),
      ]),
      _createWeek(List.generate(7, (index) {
        if (index + 1 == 7) {
          created = created + 7;
          return (created).toString();
        } else {
          return (created + index + 1).toString();
        }
      })),
      _createWeek(List.generate(7, (index) {
        if (index + 1 == 7) {
          created = created + 7;
          return (created).toString();
        } else {
          return (created + index + 1).toString();
        }
      })),
      _createWeek(List.generate(7, (index) {
        if (index + 1 == 7) {
          created = created + 7;
          return (created).toString();
        } else {
          return (created + index + 1).toString();
        }
      })),
      _createWeek(List.generate(7, (index) {
        if (index + 1 == 7) {
          created = created + 7;
          return (created).toString();
        } else {
          return (created + index + 1).toString();
        }
      })),
      _createWeek(List.generate(7, (index) {
        if (index + 1 == 7) {
          created = created + 7;
          return (created).toString();
        } else {
          return (created + index + 1).toString();
        }
      })),
    ]);
  }

  Widget _createCalenderHeader(List<String> weekDays) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(weekDays.length,
          (index) => _createDay(day: weekDays[index], bgColor: Colors.grey)),
    );
  }

  Widget _createWeek(
    List<String> days,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(days.length, (index) {
        if (days[index] == "0") {
          return _createDay(day: "");
        }
        if (int.parse(days[index]) > int.parse(_lastDay.toString())) {
          return _createDay(day: "");
        }
        return _createDay(day: days[index]);
      }),
    );
  }

  Widget _createDay({required String day, Color? bgColor}) {
    return Container(
      width: 40,
      height: 30,
      decoration: BoxDecoration(
          color: day == _nowDay &&
                  _formatter.format(_nowDate ?? DateTime.now()) ==
                      _formatter.format(DateTime.now())
              ? Colors.red.withOpacity(0.5)
              : bgColor ?? Colors.blue[100]),
      child: Center(child: Text(day)),
    );
  }
}
