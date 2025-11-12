import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'package:demotalkasecond/views/client_app/home_screen.dart';
import 'package:demotalkasecond/views/consultant/Dashboard.dart';

class DemoLogin extends StatefulWidget {
  const DemoLogin({Key? key}) : super(key: key);
  @override
  _DemoLoginState createState() => _DemoLoginState();
}

class _DemoLoginState extends State<DemoLogin> {
  final _formKey = GlobalKey<FormState>();
  String? _fullName;
  String? _selectedNationality;
  String? _selectedRole;
  String _countryCode = '+1';
  String _mobileNumber = '';
  bool _agreed = false;

  final List<Map<String, String>> _nationalities = [
    {'label': 'United States', 'code': '+1', 'currency': 'USD'},
    {'label': 'India',          'code': '+91','currency': 'INR'},
    {'label': 'United Kingdom', 'code': '+44','currency': 'GBP'},
  ];

  final List<String> _roles = [
    'Patients',
    'Psychologists',
    'Dieticians',
    'Webinar',
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
          nextScreen = const ClientHomeScreen();
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
    const Color headerGreen = Color(0xFF2E554F);
    const Color inputFill = Colors.white;
    const Color borderGray = Color(0xFFB0B0B0);
    const Color buttonGreen = Color(0xFF2E554F);

    return Scaffold(
      backgroundColor: headerGreen,
      body: Stack(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: headerGreen,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 120, left: 16, right: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const SizedBox(height: 8),
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Enter your details and login your own',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 24),

                        // Full Name Field (required)
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Full Name',
                            fillColor: inputFill,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: borderGray),
                            ),
                          ),
                          validator: (val) => val == null || val.trim().isEmpty
                              ? 'Full name is required'
                              : null,
                          onSaved: (val) => _fullName = val?.trim(),
                        ),
                        const SizedBox(height: 16),

                        // Nationality Dropdown
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: inputFill,
                            labelText: 'Nationality',
                            labelStyle: TextStyle(color: headerGreen),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: borderGray),
                            ),
                          ),
                          dropdownColor: Colors.white,
                          style: const TextStyle(color: Colors.black),
                          isExpanded: true,
                          value: _selectedNationality,
                          items: _nationalities.map((item) {
                            return DropdownMenuItem<String>(
                              value: item['label'],
                              child: Text(item['label']!),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedNationality = value;
                              final selected = _nationalities.firstWhere(
                                (item) => item['label'] == value,
                              );
                              _countryCode = selected['code']!;
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Please select nationality' : null,
                        ),
                        const SizedBox(height: 16),

                        // Phone number row
                        Row(
                          children: [
                            Container(
                              width: 100,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: inputFill,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: borderGray),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    _countryCode,
                                    style: TextStyle(color: headerGreen),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.arrow_drop_down, color: headerGreen),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Mobile Number',
                                  fillColor: inputFill,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: borderGray),
                                  ),
                                ),
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
                        const SizedBox(height: 16),

                        // Role Dropdown
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: inputFill,
                            labelText: 'Role',
                            labelStyle: TextStyle(color: headerGreen),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: borderGray),
                            ),
                          ),
                          dropdownColor: Colors.white,
                          style: const TextStyle(color: Colors.black),
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
                        const SizedBox(height: 16),

                        // Terms/Checkbox
                        CheckboxListTile(
                          value: _agreed,
                          onChanged: (val) {
                            setState(() {
                              _agreed = val ?? false;
                            });
                          },
                          title: Text(
                            'I have read and agree',
                            style: TextStyle(color: headerGreen),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: buttonGreen,
                        ),
                        const SizedBox(height: 24),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _isButtonEnabled ? buttonGreen : borderGray,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: _isButtonEnabled ? _onSubmit : null,
                          child: const Text(
                            'Agree & Continue',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Dummy classes for completeness
class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Admin Dashboard')));
  }
}

