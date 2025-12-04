import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Visitor {
  final int id;
  final String name;
  final String type;
  final String date;
  final String time;
  String status; // checked_in / checked_out
  final String icon;

  Visitor({
    required this.id,
    required this.name,
    required this.type,
    required this.date,
    required this.time,
    required this.status,
    required this.icon,
  });
}

class VisitorScreen extends StatefulWidget {
  const VisitorScreen({super.key});

  @override
  State<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  List<Visitor> visitors = [
    Visitor(
      id: 1,
      name: "John Delivery",
      type: "Delivery",
      date: "Dec 24, 2024",
      time: "2:30 PM",
      status: "checked_out",
      icon: "📦",
    ),
    Visitor(
      id: 2,
      name: "Sarah Smith",
      type: "Guest",
      date: "Dec 24, 2024",
      time: "1:15 PM",
      status: "checked_in",
      icon: "👤",
    ),
    Visitor(
      id: 3,
      name: "Mike Johnson",
      type: "Maintenance",
      date: "Dec 23, 2024",
      time: "10:45 AM",
      status: "checked_out",
      icon: "🔧",
    ),
  ];

  final TextEditingController nameCtrl = TextEditingController();
  String selectedType = "Guest";

  void checkInVisitor() {
    if (nameCtrl.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter visitor name")));
      return;
    }

    final newVisitor = Visitor(
      id: visitors.length + 1,
      name: nameCtrl.text,
      type: selectedType,
      date: "Today",
      time: TimeOfDay.now().format(context),
      status: "checked_in",
      icon: "👤",
    );

    setState(() => visitors.insert(0, newVisitor));

    Navigator.pop(context);
    nameCtrl.clear();
    selectedType = "Guest";
  }

  void checkOut(int id) {
    setState(() {
      visitors.firstWhere((v) => v.id == id).status = "checked_out";
    });
  }

  Color statusColor(String status) =>
      status == "checked_in" ? Colors.green : Colors.orange;

  @override
  Widget build(BuildContext context) {
    final checkedInCount = visitors
        .where((v) => v.status == "checked_in")
        .length;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        onPressed: showCheckInSheet,
        label: const Text("Check In"),
        icon: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          _buildHeader(),
          _buildStats(checkedInCount),
          Expanded(child: _buildVisitorList()),
        ],
      ),
    );
  }

  // ------------------------ HEADER -------------------------
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.deepOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Visitor Log",
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Track all visitors in your property",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------ STATS -------------------------
  Widget _buildStats(int checkedInCount) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _statCard("Total", visitors.length.toString(), Icons.people),
          const SizedBox(width: 12),
          _statCard("Inside", checkedInCount.toString(), Icons.check_circle),
          const SizedBox(width: 12),
          _statCard(
            "Today",
            visitors.where((v) => v.date == "Today").length.toString(),
            Icons.calendar_today,
          ),
        ],
      ),
    );
  }

  Widget _statCard(String label, String number, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.orange, size: 28),
            const SizedBox(height: 6),
            Text(
              number,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------ VISITOR LIST -------------------------
  Widget _buildVisitorList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: visitors.length,
      itemBuilder: (_, i) {
        final v = visitors[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                child: Text(v.icon, style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      v.name,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${v.type} • ${v.time} • ${v.date}",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor(v.status).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  v.status == "checked_in" ? "Inside" : "Left",
                  style: TextStyle(
                    color: statusColor(v.status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (v.status == "checked_in")
                TextButton(
                  onPressed: () => checkOut(v.id),
                  child: const Text("Check Out"),
                ),
            ],
          ),
        );
      },
    );
  }

  // ------------------------ CHECK IN BOTTOM SHEET -------------------------
  void showCheckInSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Check In Visitor",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),

            // Name Input
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: "Visitor Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Visitor type selection
            Wrap(
              spacing: 10,
              children: [
                for (final type in [
                  "Guest",
                  "Delivery",
                  "Maintenance",
                  "Service",
                ])
                  ChoiceChip(
                    label: Text(type),
                    selected: selectedType == type,
                    onSelected: (_) => setState(() => selectedType = type),
                    selectedColor: Colors.orange,
                    labelStyle: TextStyle(
                      color: selectedType == type
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: checkInVisitor,
                child: const Text(
                  "Confirm Check In",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
