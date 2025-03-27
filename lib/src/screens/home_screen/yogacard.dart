import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:migrane_helper/src/common_widgets/app_buttons.dart';
import 'package:migrane_helper/src/common_widgets/app_text.dart';

import '../meditation_screen/yoga/yoga.dart';

class HomeCardYogaWidget extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final String subTitle;
  final Color mainTextColor;
  final Color textColor;
  final Color buttonColor;

  const HomeCardYogaWidget({
    Key? key,
    required this.backgroundImage,
    required this.title,
    required this.subTitle,
    required this.mainTextColor,
    required this.textColor,
    required this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => onClicked(context),
      child: Container(
        width: screenWidth * 0.45,
        height: screenHeight * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.normalText(
                  title,
                  fontSize: screenWidth * 0.035,
                  isBold: true,
                  color: mainTextColor,
                ),
                AppText.normalText(
                  subTitle,
                  fontSize: screenWidth * 0.03,
                  color: mainTextColor,
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                AppText.normalText(
                  "5-15 MIN",
                  fontSize: screenWidth * 0.03,
                  color: textColor,
                ),
                Spacer(),
                AppButtons.mainButton(
                  "Start",
                  textColor: buttonColor,
                  buttonColor: textColor,
                  onPressed: () => onClicked(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void onClicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YogaPosesScreen(),
      ),
    );
  }
}