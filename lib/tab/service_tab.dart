import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:society_app/pages/utility_service.dart';
import 'package:society_app/tab/facility_tab.dart';
import 'package:society_app/views/util/community_service_tile.dart';
import 'package:society_app/views/util/faclity_tile.dart';
import 'package:society_app/views/util/notice_tile.dart';
import 'package:society_app/views/util/welcome_tile.dart';
import '../../tab/bill_card.dart';
import 'package:http/http.dart' as http;

class ServiceTab extends StatefulWidget {
  @override
  State<ServiceTab> createState() => _ServiceTabState();
}

class _ServiceTabState extends State<ServiceTab> {
  String userName = "";
  String userEmail = "";
  String userPhone = "";
  String userAddress = "";
  String userToken = "";

  


  Future<http.Response> fetchDataWithToken(String url, String token) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json', // Example header, adjust as needed
        'Authorization': 'Bearer $token', // Include the token here
      },
    );

    if (response.statusCode == 200) {
      // Request successful, handle the response body
      print('Response data: ${response.body}');
      return response;
    } else {
      // Request failed, handle the error
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }

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
  void initState() {
    super.initState();
        loadUserDataAndGetToken().then((token) {
      if (token != null && token.isNotEmpty) {
        fetchDataWithToken(
          "https://api.crystalfms.com/api/v1/get_complain_category",
          token, // Pass the token that was just retrieved
        );
      } else {
        print("Error: Token is missing or empty. Cannot fetch data.");
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // <-- FIX: makes whole page scrollable
      child: Column(
        children: [
          NoticeTile(),
          WelcomeTile(),
          

          // -------------------- SERVICE ICON ROW --------------------
          SizedBox(height: 25),
          CommunityServiceTile(),
          

          SizedBox(height: 20),
          // -------------------- FACILITY BOOKING CARD --------------------
          FaclityTile(),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
