import 'package:demotalkasecond/views/demo/demo_login.dart';
import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'package:demotalkasecond/views/client_app/home_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedLanguageCode;

  final List<Map<String, String>> _languages = [
    {'label': 'English', 'code': 'en', 'flag': '🇺🇸'},
    {'label': 'Malayalam', 'code': 'ml', 'flag': '🇮🇳'},
    {'label': 'हिन्दी', 'code': 'hi', 'flag': '🇮🇳'},
    {'label': 'Español', 'code': 'es', 'flag': '🇪🇸'},
    {'label': 'Français', 'code': 'fr', 'flag': '🇫🇷'},
    {'label': 'Deutsch', 'code': 'de', 'flag': '🇩🇪'},
    {'label': 'Português', 'code': 'pt', 'flag': '🇵🇹'},
    {'label': '中文 (简体)', 'code': 'zh', 'flag': '🇨🇳'},
    {'label': 'اردو', 'code': 'ur', 'flag': '🇵🇰'},
    {'label': 'বাংলা', 'code': 'bn', 'flag': '🇧🇩'},
  ];

  void _onLanguageTap(String code) {
    setState(() {
      _selectedLanguageCode = code;
    });
  }

  void _onContinue() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => DemoLogin()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: const Text(
          "Select Language",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                  children: _languages.map((lang) {
                    final bool isSelected = _selectedLanguageCode == lang['code'];
                    return GestureDetector(
                      onTap: () => _onLanguageTap(lang['code']!),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.accentColor : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected ? AppColors.colorwhite : AppColors.midGray,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              lang['flag']!,
                              style: const TextStyle(fontSize: 28),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              lang['label']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected ? Colors.white : AppColors.myDarkColor,
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedLanguageCode != null
                      ? AppColors.accentColor
                      : AppColors.midGray,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _selectedLanguageCode != null ? _onContinue : null,
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
