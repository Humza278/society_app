import 'package:flutter/material.dart';
import '../../pages/utility_service.dart';

class ServiceTile extends StatelessWidget {
  
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
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: serviceColor[50],
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
                  child: Image.asset(imageName),
                ),
      
                //Service Name
                Text(serviceName,style: 
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
