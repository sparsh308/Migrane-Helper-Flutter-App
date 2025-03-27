import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class BreathingExerciseScreen extends StatefulWidget {
  @override
  _BreathingExerciseScreenState createState() => _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isInhaling = true;
  int _secondsLeft = 60;
  late Timer _timer;
  late Timer _breatheTimer;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _startTimer();
    _startBreatheCycle();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        _timer.cancel();
        _breatheTimer.cancel(); // Stop breathing cycle when time is up
        setState(() {
          isCompleted = true;
        });
      }
    });
  }

  void _startBreatheCycle() {
    _breatheTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        isInhaling = !isInhaling; // Toggle inhale/exhale every 5 seconds
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    _breatheTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: isCompleted
            ? FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeIn),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 80, color: Colors.green),
              SizedBox(height: 20),
              Text(
                "Practice Completed!",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 0.75,
              child: CustomPaint(
                painter: _BreathePainter(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Curves.easeOutQuart,
                    reverseCurve: Curves.easeOutQuart,
                  ),
                  color: Colors.yellow,
                ),
                size: Size.infinite,
              ),
            ),
            SizedBox(height: 30),
            Text(
              isInhaling ? "Breathe In..." : "Breathe Out...",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "$_secondsLeft seconds left",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BreathePainter extends CustomPainter {
  _BreathePainter(this.animation, {this.count = 6, required this.color})
      : circlePaint = Paint()
    ..color = color
    ..blendMode = BlendMode.modulate,
        super(repaint: animation);

  final Animation<double> animation;
  final int count;
  final Paint circlePaint;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide * 0.25) * animation.value;
    for (int index = 0; index < count; index++) {
      final indexAngle = (index * math.pi / count * 2);
      final angle = indexAngle + (math.pi * 1.5 * animation.value);
      final offset = Offset(math.sin(angle), math.cos(angle)) * radius * 0.985;
      canvas.drawCircle(center + offset * animation.value, radius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(_BreathePainter oldDelegate) =>
      animation != oldDelegate.animation;
}