import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migrane_helper/src/common_widgets/app_text.dart';
import 'package:migrane_helper/src/screens/home_screen/home_card_breathe.dart';
import 'package:migrane_helper/src/screens/home_screen/home_card_remedies.dart';
import 'package:migrane_helper/src/screens/home_screen/yogacard.dart';
import 'package:migrane_helper/src/themes/theme.dart';

import 'home_card_course.dart';
import 'home_card_sleep.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  String getGreetingMessage() {
    int hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Night";
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.05),
            AppText.normalText(
              getGreetingMessage(),
              fontSize: screenWidth * 0.07,
              isBold: true,
              color: AppTheme.of(context).theme.headerTextColor,
            ),
            AppText.normalText(
              "We wish you have a good day",
              fontSize: screenWidth * 0.05,
              color: AppTheme.of(context).theme.bodyTextColor,
            ),
            SizedBox(height: screenHeight * 0.04),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: HomeCardCourseWidget(
                        backgroundImage: 'assets/images/home_cards/card_one.png',
                        title: "Basics",
                        subTitle: "Course",
                        mainTextColor: Color(0xffFFECCC),
                        textColor: Color(0xffebeaec),
                        buttonColor: Color(0xff3F414E),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(
                      child: HomeCardBreatheWidget(
                        backgroundImage: 'assets/images/breathe.png',
                        title: "Breathe",
                        subTitle: "Practice",
                        mainTextColor: Color(0xff3F414E),
                        textColor: Color(0xff3F414E),
                        buttonColor: Color(0xffFEFFFE),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.03),

                Row(
               children: [
                  HomeCardRemediesWidget(
                    backgroundImage: 'assets/images/home.jpg',
                    title: "Home Remedies",
                    subTitle: "Remedies Guide",
                    mainTextColor: Color(0xff3F414E),
                    textColor: Color(0xff3F414E),
                    buttonColor: Color(0xffFEFFFE),
                  ),


                  ]
                ),

                SizedBox(height: screenHeight * 0.03),
                HomeCardSleepWidget(
                  backgroundImage: 'assets/images/sleep/home_sleep_background.png',
                  title: "Sleep",
                  subTitle: "Sleep tracker and White Noise for better Sleep",
                  mainTextColor: Color(0xffFFECCC),
                  textColor: Color(0xffebeaec),
                  buttonColor: Color(0xff3F414E),
                ),
                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ],
        ),
      ),
    );
  }
}