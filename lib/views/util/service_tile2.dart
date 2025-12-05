import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../pages/utility_service.dart';

class ServiceTile extends StatefulWidget {
  
  final String serviceName;
  final serviceColor;
  final String imageName;
  final VoidCallback? onTap;
  
  const ServiceTile({
    super.key,
    required this.serviceName,
    required this.serviceColor,
    required this.imageName,
    this.onTap,
  });

  @override
  State<ServiceTile> createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
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
    return TextButton(
      onPressed: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: widget.serviceColor[50],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0,0), // changes position of shadow
              ),
            ],

            ),
            child: Column(
              children: [
                // service Image
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                  child: Image.asset(widget.imageName),
                ),
      
                //Service Name
                Text(widget.serviceName,style: 
                TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  ),)
              ],
            ),
            ),
      ),
    );
  }
}
