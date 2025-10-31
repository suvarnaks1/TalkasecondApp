import 'dart:async';
import 'package:demotalkasecond/common/colors.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  const OtpScreen({Key? key, required this.mobileNumber}) : super(key: key);

  static const String routeName = '/otp';

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isResendEnabled = false;
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
        _isButtonEnabled = _otpController.text.trim().length >= 4;
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
    // TODO: Trigger resend OTP logic
    _startTimer();
    setState(() {
      _errorMessage = null;
    });
  }

  void _onVerify() {
    // TODO: Trigger verify OTP logic
    final otp = _otpController.text.trim();
    if (otp != '1234') { // placeholder check
      setState(() {
        _errorMessage = 'Invalid OTP. Try again.';
      });
      return;
    }
    // on success → navigate to language selection
    Navigator.of(context).pushReplacementNamed('/languageSelection');
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
            TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: AppColors.colorwhite, fontSize: 24),
              maxLength: 6,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.myDarkColor.withOpacity(0.1),
                hintText: '••••',
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
              ),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isButtonEnabled ? AppColors.accentColor : AppColors.midGray,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
              ),
              onPressed: _isButtonEnabled ? _onVerify : null,
              child: const Text(
                'Verify',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: _isResendEnabled ? _onResendOtp : null,
              child: Text(
                _timerText,
                style: TextStyle(
                  color: _isResendEnabled ? AppColors.accentColor : AppColors.midGray,
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
