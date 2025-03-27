import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeditationHomeRemediesScreen extends StatefulWidget {
  @override
  _MeditationHomeRemediesScreenState createState() => _MeditationHomeRemediesScreenState();
}

class _MeditationHomeRemediesScreenState extends State<MeditationHomeRemediesScreen> {
  List<bool> _expandedList = List.generate(7, (index) => false); // State for dropdowns

  final List<String> remedies = [
    "Drink a cup of chamomile tea to relax your mind.",
    "Use lavender essential oil to create a calming atmosphere.",
    "Take deep breaths with peppermint or eucalyptus aroma.",
    "Practice yoga before meditation to ease stress.",
    "Use warm milk with honey to promote relaxation.",
    "Apply a warm compress on your forehead to relieve tension.",
    "Listen to calming nature sounds for deeper meditation."
  ];

  final List<String> details = [
    "Chamomile tea contains antioxidants that reduce stress and anxiety, helping you feel at ease.",
    "Lavender essential oil has been known to promote relaxation and improve sleep quality.",
    "Peppermint and eucalyptus aromas clear your senses, making it easier to focus on meditation.",
    "Yoga stretches the body and reduces tension, preparing you for a deeper meditative state.",
    "Warm milk with honey can have a soothing effect, aiding in better sleep and relaxation.",
    "A warm compress on your forehead helps relieve headaches and mental tension before meditation.",
    "Nature sounds like rain, ocean waves, or birdsong can enhance your mindfulness practice."
  ];

  final List<IconData> icons = [
    Icons.local_cafe,
    Icons.local_florist,
    Icons.air,
    Icons.self_improvement,
    Icons.local_drink,
    Icons.hot_tub,
    Icons.hearing
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Remedies",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade800, Colors.teal.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: remedies.length,
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
                            Icon(icons[index], color: Colors.teal, size: 28),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                remedies[index],
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
                              color: Colors.teal,
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
