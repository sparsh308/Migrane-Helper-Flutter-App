import 'package:flutter/material.dart';
import 'package:migrane_helper/src/screens/sleep_screens/sleep_music_details_screen.dart';
import 'package:migrane_helper/src/themes/theme.dart';

import '../../../common_widgets/app_text.dart';

class SleepMusicCardData {
  final String id;
  final String title;
  final String duration;
  final String imagePath;
  final String audioPath;
  final String desc;

  SleepMusicCardData(this.id, this.title, this.duration, this.imagePath, this.audioPath, this.desc);
}

class SleepMusicCard extends StatelessWidget {
  final SleepMusicCardData music;

  const SleepMusicCard({Key? key, required this.music}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        onCardClicked(context);
      },
      child: SizedBox(
        height: screenHeight * 0.22,
        width: screenWidth * 0.42,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: "${music.id}+image",
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: AssetImage(music.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            AppText.normalText(
              music.title,
              fontSize: screenWidth * 0.045,
              isBold: true,
              color: AppTheme.of(context).theme.sleepMusicCardTextHeaderColor,
            ),
            SizedBox(height: screenHeight * 0.005),
            AppText.normalText(
              music.duration,
              fontSize: screenWidth * 0.03,
              isBold: true,
              color: AppTheme.of(context).theme.sleepMusicCardTextBodyColor,
            ),
          ],
        ),
      ),
    );
  }

  void onCardClicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SleepMusicDetailsScreen(
            music: music,
          )),
    );
  }
}