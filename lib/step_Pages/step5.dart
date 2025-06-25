import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/question_model.dart';
import '../services/api_service.dart';

class Step5 extends StatefulWidget {
  static String routeName = '/step5';

  @override
  State<Step5> createState() => _Step5State();
}

class _Step5State extends State<Step5> {
  String selectedSensitivity = '';
  List<Question> questions = [];
  bool isLoading = true;
  String errorMessage = '';

  final List<String> sensitivityOptions = [
    "Not Sensitive",
    "Very Sensitive",
    "Slightly Sensitive",
  ];

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    try {
      final fetchedQuestions = await ApiService.getAllQuestions();
      setState(() {
        questions = fetchedQuestions;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load questions: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  Future<void> _submitAnswer(String answer) async {
    try {
      const String userId = 'temp_user_id';

      final response = await ApiService.submitAnswers(
        userId: userId,
        answers: [
          {
            'questionId':
                questions.length > 1 ? questions[1].id : 'sensitivity_question',
            'answers': [answer],
          },
        ],
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sensitivity saved successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving sensitivity: ${e.toString()}')),
      );
    }
  }

  void _showConfirmationDialog(String option) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 18.5),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xffE4E7F1),
                borderRadius: BorderRadius.circular(43.0),
              ),
              child: Column(
                children: [
                  Text(
                    'Are you sure your skin sensitivity is "$option"?',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _submitAnswer(option);
                      print('User confirmed: $option');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1A766E),
                      fixedSize: const Size(189, 46),
                    ),
                    child: const Text(
                      'Sure',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          color: Color(0xff199A8E),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String option) {
    bool isSelected = selectedSensitivity == option;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSensitivity = option;
        });
        _showConfirmationDialog(option);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: const Color(0xff1A766E),
              size: 25,
            ),
            Expanded(
              child: Text(
                option,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff101623),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xff1A766E)),
        ),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            errorMessage,
            style: GoogleFonts.inter(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffE4E7F1),
                      Color.fromRGBO(245, 247, 255, 0),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 1),
                  Center(
                    child: Image.asset(
                      'assets/images/doc5.png',
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 318,
                    margin: const EdgeInsets.only(top: 0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xffE4E7F1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          questions.length > 1
                              ? questions[1].text
                              : "How sensitive is your skin?",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                child: _buildOption(sensitivityOptions[0])),
                            const SizedBox(width: 8),
                            Expanded(
                                child: _buildOption(sensitivityOptions[1])),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _buildOption(sensitivityOptions[2]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
