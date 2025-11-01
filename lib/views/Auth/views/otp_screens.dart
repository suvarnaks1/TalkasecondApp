import 'dart:async';
import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'package:demotalkasecond/core/firebase/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String verificationId;
  final String fullName;
  final String nationality;
  
  const OtpScreen({
    Key? key, 
    required this.mobileNumber,
    required this.fullName,
    required this.nationality,
    required this.verificationId, int? forceResendingToken,
  }) : super(key: key);

  static const String routeName = '/otp';

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isResendEnabled = false;
  bool _isLoading = false;
  String _timerText = 'Resend in 30 sec';
  Timer? _timer;
  int _remainingSeconds = 30;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _otpController.addListener(() {
      setState(() {
        _isButtonEnabled = _otpController.text.trim().length >= 6; // Changed to 6 for typical OTP length
      });
    });
  }

  void _startTimer() {
    _remainingSeconds = 30;
    _isResendEnabled = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_remainingSeconds == 0) {
        setState(() {
          _isResendEnabled = true;
          _timerText = 'Resend OTP';
        });
        timer.cancel();
      } else {
        setState(() {
          _remainingSeconds--;
          _timerText = 'Resend in $_remainingSeconds sec';
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _onResendOtp() {
    if (!_isResendEnabled) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Trigger resend OTP logic
    _resendVerificationCode();
  }

  Future<void> _resendVerificationCode() async {
    try {
      await FirebaseAuthService.verifyPhoneNumber(
        phoneNumber: widget.mobileNumber,
        onCodeSent: (String verificationId, int? forceResendingToken) {
          setState(() {
            _isLoading = false;
          });
          _startTimer();
          // You can show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('OTP resent successfully'),
              backgroundColor: Colors.green,
            ),
          );
        },
        onVerificationFailed: (FirebaseAuthException error) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Failed to resend OTP: ${error.message}';
          });
        },
        onVerificationCompleted: (PhoneAuthCredential credential) async {
          // Auto verification if SMS is automatically retrieved
          try {
            await FirebaseAuthService.signInWithVerificationCode(
              verificationId: credential.verificationId ?? '',
              smsCode: credential.smsCode ?? '',
            );
            _navigateToNextScreen();
          } catch (e) {
            setState(() {
              _isLoading = false;
              _errorMessage = 'Auto-verification failed';
            });
          }
        },
        onCodeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to resend OTP';
      });
    }
  }

  Future<void> _onVerify() async {
    if (!_isButtonEnabled || _isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final otp = _otpController.text.trim();
      
      // Verify OTP with Firebase
      await FirebaseAuthService.signInWithVerificationCode(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      // Success - Navigate to next screen
      _navigateToNextScreen();
      
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = _getErrorMessage(e.code);
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Verification failed. Please try again.';
      });
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-verification-code':
        return 'Invalid OTP. Please check and try again.';
      case 'session-expired':
        return 'OTP session expired. Please request a new OTP.';
      case 'quota-exceeded':
        return 'Too many attempts. Please try again later.';
      default:
        return 'Verification failed. Please try again.';
    }
  }

  void _navigateToNextScreen() {
    // Navigate to language selection or home screen
    Navigator.of(context).pushReplacementNamed('/languageSelection');
    
    // If you want to pass user data to next screen, you can use:
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => LanguageSelectionScreen(
    //       fullName: widget.fullName,
    //       nationality: widget.nationality,
    //       phoneNumber: widget.mobileNumber,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Center(
          child: Text(
            'Verify Mobile',
            style: TextStyle(color: AppColors.colorwhite),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              'Enter the OTP sent to ${widget.mobileNumber}',
              style: TextStyle(color: AppColors.colorwhite, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // OTP Input Field
            TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: AppColors.colorwhite, fontSize: 24),
              maxLength: 6,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.myDarkColor.withOpacity(0.1),
                hintText: 'Enter 6-digit OTP',
                hintStyle: TextStyle(color: AppColors.midGray),
                labelText: 'OTP',
                labelStyle: TextStyle(color: AppColors.colorwhite),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: AppColors.colorwhite),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: AppColors.accentColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            
            if (_errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.redAccent),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            
            // Verify Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isButtonEnabled && !_isLoading
                      ? AppColors.accentColor
                      : AppColors.midGray,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _isButtonEnabled && !_isLoading ? _onVerify : null,
                child: _isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorwhite),
                        ),
                      )
                    : Text(
                        'Verify',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
              ),
            ),
            const Spacer(),
            
            // Resend OTP Button
            TextButton(
              onPressed: _isResendEnabled && !_isLoading ? _onResendOtp : null,
              child: _isLoading && _isResendEnabled
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
                      ),
                    )
                  : Text(
                      _timerText,
                      style: TextStyle(
                        color: _isResendEnabled
                            ? AppColors.accentColor
                            : AppColors.midGray,
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              'OTP expired — resend?',
              style: TextStyle(color: AppColors.colorwhite.withOpacity(0.6)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}