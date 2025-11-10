import 'package:demotalkasecond/views/Psychologist/PsychologistHomeScreen.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import 'package:demotalkasecond/views/client_app/home_screen.dart';

class DemoLogin extends StatefulWidget {
  const DemoLogin({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<DemoLogin> {
  final _formKey = GlobalKey<FormState>();
  String? _fullName;
  String? _selectedNationality;
  String? _selectedRole;
  String _countryCode = '+1';
  String _mobileNumber = '';
  bool _agreed = false;

  final List<Map<String, String>> _nationalities = [
    {'label': 'United States', 'code': '+1', 'currency': 'USD'},
    {'label': 'India',        'code': '+91','currency': 'INR'},
    {'label': 'United Kingdom','code': '+44','currency': 'GBP'},
  ];

  final List<String> _roles = [
    'Patients',
    'Psychologists',
    'Psychiatrists',
    'Dieticians',
    'Physicians',
    'Trainers',
    'Department Heads',
    'Technical / Support Team',
    'Director',
  ];

  bool get _isButtonEnabled {
    return _agreed &&
        (_formKey.currentState?.validate() ?? false) &&
        _selectedNationality != null &&
        _mobileNumber.trim().isNotEmpty &&
        _selectedRole != null;
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Widget nextScreen;

      switch (_selectedRole) {
        case 'Patients':
          nextScreen = ClientHomeScreen();
          break;
        case 'Psychologists':
        case 'Psychiatrists':
        case 'Dieticians':
        case 'Physicians':
        case 'Trainers':
          nextScreen = PsychologistDashboard();
          break;
        case 'Department Heads':
        case 'Technical / Support Team':
        case 'Director':
          nextScreen = const AdminDashboard();
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid role selected')),
          );
          return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nextScreen),
      );
    }
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
                // Full Name Field
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
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                  onSaved: (value) => _fullName = value,
                ),
                const SizedBox(height: 16),
                // Nationality Dropdown
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
                  isExpanded: true,
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
                  validator: (value) =>
                      value == null ? 'Please select nationality' : null,
                ),
                const SizedBox(height: 16),
                // Phone Number Row
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
                          Icon(Icons.arrow_drop_down,
                              color: AppColors.colorwhite),
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
                          if (value.trim().length < 8) {
                            return 'Enter a valid mobile number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _mobileNumber = value.trim();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Role Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.myDarkColor.withOpacity(0.1),
                    labelText: 'Role',
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
                  isExpanded: true,
                  value: _selectedRole,
                  items: _roles.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select role' : null,
                ),
                const SizedBox(height: 24),
                // Disclaimer
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.lightPeach,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: Text(
                      'Disclaimer: Please read and agree to the terms and conditions before proceeding.',
                      style: TextStyle(color: AppColors.midGray),
                    ),
                  ),
                ),
                // Checkbox
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
                // Continue Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled
                        ? AppColors.accentColor
                        : AppColors.midGray,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _isButtonEnabled ? _onSubmit : null,
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

// Assuming these are somewhere in your code
class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Admin Dashboard')),
    );
  }
}

class ConsultantDashboard extends StatelessWidget {
  const ConsultantDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Consultant Dashboard')),
    );
  }
}
