import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'payment_screen.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> doctorData; // psychologist or dietician data
  const BookingScreen({super.key, required this.doctorData});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String sessionType = "Single Session";
  String mode = "Video";
  DateTime? selectedDate;
  String? selectedTimeSlot;
  TextEditingController promoController = TextEditingController();

  final List<String> timeSlots = [
    "9:00 AM", "10:00 AM", "11:00 AM",
    "2:00 PM", "3:00 PM", "4:00 PM", "6:00 PM"
  ];

  final List<Map<String, dynamic>> packages = [
    {"name": "Single Session", "price": 800, "sessions": 1, "validity": "1 Day"},
    {"name": "5-Session Package", "price": 3500, "sessions": 5, "validity": "1 Month"},
    {"name": "10-Session Package", "price": 6000, "sessions": 10, "validity": "3 Months"},
  ];

  @override
  Widget build(BuildContext context) {
    final doc = widget.doctorData;
    final double taxRate = 0.18;
    final double sessionPrice = packages.firstWhere(
      (pkg) => pkg["name"] == sessionType,
      orElse: () => packages[0],
    )["price"].toDouble();
    final double finalAmount = sessionPrice + (sessionPrice * taxRate);

    return Scaffold(
      backgroundColor: AppColors.lightBlueBackground,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text("Book Appointment", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 1️⃣ Psychologist Profile Mini Bar
            _buildProfileBar(doc),

            const SizedBox(height: 20),

            /// 2️⃣ Session Type
            Text("Select Session Type",
                style: TextStyle(
                    color: AppColors.myDarkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            _buildSessionOptions(),

            const SizedBox(height: 20),

            /// 3️⃣ Mode Selection
            Text("Select Mode",
                style: TextStyle(
                    color: AppColors.myDarkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            Row(
              children: ["Video", "Voice", "Chat"].map((m) {
                return Expanded(
                  child: RadioListTile(
                    activeColor: AppColors.backgroundColor,
                    title: Text(m),
                    value: m,
                    groupValue: mode,
                    onChanged: (val) => setState(() => mode = val!),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            /// 4️⃣ Date & Time Picker
            Text("Select Date & Time",
                style: TextStyle(
                    color: AppColors.myDarkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            _buildDatePicker(context),
            const SizedBox(height: 12),
            _buildTimeSlots(),

            const SizedBox(height: 20),

            /// 5️⃣ Price Summary
            _buildPriceSummary(sessionPrice, taxRate, finalAmount),

            const SizedBox(height: 30),

            /// 6️⃣ Book Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (selectedDate != null && selectedTimeSlot != null)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PaymentScreen(amount: finalAmount),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  "Book & Pay",
                  style: TextStyle(
                    color: AppColors.colorwhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileBar(Map<String, dynamic> doc) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightPeach,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.midGray.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 30, backgroundImage: NetworkImage(doc["photo"])),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doc["name"],
                    style: TextStyle(
                        color: AppColors.myDarkColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                Text("${doc["experience"]} experience",
                    style: TextStyle(color: AppColors.midGray)),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(" ${doc["rating"]}",
                        style: TextStyle(color: AppColors.midGray)),
                  ],
                ),
              ],
            ),
          ),
          Text("₹800/session",
              style: TextStyle(
                  color: AppColors.myDarkColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildSessionOptions() {
    return Column(
      children: packages.map((pkg) {
        final selected = sessionType == pkg["name"];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            onTap: () => setState(() => sessionType = pkg["name"]),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: selected ? AppColors.accentColor : AppColors.colorwhite,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.midGray.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(2, 3))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(pkg["name"],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.myDarkColor)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("₹${pkg["price"]}",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.myDarkColor,
                              fontWeight: FontWeight.bold)),
                      Text("${pkg["sessions"]} Sessions • ${pkg["validity"]}",
                          style: TextStyle(color: AppColors.midGray)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now().add(const Duration(days: 1)),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 60)),
        );
        if (picked != null) {
          setState(() => selectedDate = picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.colorwhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate == null
                  ? "Select Date"
                  : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              style: TextStyle(color: AppColors.myDarkColor, fontSize: 16),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlots() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: timeSlots.map((slot) {
        bool isSelected = slot == selectedTimeSlot;
        bool isDisabled = slot == "3:00 PM"; // example disabled
        return ChoiceChip(
          label: Text(slot),
          selected: isSelected,
          onSelected: isDisabled
              ? null
              : (val) {
                  if (val) setState(() => selectedTimeSlot = slot);
                },
          backgroundColor:
              isDisabled ? Colors.grey[300] : AppColors.colorwhite,
          selectedColor: AppColors.accentColor,
          labelStyle: TextStyle(
              color: AppColors.myDarkColor, fontWeight: FontWeight.w600),
        );
      }).toList(),
    );
  }

  Widget _buildPriceSummary(double sessionPrice, double taxRate, double finalAmount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightPeach,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price Summary",
              style: TextStyle(
                  color: AppColors.myDarkColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18)),
          const SizedBox(height: 10),
          _priceRow("Session Price", "₹${sessionPrice.toStringAsFixed(0)}"),
          _priceRow("Taxes (18%)", "₹${(sessionPrice * taxRate).toStringAsFixed(0)}"),
          const SizedBox(height: 8),
          TextField(
            controller: promoController,
            decoration: InputDecoration(
              hintText: "Enter promo code",
              filled: true,
              fillColor: AppColors.colorwhite,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              suffixIcon: TextButton(
                onPressed: () {},
                child: const Text("Apply"),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Divider(color: AppColors.midGray),
          _priceRow("Final Amount", "₹${finalAmount.toStringAsFixed(0)}",
              bold: true),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: AppColors.myDarkColor,
                  fontWeight: bold ? FontWeight.bold : FontWeight.w400)),
          Text(value,
              style: TextStyle(
                  color: AppColors.myDarkColor,
                  fontWeight: bold ? FontWeight.bold : FontWeight.w400)),
        ],
      ),
    );
  }
}
