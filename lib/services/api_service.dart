import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/question_model.dart';

class ApiService {
  // يمكنك التبديل بين هذا (للباك إند المنشور) أو localhost (للتطوير المحلي)
  static const String baseUrl = "https://derma-vision-taupe.vercel.app/api/v1";

  // static const String baseUrl = "http://localhost:8080/api/v1"; // استخدم هذا للاختبار المحلي على الويب/محاكي iOS
  // static const String baseUrl = "http://10.0.2.2:8080/api/v1"; // استخدم هذا للاختبار المحلي على محاكي Android
  // static const String baseUrl = "http://YOUR_LOCAL_IP_ADDRESS:8080/api/v1"; // استخدم هذا للاختبار على جهاز Android/iOS حقيقي

  // Signup
  static Future<http.Response> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
          "confirmPassword": confirmPassword,
        }),
      );
      print('Signup response status: ${response.statusCode}');
      print('Signup response body: ${response.body}');
      return response;
    } catch (e) {
      print('Failed to signup: $e');
      throw Exception('Failed to signup: $e');
    }
  }


  // Login
  static Future<http.Response> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      print('Login response status: ${response.statusCode}');
      print('Login response body: ${response.body}');
      return response;
    } catch (e) {
      print('Failed to login: $e');
      throw Exception('Failed to login: $e');
    }
  }

  // Forgot Password by Email (طلب إرسال الكود)
  static Future<http.Response> forgotPasswordEmail({
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/forgetPassword'),
        // تأكد من هذا الـ endpoint في الباك إند
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
        }),
      );
      print('Forgot Password Email response status: ${response.statusCode}');
      print('Forgot Password Email response body: ${response.body}');
      return response;
    } catch (e) {
      print('Failed to request password reset via email: $e');
      throw Exception('Failed to request password reset via email: $e');
    }
  }

  // Verify Reset Code (التحقق من الكود المرسل للإيميل)
  static Future<http.Response> verifyResetCode({
    required String email,
    required String resetCode,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/verifyResetCode'),
        // تأكد من هذا الـ endpoint في الباك إند
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "resetCode": resetCode, // أو "code" أو "otp" حسب الباك إند
        }),
      );
      print('Verify Reset Code response status: ${response.statusCode}');
      print('Verify Reset Code response body: ${response.body}');
      return response;
    } catch (e) {
      print('Failed to verify reset code: $e');
      throw Exception('Failed to verify reset code: $e');
    }
  }

  // Reset Password (إعادة تعيين كلمة المرور بعد التحقق من الكود)
  static Future<http.Response> resetPassword({
    required String email,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/resetPassword'),
        // تأكد من هذا الـ endpoint في الباك إند
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "newPassword": newPassword,
          "confirmNewPassword": confirmNewPassword,
        }),
      );
      print('Reset Password response status: ${response.statusCode}');
      print('Reset Password response body: ${response.body}');
      return response;
    } catch (e) {
      print('Failed to reset password: $e');
      throw Exception('Failed to reset password: $e');
    }
  }
  // أضف هذه الدوال إلى class ApiService في ملف api_service.dart
  static void _printRequestDetails(http.BaseRequest request) {
    print('=== API Request ===');
    print('Method: ${request.method}');
    print('URL: ${request.url}');
    print('Headers: ${request.headers}');
    if (request is http.Request) {
      print('Body: ${request.body}');
    }
    print('==================');
  }

  // Helper method to print response details
  static void _printResponseDetails(http.Response response) {
    print('=== API Response ===');
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');
    print('===================');
  }

  // Get all questions with enhanced logging
  static Future<List<Question>> getAllQuestions() async {
    try {
      final uri = Uri.parse('$baseUrl/questions');
      final request = http.Request('GET', uri);
      request.headers['Content-Type'] = 'application/json';

      _printRequestDetails(request);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      _printResponseDetails(response);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('Parsed Questions:');
        data.forEach((q) => print(' - ${q['text']} (${q['_id']})'));

        return data.map((q) => Question.fromJson(q)).toList();
      } else {
        throw Exception('Failed to load questions: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error in getAllQuestions: $e');
      throw Exception('Failed to get questions: $e');
    }
  }

  // Submit answers with enhanced logging
  static Future<http.Response> submitAnswers({
    required String userId,
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/answers/submit');
      final request = http.Request('POST', uri);
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode({
        'userId': userId,
        'answers': answers,
      });

      _printRequestDetails(request);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      _printResponseDetails(response);

      return response;
    } catch (e) {
      print('Error in submitAnswers: $e');
      throw Exception('Failed to submit answers: $e');
    }
  }}