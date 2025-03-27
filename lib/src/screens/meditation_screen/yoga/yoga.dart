import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YogaPosesScreen extends StatefulWidget {
  @override
  _YogaPosesScreenState createState() => _YogaPosesScreenState();
}

class _YogaPosesScreenState extends State<YogaPosesScreen> {
  List<bool> _expandedList = List.generate(7, (index) => false);

  final List<String> yogaPoses = [
    "Mountain Pose (Tadasana)",
    "Downward Dog (Adho Mukha Svanasana)",
    "Warrior I (Virabhadrasana I)",
    "Tree Pose (Vrikshasana)",
    "Child’s Pose (Balasana)",
    "Cobra Pose (Bhujangasana)",
    "Seated Forward Bend (Paschimottanasana)"
  ];

  final List<String> steps = [
    "Stand tall with feet together, arms at sides. Engage your core and relax shoulders.",
    "Start on your hands and knees, lift your hips up and back, forming an inverted V-shape.",
    "Step one foot forward into a lunge, raise your arms overhead, keeping your back straight.",
    "Stand on one leg, place the other foot on the inner thigh, and balance with arms overhead.",
    "Sit on your heels, extend arms forward, and rest your forehead on the ground.",
    "Lie on your stomach, place hands under shoulders, and lift your chest while keeping elbows slightly bent.",
    "Sit with legs extended, hinge forward from the hips, and reach toward your feet."
  ];

  final List<IconData> icons = [
    Icons.accessibility_new,
    Icons.air,
    Icons.self_improvement,
    Icons.nature,
    Icons.weekend,
    Icons.eco,
    Icons.accessibility
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Yoga Poses",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade800, Colors.green.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: yogaPoses.length,
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
                            Icon(icons[index], color: Colors.green, size: 28),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                yogaPoses[index],
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
                              color: Colors.green,
                            ),
                          ],
                        ),
                        if (_expandedList[index])
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                const SizedBox(width: 40),
                                Expanded(
                                  child: Text(
                                    steps[index],
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