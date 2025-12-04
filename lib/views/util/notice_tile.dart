import 'package:flutter/material.dart';
import 'package:society_app/pages/notices.dart';

class NoticeTile extends StatelessWidget {
  const NoticeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NoticePage()),
        );
      },
      child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.blue[50]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Notice Board",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              SizedBox(width: 10,),
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.red
                                ),
                                child: Center(child: Text("2",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))),
                            ],
                          ),
                          Text("Society Annoucements",style: TextStyle(color: Colors.grey[600]),),
                        ],
                      ),
                      Image.asset("lib/images/speaker.png",
                        width: 100,
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}