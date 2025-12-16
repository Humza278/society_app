import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("lib/images/Crystal FMS.png",width: 50,height: 50,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Column(
                    children: [
                      Text("Welcome Humza",style: TextStyle(color: Colors.white),),
                      Text("Flat # 17 Block B",style: TextStyle(color: Colors.white54))
                    ],
                  ),
                ),
              ),
              Image.asset(
                "lib/images/Crystal FMS.png",
                width: 50,
                height: 50,
              ),
            ],
          ),
        )
      ],
      )
      ),
    );
  }
}
