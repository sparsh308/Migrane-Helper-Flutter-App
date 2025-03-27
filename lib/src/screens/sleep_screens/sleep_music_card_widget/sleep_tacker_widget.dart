import 'package:flutter/material.dart';
import 'package:migrane_helper/src/screens/sleep_screens/sleeptracker.dart';
import 'package:migrane_helper/src/themes/theme.dart';
import '../../../common_widgets/app_text.dart';

class SleepTrackerCard extends StatelessWidget {
  const SleepTrackerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCardClicked(context);
      },
      child: Container(
        height: 175,
        width: 177,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            image: AssetImage('assets/images/sleep/home_sleep_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AppText.normalText(
                'Sleep Tracker',
                fontSize: 18,
                isBold: true,
                color: AppTheme.of(context).theme.sleepMusicCardTextHeaderColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: AppText.normalText(
                'Track your weekly sleep',
                fontSize: 11,
                isBold: true,
                color: AppTheme.of(context).theme.sleepMusicCardTextBodyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCardClicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SleepTrackerScreen()),
    );
  }
}