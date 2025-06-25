import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/question_model.dart';
import '../services/api_service.dart';

class Step6 extends StatefulWidget {
  static String routeName = '/step6';

  @override
  State<Step6> createState() => _Step6State();
}

class _Step6State extends State<Step6> {
  String selectedAnswer = '';
  List<Question> questions = [];
  bool isLoading = true;
  String errorMessage = '';
  bool isSubmitted = false;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    try {
      print('Fetching questions for Step6...');
      final fetchedQuestions = await ApiService.getAllQuestions();

      if (fetchedQuestions.isEmpty) {
        print('Warning: No questions received from API');
      } else {
        print('Successfully fetched ${fetchedQuestions.length} questions');
      }

      setState(() {
        questions = fetchedQuestions;
        isLoading = false;
        _logQuestions(); // تسجيل الأسئلة المستلمة
      });
    } catch (e) {
      print('Error fetching questions: $e');
      setState(() {
        errorMessage = 'Failed to load questions: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  void _logQuestions() {
    print('Available Questions:');
    for (var i = 0; i < questions.length; i++) {
      final q = questions[i];
      print('[$i] ${q.text} (ID: ${q.id})');
      print('   Answers: ${q.answers.map((a) => a.text).toList()}');
    }
  }

  Future<void> _submitAnswer(String answer) async {
    try {
      const String userId = 'temp_user_id'; // يجب استبدالها بـ userId الفعلي

      // البحث عن سؤال العوامل البيئية
      final environmentalQuestion = questions.firstWhere(
            (q) => q.text.toLowerCase().contains('environmental'),
        orElse: () => questions.isNotEmpty ? questions[0] : Question(
          id: 'default_env_question',
          text: "What environmental factors are you exposed to daily?",
          order: 3,
          isMultiple: true,
          answers: [
            Answer(id: '1', text: "Sun"),
            Answer(id: '2', text: "Pollution"),
            Answer(id: '3', text: "Indoor environments"),
          ],
          active: true,
        ),
      );

      print('Submitting answer for question: ${environmentalQuestion.text}');
      print('Selected answer: $answer');

      final response = await ApiService.submitAnswers(
        userId: userId,
        answers: [
          {
            'questionId': environmentalQuestion.id,
            'answers': [answer],
          },
        ],
      );

      if (response.statusCode == 201) {
        print('Answer submitted successfully!');
        setState(() => isSubmitted = true);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Answer submitted successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        throw Exception('Server responded with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error submitting answer: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit answer. Please try again.'),
          duration: Duration(seconds: 2),
        ),
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(43.0),
              ),
              child: Column(
                children: [
                  Text(
                    'Are you sure your environmental factors you exposed daily is "$option"?',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _submitAnswer(option);
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
    bool isSelected = selectedAnswer == option;
    return GestureDetector(
      onTap: () {
        if (!isSubmitted) {
          setState(() => selectedAnswer = option);
          _showConfirmationDialog(option);
        }
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
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                option,
                style: GoogleFonts.inter(
                  fontSize: 20,
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

  List<Widget> _buildQuestionOptions() {
    try {
      // البحث عن سؤال العوامل البيئية
      final environmentalQuestion = questions.firstWhere(
            (q) => q.text.toLowerCase().contains('environmental'),
        orElse: () => questions.isNotEmpty ? questions[0] : Question(
          id: 'default_env_question',
          text: "What environmental factors are you exposed to daily?",
          order: 3,
          isMultiple: true,
          answers: [
            Answer(id: '1', text: "Sun"),
            Answer(id: '2', text: "Pollution"),
            Answer(id: '3', text: "Indoor environments"),
          ],
          active: true,
        ),
      );

      return environmentalQuestion.answers.map((answer) {
        return _buildOption(answer.text);
      }).toList();
    } catch (e) {
      print('Error building options: $e');
      // Fallback options
      return [
        _buildOption("Sun"),
        _buildOption("Pollution"),
        _buildOption("Indoor environments"),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Color(0xff1A766E)),
              SizedBox(height: 20),
              Text(
                'Loading questions...',
                style: GoogleFonts.inter(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              errorMessage,
              style: GoogleFonts.inter(fontSize: 18, color: Colors.red),
              textAlign: TextAlign.center,
            ),
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
                          "What environmental factors are you exposed to daily?",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ..._buildQuestionOptions(),
                        if (isSubmitted) ...[
                          SizedBox(height: 20),
                          Text(
                            'Answer submitted successfully!',
                            style: GoogleFonts.inter(
                              color: Color(0xff1A766E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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