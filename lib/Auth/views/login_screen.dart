import 'package:demotalkasecond/Auth/views/otp_screens.dart';
import 'package:demotalkasecond/common/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _fullName;
  String? _selectedNationality;
  String _countryCode = '+1'; // default
  String _mobileNumber = '';
  bool _agreed = false;

  // Example list for nationality dropdown
  final List<Map<String, String>> _nationalities = [
    {'label': 'United States', 'code': '+1', 'currency': 'USD'},
    {'label': 'India', 'code': '+91', 'currency': 'INR'},
    {'label': 'United Kingdom', 'code': '+44', 'currency': 'GBP'},
    // add more as needed
  ];

  bool get _isButtonEnabled {
    return _agreed &&
        (_formKey.currentState?.validate() ?? false) &&
        _selectedNationality != null &&
        _mobileNumber.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 24),
                Text(
                  'Welcome',
                  style: TextStyle(
                    color: AppColors.colorwhite,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: TextStyle(color: AppColors.colorwhite),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.colorwhite),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.accentColor),
                    ),
                  ),
                  style: TextStyle(color: AppColors.colorwhite),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Full name is required';
                    }
                    return null;
                  },
                  onSaved: (value) => _fullName = value,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Nationality',
                    labelStyle: TextStyle(color: AppColors.colorwhite),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.colorwhite),
                    ),
                  ),
                  dropdownColor: AppColors.backgroundColor,
                  style: TextStyle(color: AppColors.colorwhite),
                  value: _selectedNationality,
                  items: _nationalities.map((item) {
                    return DropdownMenuItem<String>(
                      value: item['label'],
                      child: Text(item['label'] ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedNationality = value;
                      final selected = _nationalities.firstWhere(
                        (item) => item['label'] == value,
                      );
                      _countryCode = selected['code'] ?? _countryCode;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select nationality';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Row(
                        children: [
                          // Placeholder for flag icon
                          // You’d ideally use a package like country_code_picker
                          Text(
                            _countryCode,
                            style: TextStyle(color: AppColors.colorwhite),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.colorwhite,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          labelStyle: TextStyle(color: AppColors.colorwhite),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.colorwhite),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.accentColor,
                            ),
                          ),
                        ),
                        style: TextStyle(color: AppColors.colorwhite),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Mobile number is required';
                          }
                          // You can add more validation rules for phone format
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _mobileNumber = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.lightPeach,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: Text(
                      'Disclaimer: Please read and agree to the terms and conditions before proceeding. By clicking Agree & Continue you accept that your currency will be set based on your selected nationality. Changing nationality later will show “Currency will change for new bookings only.”',
                      style: TextStyle(color: AppColors.midGray),
                    ),
                  ),
                ),
                CheckboxListTile(
                  value: _agreed,
                  onChanged: (val) {
                    setState(() {
                      _agreed = val ?? false;
                    });
                  },
                  title: Text(
                    'I have read and agree',
                    style: TextStyle(color: AppColors.colorwhite),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: AppColors.accentColor,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled
                        ? AppColors.accentColor
                        : AppColors.midGray,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _isButtonEnabled
                      ? () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            // Navigate to OTP or next screen
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) =>
                                    OtpScreen(mobileNumber: ''),
                              ),
                            );
                          }
                        }
                      : null,
                  child: const Text(
                    'Agree & Continue',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
