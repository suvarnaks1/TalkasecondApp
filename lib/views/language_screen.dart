import 'package:demotalkasecond/common/colors.dart';
import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedLanguage;

  final List<Map<String, String>> _languages = [
    {'label': 'English', 'code': 'en'},
    {'label': 'Malayalam', 'code': 'ma'},
    {'label': 'हिन्दी', 'code': 'hi'},
    {'label': 'Español', 'code': 'es'},
    {'label': 'Français', 'code': 'fr'},
    {'label': 'Deutsch', 'code': 'de'},
    {'label': 'Português', 'code': 'pt'},
    {'label': '中文 (简体)', 'code': 'zh'},
    {'label': 'اردو', 'code': 'ur'},
    {'label': 'বাংলা', 'code': 'bn'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
    
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                'Select Your Language',
                style: TextStyle(
                  color: AppColors.colorwhite,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: _languages.map((lang) {
                    final isSelected = _selectedLanguage == lang['code'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLanguage = lang['code'];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.accentColor
                              : AppColors.colorwhite,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.accentColor
                                : AppColors.midGray,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            lang['label'] ?? '',
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.colorwhite
                                  : AppColors.myDarkColor,
                              fontSize: 18,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedLanguage != null
                      ? AppColors.accentColor
                      : AppColors.midGray,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 48,
                  ),
                ),
                onPressed: _selectedLanguage != null
                    ? () {
                        // TODO: Save selected language in preferences
                        // and navigate to next screen
                      }
                    : null,
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
