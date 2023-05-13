import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices{
  Future<LoginApiResponse> apiCallLogin( Map<String,dynamic> parameter) async {
    var url = Uri.parse('https://reqres.in/api/login');
    var response = await http.post(url, body: parameter);
    final data = json.decode(response.body);
    return LoginApiResponse(token: data['token'], error: data['error']);
  }
  
}

class LoginApiResponse{
  LoginApiResponse({
    required this.token,
    required this.error
  });
  final String? token;
  final String? error;
}