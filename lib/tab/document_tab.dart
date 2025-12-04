import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Document {
  final int id;
  final String name;
  final String type;
  final String size;
  final String date;
  String status;
  final String icon;

  Document({
    required this.id,
    required this.name,
    required this.type,
    required this.size,
    required this.date,
    required this.status,
    required this.icon,
  });
}

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  // ---------------- Pakistani Document Types --------------------
  final List<Map<String, dynamic>> docTypes = [
    {"id": 1, "name": "CNIC", "icon": "🪪", "color": Color(0xff00D9FF)},
    {
      "id": 2,
      "name": "Rent Agreement",
      "icon": "📝",
      "color": Color(0xff0099CC),
    },
    {"id": 3, "name": "Utility Bill", "icon": "💡", "color": Color(0xffF1C40F)},
    {
      "id": 4,
      "name": "Maintenance Receipt",
      "icon": "🧾",
      "color": Color(0xff00D084),
    },
    {
      "id": 5,
      "name": "Tax Certificate (FBR)",
      "icon": "💰",
      "color": Color(0xffFF006E),
    },
    {"id": 6, "name": "Other", "icon": "📁", "color": Colors.grey},
  ];

  // ---------------- Mock Data --------------------
  List<Document> documents = [
    Document(
      id: 1,
      name: "CNIC Front",
      type: "CNIC",
      size: "1.1 MB",
      date: "Dec 22, 2024",
      status: "verified",
      icon: "🪪",
    ),
    Document(
      id: 2,
      name: "Rent Agreement 2024",
      type: "Rent Agreement",
      size: "1.8 MB",
      date: "Dec 17, 2024",
      status: "pending",
      icon: "📝",
    ),
    Document(
      id: 3,
      name: "K-Electric Bill",
      type: "Utility Bill",
      size: "900 KB",
      date: "Dec 10, 2024",
      status: "verified",
      icon: "💡",
    ),
    Document(
      id: 4,
      name: "Tax Certificate",
      type: "Tax Certificate (FBR)",
      size: "1.2 MB",
      date: "Nov 30, 2024",
      status: "rejected",
      icon: "💰",
    ),
  ];

  String filter = "all";
  Map<String, dynamic>? selectedType;
  bool uploading = false;

  // ---------------- Status Helpers --------------------
  Color getStatusColor(String status) {
    switch (status) {
      case "verified":
        return Colors.greenAccent;
      case "pending":
        return Colors.amber;
      case "rejected":
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  String getStatusEmoji(String status) {
    switch (status) {
      case "verified":
        return "✅";
      case "pending":
        return "⏳";
      case "rejected":
        return "❌";
      default:
        return "📄";
    }
  }

  // ---------------- Upload Document --------------------
  void uploadDoc() {
    if (selectedType == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Choose a document type")));
      return;
    }

    setState(() => uploading = true);

    Future.delayed(const Duration(seconds: 2), () {
      final newDoc = Document(
        id: documents.length + 1,
        name: "${selectedType!['name']} - New Upload",
        type: selectedType!['name'],
        size: "1.2 MB",
        date: "Today",
        status: "pending",
        icon: selectedType!['icon'],
      );

      documents.insert(0, newDoc);

      uploading = false;
      selectedType = null;

      Navigator.pop(context);
      setState(() {});
    });
  }

  // ---------------- Delete Document --------------------
  void deleteDoc(int id) {
    setState(() {
      documents.removeWhere((d) => d.id == id);
    });
  }

  // ---------------- Filter Logic --------------------
  List<Document> get filteredDocs {
    if (filter == "all") return documents;
    return documents.where((d) => d.status == filter).toList();
  }

  // ---------------- Bottom Sheet --------------------
  void openUploadSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff111111),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      isScrollControlled: true,
      builder: (_) => StatefulBuilder(
        builder: (context, modalSetState) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Upload Document",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Document Types Grid
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: docTypes.map((t) {
                  final active = selectedType?['id'] == t['id'];
                  return GestureDetector(
                    onTap: () {
                      modalSetState(() => selectedType = t);
                      setState(() {});
                    },
                    child: Container(
                      width: 95,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: active
                            ? Colors.teal.shade900
                            : const Color(0xff1A1A1A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: active
                              ? Colors.tealAccent
                              : Colors.grey.shade800,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(t['icon'], style: const TextStyle(fontSize: 28)),
                          const SizedBox(height: 6),
                          Text(
                            t['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Upload Button
              ElevatedButton(
                onPressed: uploading ? null : uploadDoc,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent.shade700,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: uploading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        "Upload Document",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- Document Card --------------------
  Widget buildDocCard(Document d) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Row
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.black,
                child: Text(d.icon, style: const TextStyle(fontSize: 22)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      d.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      d.type,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => deleteDoc(d.id),
                child: const Icon(Icons.delete, color: Colors.redAccent),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "📦 ${d.size}",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                "📅 ${d.date}",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: getStatusColor(d.status),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(getStatusEmoji(d.status)),
                    const SizedBox(width: 4),
                    Text(
                      d.status.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- Main UI --------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.black,
        onPressed: openUploadSheet,
        child: const Icon(Icons.upload),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Header
            Text(
              "My Documents",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Upload & manage your files",
              style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Filters
            Row(
              children: [
                filterButton("all", "All"),
                filterButton("verified", "Verified"),
                filterButton("pending", "Pending"),
                filterButton("rejected", "Rejected"),
              ],
            ),
            const SizedBox(height: 20),

            // Document List
            ...filteredDocs.map(buildDocCard),
          ],
        ),
      ),
    );
  }

  // ---------------- Filter Button Widget --------------------
  Widget filterButton(String key, String label) {
    final active = filter == key;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => filter = key),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.only(right: 6),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? Colors.teal.shade900 : Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: active ? Colors.tealAccent : Colors.grey.shade700,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: active ? Colors.tealAccent : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
