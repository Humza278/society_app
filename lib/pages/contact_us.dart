import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f0f0f),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // -------------------------------------------------
            // TOP GRADIENT BOX
            // -------------------------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 50),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffff1f8f), Color(0xffff6a00)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 150.0),
                        child: Icon(Icons.bolt, color: Colors.white, size: 40),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Hit Us Up!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "We're all ears 👂",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // -------------------------------------------------
            // CONTACT CARDS (CALL, EMAIL, VIBE)
            // -------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                contactCard(
                  icon: Icons.call,
                  color: Colors.cyan,
                  title: "CALL",
                  subtitle: "+923031134408",
                ),
                const SizedBox(width: 15),
                contactCard(
                  icon: Icons.email,
                  color: Colors.greenAccent.shade400,
                  title: "EMAIL",
                  subtitle: "crystaltech@gmail.com",
                ),
                const SizedBox(width: 15),
                contactCard(
                  icon: Icons.location_pin,
                  color: Colors.orangeAccent,
                  title: "Location",
                  subtitle: "123 Main St",
                ),
              ],
            ),

            const SizedBox(height: 35),

            // -------------------------------------------------
            // FORM CONTAINER
            // -------------------------------------------------
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xff1a1a1a),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Slide Into Our DMs",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "💬 Quick Reply",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Form Fields
                  blackInputField(Icons.person, "Your name"),
                  const SizedBox(height: 15),

                  blackInputField(Icons.email, "Your email"),
                  const SizedBox(height: 15),

                  blackInputField(
                    Icons.chat_bubble_outline,
                    "What's on your mind?",
                  ),
                  const SizedBox(height: 15),

                  blackInputField(
                    Icons.message,
                    "Tell us everything...",
                    maxLines: 5,
                  ),

                  const SizedBox(height: 20),

                  // Send Button
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Send Message 🚀",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------
  // CONTACT CARD WIDGET
  // -------------------------------------------------
  Widget contactCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      width: 110,
      decoration: BoxDecoration(
        color: const Color(0xff1a1a1a),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------
  // INPUT FIELD WIDGET
  // -------------------------------------------------
  Widget blackInputField(IconData icon, String hint, {int maxLines = 1}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xff0f0f0f),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.white60),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
