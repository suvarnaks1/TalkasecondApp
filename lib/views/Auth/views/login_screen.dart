import 'package:demotalkasecond/core/firebase/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demotalkasecond/views/Auth/views/otp_screens.dart';
import '../../../core/utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _fullName;
  String? _selectedNationality;
  String _countryCode = '+1';
  String _mobileNumber = '';
  bool _agreed = false;
  bool _isLoading = false;

  final List<Map<String, String>> _nationalities = [
    {'label': 'United States', 'code': '+1', 'currency': 'USD'},
    {'label': 'India', 'code': '+91', 'currency': 'INR'},
    {'label': 'United Kingdom', 'code': '+44', 'currency': 'GBP'},
  ];

  bool get _isButtonEnabled {
    return _agreed &&
        (_formKey.currentState?.validate() ?? false) &&
        _selectedNationality != null &&
        _mobileNumber.trim().isNotEmpty &&
        !_isLoading;
  }

  Future<void> _verifyPhoneNumber() async {
    if (!_isButtonEnabled) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final String completePhoneNumber = '$_countryCode$_mobileNumber';
      print('Attempting to verify: $completePhoneNumber'); // Debug

      await FirebaseAuthService.verifyPhoneNumber(
        phoneNumber: completePhoneNumber,
        onCodeSent: (String verificationId, int? forceResendingToken) {
          setState(() {
            _isLoading = false;
          });
          print('Code sent successfully. Verification ID: $verificationId'); // Debug
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                mobileNumber: completePhoneNumber,
                verificationId: verificationId,
                fullName: _fullName ?? '',
                nationality: _selectedNationality ?? '',
              ),
            ),
          );
        },
        onVerificationFailed: (FirebaseAuthException error) {
          setState(() {
            _isLoading = false;
          });
          print('Verification failed: ${error.code} - ${error.message}'); // Debug
          _showErrorDialog('Verification Failed', 'Error: ${error.code}\n${error.message}');
        },
        onVerificationCompleted: (PhoneAuthCredential credential) async {
          print('Auto verification completed'); // Debug
          try {
            await FirebaseAuthService.signInWithVerificationCode(
              verificationId: credential.verificationId ?? '',
              smsCode: credential.smsCode ?? '',
            );
          } catch (e) {
            print('Auto verification error: $e'); // Debug
          }
        },
        onCodeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _isLoading = false;
          });
          print('Code auto retrieval timed out'); // Debug
        },
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('General error: $e'); // Debug
      _showErrorDialog('Error', e.toString());
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
                    filled: true,
                    fillColor: AppColors.myDarkColor.withOpacity(0.1),
                    labelText: 'Full Name',
                    labelStyle: TextStyle(color: AppColors.colorwhite),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: AppColors.colorwhite),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
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
                    filled: true,
                    fillColor: AppColors.myDarkColor.withOpacity(0.1),
                    labelText: 'Nationality',
                    labelStyle: TextStyle(color: AppColors.colorwhite),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: AppColors.colorwhite),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: AppColors.accentColor),
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
                        orElse: () => _nationalities.first,
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
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.myDarkColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.colorwhite),
                      ),
                      child: Row(
                        children: [
                          Text(
                            _countryCode,
                            style: TextStyle(color: AppColors.colorwhite),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.arrow_drop_down, color: AppColors.colorwhite),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.myDarkColor.withOpacity(0.1),
                          labelText: 'Mobile Number',
                          labelStyle: TextStyle(color: AppColors.colorwhite),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: AppColors.colorwhite),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: AppColors.accentColor),
                          ),
                        ),
                        style: TextStyle(color: AppColors.colorwhite),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Mobile number is required';
                          }
                          if (value.length < 8) {
                            return 'Please enter valid mobile number';
                          }
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
                      'Disclaimer: Please read and agree to the terms and conditions before proceeding. By clicking Agree & Continue you accept that your currency will be set based on your selected nationality. Changing nationality later will show "Currency will change for new bookings only."',
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
                  onPressed: _isButtonEnabled ? _verifyPhoneNumber : null,
                  child: _isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorwhite),
                          ),
                        )
                      : const Text(
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