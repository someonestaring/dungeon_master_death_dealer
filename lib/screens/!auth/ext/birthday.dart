import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_master_death_dealer/state/app_state.dart';
import 'package:dungeon_master_death_dealer/screens/!auth/ext/username.dart';
import 'package:dungeon_master_death_dealer/screens/!auth/ext/birth_ext.dart';

class Birthday extends StatefulWidget {
  const Birthday({Key? key}) : super(key: key);

  @override
  BirthdayState createState() => BirthdayState();
}

class BirthdayState extends State<Birthday> {
  final DateTime date = DateTime.now().toUtc();
  final Map months = const {
    0: {'name': 'January', 'short': 'Jan', 'number': 1, 'days': 31},
    1: {'name': 'February', 'short': 'Feb', 'number': 2, 'days': 28},
    2: {'name': 'March', 'short': 'Mar', 'number': 3, 'days': 31},
    3: {'name': 'April', 'short': 'Apr', 'number': 4, 'days': 30},
    4: {'name': 'May', 'short': 'May', 'number': 5, 'days': 31},
    5: {'name': 'June', 'short': 'Jun', 'number': 6, 'days': 30},
    6: {'name': 'July', 'short': 'Jul', 'number': 7, 'days': 31},
    7: {'name': 'August', 'short': 'Aug', 'number': 8, 'days': 31},
    8: {'name': 'September', 'short': 'Sep', 'number': 9, 'days': 30},
    9: {'name': 'October', 'short': 'Oct', 'number': 10, 'days': 31},
    10: {'name': 'November', 'short': 'Nov', 'number': 11, 'days': 30},
    11: {'name': 'December', 'short': 'Dec', 'number': 12, 'days': 31}
  }; // could/should be stored static and imported
  int day = 1;
  int year = 2020;
  Map selectedMonth = {
    'name': 'January',
    'short': 'Jan',
    'number': 1,
    'days': 31
  };
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    PreferredSizeWidget appBar() {
      return PreferredSize(
        preferredSize: Size(size.width, size.height * 0.15),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cake_outlined,
                color: Colors.white,
                size: 64,
              ),
            ],
          ),
        ),
      );
    }

    Widget birthdayBox() {
      var bDay =
          DateFormat('M/d/yyyy').parse('${selectedMonth['number']}/$day/$year');
      var age = date.difference(bDay).inDays / 365;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          height: size.height * 0.05,
          width: size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  '${selectedMonth['name']} $day, $year',
                  style: const TextStyle(
                    color: Colors.white54,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  "You are ${age.floor()} years old.",
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget bodyContent() {
      return Column(
        children: [
          const Text(
            'Add Your Birthday',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const BirthdayExplanation(),
                ),
              );
            },
            child: const Text(
              "This won't be part of your public profile. \n Why do I need to provide my birthday?",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          birthdayBox(),
          const Spacer(),
          SizedBox(
            width: size.width,
            child: ElevatedButton(
              onPressed: () {
                AppStateWidget.of(context).updateUserData(
                    {'birthday': '${selectedMonth['name']} $day, $year'});
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Username(),
                  ),
                );
              },
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }

    Widget bottomNav() {
      Size size = MediaQuery.of(context).size;
      final List<Widget> names = <Widget>[];
      List<Widget> days = List.generate(
          selectedMonth['days'],
          (index) => Text(
                '${index + 1}',
                style: const TextStyle(color: Colors.white70),
              ));
      months.forEach((k, v) {
        names.add(Text(
          v['name'],
          style: const TextStyle(color: Colors.white70),
        ));
      });
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.25,
            width: size.width * 0.25,
            child: ListWheelScrollView(
              onSelectedItemChanged: (item) {
                setState(() {
                  selectedMonth = months[item];
                  days = List.generate(
                      selectedMonth['days'],
                      (index) => Text(
                            '${index + 1}',
                            style: const TextStyle(color: Colors.white70),
                          ));
                });
              },
              physics: const FixedExtentScrollPhysics(),
              magnification: 1.5,
              useMagnifier: true,
              diameterRatio: 0.75,
              itemExtent: size.height * 0.025,
              children: names,
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
            child: const VerticalDivider(
              color: Colors.white70,
            ),
          ),
          SizedBox(
            height: size.height * 0.25,
            width: size.width * 0.25,
            child: ListWheelScrollView(
              physics: const FixedExtentScrollPhysics(),
              magnification: 1.5,
              useMagnifier: true,
              diameterRatio: 0.75,
              itemExtent: size.height * 0.025,
              children: days,
              onSelectedItemChanged: (item) {
                setState(() {
                  day = item + 1;
                });
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
            child: const VerticalDivider(
              color: Colors.white70,
            ),
          ),
          SizedBox(
            height: size.height * 0.25,
            width: size.width * 0.25,
            child: ListWheelScrollView(
              physics: const FixedExtentScrollPhysics(),
              magnification: 1.5,
              useMagnifier: true,
              diameterRatio: 0.75,
              itemExtent: size.height * 0.025,
              children: List.generate(
                  150,
                  (index) => Text(
                        '${date.year - index}',
                        style: const TextStyle(color: Colors.white70),
                      )),
              onSelectedItemChanged: (item) {
                setState(() {
                  year = date.year - item;
                });
              },
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: bodyContent(),
      appBar: appBar(),
      bottomNavigationBar: bottomNav(),
    );
  }
}
