import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SleepTrackerScreen extends StatefulWidget {
  @override
  _SleepTrackerScreenState createState() => _SleepTrackerScreenState();
}

class _SleepTrackerScreenState extends State<SleepTrackerScreen> {
  bool isTracking = false;
  DateTime? startTime;
  double sleepDuration = 0;
  List<double> sleepData = List.filled(7, 0);

  @override
  void initState() {
    super.initState();
    _loadSleepData();
  }

  void _toggleSleepTracking() async {
    if (isTracking) {
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime!).inHours.toDouble();
      setState(() {
        sleepDuration = duration;
        isTracking = false;
      });
      _saveSleepData(duration);
    } else {
      setState(() {
        startTime = DateTime.now();
        isTracking = true;
      });
    }
  }

  Future<void> _saveSleepData(double duration) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      sleepData.removeAt(0);
      sleepData.add(duration);
    });
    await prefs.setString('sleepData', jsonEncode(sleepData));
  }

  Future<void> _loadSleepData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('sleepData');
    if (data != null) {
      setState(() {
        sleepData = List<double>.from(jsonDecode(data));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('Sleep Tracker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isTracking ? 'Tracking Sleep...' : 'Last Sleep Duration: ${sleepDuration.toStringAsFixed(1)} hours',
            style: TextStyle(fontSize: screenWidth * 0.05),
          ),
          SizedBox(height: screenHeight * 0.02),
          ElevatedButton(
            onPressed: _toggleSleepTracking,
            child: Text(
              isTracking ? 'Stop Tracking' : 'Start Tracking',
              style: TextStyle(fontSize: screenWidth * 0.045),
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                          return Text(
                            days[value.toInt() % 7],
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(7, (index) => FlSpot(index.toDouble(), sleepData[index])),
                      isCurved: true,
                      barWidth: screenWidth * 0.007,
                      color: Colors.blue,
                      belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}