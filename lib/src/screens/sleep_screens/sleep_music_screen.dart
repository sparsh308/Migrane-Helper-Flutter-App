import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:migrane_helper/src/screens/sleep_screens/sleep_music_card_widget/sleep_music_card_widget.dart';
import 'package:migrane_helper/src/screens/sleep_screens/sleep_music_card_widget/sleep_music_dummy_data.dart';
import 'package:migrane_helper/src/screens/sleep_screens/sleep_music_details_screen.dart';

class SleepMusicScreen extends StatelessWidget {
  const SleepMusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double itemWidth = screenWidth * 0.42;
    final double itemHeight = screenHeight * 0.22;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Sleep Music"),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff03174C),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.05,
          ),
          crossAxisSpacing: screenWidth * 0.05,
          mainAxisSpacing: screenHeight * 0.03,
          children: sleepMusicDummyData.map((e) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SleepMusicDetailsScreen(
                        music: e,
                      )),
                );
              },
              child: SleepMusicCard(
                music: e,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}