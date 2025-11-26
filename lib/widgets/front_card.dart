// import 'package:flutter/material.dart';
// import '../widgets/service_tile.dart';

// class ServiceCard extends StatelessWidget {
//   ServiceCard({super.key});

//   // List of services
//   final List<Map<String, dynamic>> services = [
//     {
//       'name': 'Lodge Complaint',
//       'color': Colors.grey,
//       'icon': Icons.build_outlined,
//     },
//     {
//       'name': 'View Bills',
//       'color': Colors.grey,
//       'icon': Icons.credit_card_outlined,
//     },
//     {
//       'name': 'Notices',
//       'color': Colors.grey,
//       'icon': Icons.volume_up_outlined,
//     },
//     {
//       'name': 'Visitor Entry',
//       'color': Colors.grey,
//       'icon': Icons.door_front_door_outlined,
//     },
//     {
//       'name': 'Facility Booking',
//       'color': Colors.grey,
//       'icon': Icons.event_available_outlined,
//     },
//     {
//       'name': 'My Documents',
//       'color': Colors.grey,
//       'icon': Icons.description_outlined,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox.expand(
//       child: GridView.builder(
//         physics: const BouncingScrollPhysics(),
//         itemCount: services.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//           childAspectRatio: 1/1.3,
//         ),
//         itemBuilder: (context, index) {
//           final service = services[index];
//           return ServiceCard();
//         },
//       ),
//     );
//   }
// }
