import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<Map<String, dynamic>> complaints = [
    {
      "title": "Water Leakage",
      "description": "Leakage in kitchen pipeline",
      "status": "In Progress",
      "date": "2025-12-05",
    },
    {
      "title": "Security Issue",
      "description": "Gate security guard absent",
      "status": "Resolved",
      "date": "2025-12-02",
    },
  ];

  // -------------------------------------------------------------
  // Submit New Complaint
  // -------------------------------------------------------------
  void _submitComplaint() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      return;
    }

    setState(() {
      complaints.insert(0, {
        "title": _titleController.text,
        "description": _descriptionController.text,
        "status": "Pending",
        "date": DateTime.now().toString().split(" ")[0],
      });
    });

    _titleController.clear();
    _descriptionController.clear();

    Navigator.pop(context); // close popup
  }

  // -------------------------------------------------------------
  //  Popup: New Complaint Form
  // -------------------------------------------------------------
  void _openComplaintPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Lodge a Complaint",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitComplaint,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Submit", style: TextStyle(fontSize: 16)),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  // -------------------------------------------------------------
  // Color for Status Chip
  // -------------------------------------------------------------
  Color _statusColor(String status) {
    switch (status) {
      case "Resolved":
        return Colors.green;
      case "In Progress":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  // -------------------------------------------------------------
  // Main UI
  // -------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80), // move up
        child: FloatingActionButton(
          onPressed: _openComplaintPopup,
          backgroundColor: Colors.blue[200], // make FAB blue
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.add,color: Colors.white,),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildStats(),
          Expanded(
            child: _buildVisitorList(),
          ),
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
          colors: [Colors.blue, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Complaints Log",
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Track all Your complaints",
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
  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _statCard("Total", '3', Icons.privacy_tip_rounded),
          const SizedBox(width: 12),
          _statCard("Resolved", '1', Icons.check_circle),
          const SizedBox(width: 12),
          _statCard(
            "In Process",
            '2',
            Icons.wifi_protected_setup_sharp,
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
            Icon(icon, color: Colors.lightBlueAccent, size: 28),
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
              itemCount: complaints.length,
              itemBuilder: (context, index) {
                final c = complaints[index];
      
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            c["title"],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _statusColor(
                                c["status"],
                              ).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              c["status"],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _statusColor(c["status"]),
                              ),
                            ),
                          ),
                        ],
                      ),
      
                      const SizedBox(height: 6),
      
                      Text(
                        c["description"],
                        style: TextStyle(color: Colors.grey[700]),
                      ),
      
                      const SizedBox(height: 10),
      
                      Text(
                        "Date: ${c["date"]}",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
  }
}
