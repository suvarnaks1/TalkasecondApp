import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';

class PaymentScreen extends StatefulWidget {
  final double amount;
  const PaymentScreen({super.key, required this.amount});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedMethod;
  bool isPaymentSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueBackground,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text("Payment", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isPaymentSuccess
            ? _buildSuccessView(context)
            : _buildPaymentForm(context),
      ),
    );
  }

  Widget _buildPaymentForm(BuildContext context) {
    final methods = ["UPI", "Card", "Netbanking", "Wallet"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Payment Method",
            style: TextStyle(
                color: AppColors.myDarkColor,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...methods.map((m) => RadioListTile(
              activeColor: AppColors.backgroundColor,
              title: Text(m),
              value: m,
              groupValue: selectedMethod,
              onChanged: (val) => setState(() => selectedMethod = val),
            )),
        const SizedBox(height: 20),
        Text("Amount to Pay: ₹${widget.amount.toStringAsFixed(0)}",
            style: TextStyle(
                color: AppColors.myDarkColor,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.backgroundColor),
                ),
                child: const Text("Cancel"),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: selectedMethod == null
                    ? null
                    : () async {
                        // simulate payment
                        await Future.delayed(const Duration(seconds: 2));
                        setState(() => isPaymentSuccess = true);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Pay Now",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 90),
          const SizedBox(height: 20),
          Text(
            "Payment successful — your appointment is confirmed.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.myDarkColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to Dashboard or summary
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.backgroundColor),
            child: const Text("Go to Dashboard",
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
