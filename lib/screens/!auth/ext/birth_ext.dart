import 'package:dungeon_master_death_dealer/state/app_state.dart';
import 'package:flutter/material.dart';

class BirthdayExplanation extends StatelessWidget {
  const BirthdayExplanation({Key? key}) : super(key: key);

  PreferredSizeWidget appBar(context) {
    Size size = AppStateScope.of(context).miscData['media_query'].size;
    return PreferredSize(
      preferredSize: Size(size.width, size.height * 0.075),
      child: Center(
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
            const Text(
              'Birthdays',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyContent(context) {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.cake_outlined,
            color: Colors.white,
            size: 125,
          ),
          const Text(
            'Birthdays On DM: DD',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const Text(
            'Providing your birthday improves the features and ads you see, and helps us keep the Dungeon Master: Death Dealer community safe. You can find your birthday in your Personal Information Account Settings.',
            style: TextStyle(
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              //TODO: handle "Learn More pop up"
              Navigator.of(context).pop();
            },
            child: const Text('Learn More'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar(context),
      body: bodyContent(context),
    );
  }
}
