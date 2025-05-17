// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class AuthService {
//   static const String baseUrl = 'https://dermavision-api.onrender.com';
//
//   static Future<http.Response> login(String email, String password) async {
//     final url = Uri.parse('$baseUrl/login');
//     final body = {
//       'email': email,
//       'password': password,
//     };
//     return await http.post(url, body: jsonEncode(body), headers: {
//       'Content-Type': 'application/json',
//     });
//   }
//
//   static Future<http.Response> register(String email, String name, String password) async {
//     final url = Uri.parse('$baseUrl/register');
//     final body = {
//       'email': email,
//       'name': name,
//       'password': password,
//     };
//     return await http.post(url, body: jsonEncode(body), headers: {
//       'Content-Type': 'application/json',
//     });
//   }
// }
