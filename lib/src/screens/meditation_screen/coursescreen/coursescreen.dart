import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeditationTipsScreen extends StatefulWidget {
  @override
  _MeditationTipsScreenState createState() => _MeditationTipsScreenState();
}

class _MeditationTipsScreenState extends State<MeditationTipsScreen> {
  List<bool> _expandedList = List.generate(7, (index) => false); // State for dropdowns

  final List<String> tips = [
    "Find a quiet and comfortable place to meditate.",
    "Focus on your breathing and be mindful of each inhale and exhale.",
    "Let go of distractions and bring your attention back when your mind wanders.",
    "Start with just a few minutes a day and gradually increase your time.",
    "Practice gratitude and self-compassion during meditation.",
    "Use a guided meditation if you're struggling to focus.",
    "Incorporate meditation into your daily routine for long-term benefits."
  ];

  final List<String> details = [
    "Choose a peaceful environment with minimal noise. A quiet room or a spot in nature works best.",
    "Pay attention to your breath. Inhale deeply, exhale slowly, and maintain a steady rhythm.",
    "Distractions are normal. When your mind wanders, gently bring your focus back to the present moment.",
    "Start small, even 3-5 minutes per day, and slowly increase your meditation duration as you get comfortable.",
    "Think of things you are grateful for and be kind to yourself. Meditation is a self-care practice.",
    "Guided meditations can help you stay focused by following a voice or visualization.",
    "Try to meditate at the same time each day to develop a habit. Consistency leads to long-term benefits."
  ];

  final List<IconData> icons = [
    Icons.spa,
    Icons.waves,
    Icons.loop,
    Icons.timer,
    Icons.favorite,
    Icons.headset,
    Icons.event_repeat
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meditation Tips",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade800, Colors.deepPurple.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: tips.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _expandedList[index] = !_expandedList[index];
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(icons[index], color: Colors.deepPurple, size: 28),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                tips[index],
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(
                              _expandedList[index]
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.deepPurple,
                            ),
                          ],
                        ),

                        // Expanded Details
                        if (_expandedList[index])
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                const SizedBox(width: 40), // Align with icons
                                Expanded(
                                  child: Text(
                                    details[index],
                                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
