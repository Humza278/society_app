import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UtilityService extends StatefulWidget {
  const UtilityService({super.key});

  @override
  State<UtilityService> createState() => _UtilityServiceState();
}

class _UtilityServiceState extends State<UtilityService> {
  final _formKey = GlobalKey<FormState>();

  String? selectedService;
  String? description;
  String? attachmentFileName;

  final List<String> _services = [
    "Electric Issue",
    "Water Supply Issue",
    "Internet Issue",
    "Maintenance Request",
    "Other Service",
  ];

  Future<void> pickAttachment() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        attachmentFileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),

        child: Scaffold(
          backgroundColor: Colors.blue[200],

          body: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        "Utility Services",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Top Image
                Image.asset(
                  "lib/images/maintenance.png",
                  width: 250,
                  height: 150,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 25),

                // Main White Panel
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),

                    child: Container(
                      padding: const EdgeInsets.all(25),
                      color: Colors.white,

                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Service Request",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Icon(Icons.more_horiz),
                                ],
                              ),
                              const SizedBox(height: 25),

                              // Service Dropdown
                              Text(
                                "Service Needed",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 8),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  hint: const Text("Select service"),
                                  value: selectedService,

                                  items: _services.map((service) {
                                    return DropdownMenuItem(
                                      value: service,
                                      child: Text(service),
                                    );
                                  }).toList(),

                                  validator: (value) => value == null
                                      ? "Please select a service"
                                      : null,

                                  onChanged: (value) {
                                    setState(() {
                                      selectedService = value;
                                    });
                                  },
                                ),
                              ),

                              const SizedBox(height: 22),

                              // Description Field
                              Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 8),

                              TextFormField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: "Describe your issue...",
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                validator: (value) => value!.isEmpty
                                    ? "Please enter description"
                                    : null,
                                onChanged: (value) => description = value,
                              ),

                              const SizedBox(height: 22),

                              // Attachment Row
                              Text(
                                "Attachment (Optional)",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 8),

                              GestureDetector(
                                onTap: pickAttachment,
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.attach_file,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          attachmentFileName ?? "Choose a file",
                                          style: TextStyle(
                                            color: attachmentFileName == null
                                                ? Colors.grey
                                                : Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 30),

                              // Submit Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // Perform submit
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Service request submitted!",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: Colors.blue[700],
                                  ),
                                  child: const Text(
                                    "Submit Request",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
