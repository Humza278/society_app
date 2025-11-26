import 'package:flutter/material.dart';

class MyTab extends StatelessWidget {
  // final IconData iconPath;
  final String tabName;
  final String tabImage;



  const MyTab({super.key,required this.tabImage, required this.tabName});

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 90,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              // color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(tabImage,width: 40,height: 40,),
          ),
          Text(tabName),
        ],
        
      ),
    );
  }
}
