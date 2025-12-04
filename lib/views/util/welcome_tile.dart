import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../tab/bill_card.dart';
import 'package:http/http.dart' as http;

class WelcomeTile extends StatefulWidget {
  const WelcomeTile({super.key});

  @override
  State<WelcomeTile> createState() => _WelcomeTileState();
}

class _WelcomeTileState extends State<WelcomeTile> {
  String userName = "";
  String userEmail = "";
  String userPhone = "";
  String userAddress = "";
  String userToken = "";

  
  Future<String?> loadUserDataAndGetToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Update state variables if needed for UI later,
    // but the key part is getting the token value here.
    setState(() {
      userName = prefs.getString("name") ?? "";
      userEmail = prefs.getString("email") ?? "";
      userPhone = prefs.getString("phone") ?? "";
      userAddress = prefs.getString("address") ?? "";
      userToken = prefs.getString("token") ?? "";
    });

    return prefs.getString("token"); // Return the token directly
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff2193b0), Color(0xff6dd5ed)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------------- WELCOME TEXT ----------------
                    Text(
                      "Welcome $userName",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ---------------- BILL ROW ----------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Billcard(
                          title: "Electric Bill",
                          icon: Icons.flash_on_rounded,
                          iconColor: Colors.orangeAccent,
                          dueDate: "00-00-0000",
                        ),
                        Billcard(
                          title: "Gas Bill",
                          icon: Icons.local_fire_department_rounded,
                          iconColor: Colors.redAccent,
                          dueDate: "00-00-0000",
                        ),
                        Billcard(
                          title: "Water Bill",
                          icon: Icons.water_drop_rounded,
                          iconColor: Colors.blueAccent,
                          dueDate: "00-00-0000",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}