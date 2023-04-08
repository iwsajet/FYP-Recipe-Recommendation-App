import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class RecipeSearchHttpClient {
  Future<dynamic> get({required String url}) async {
    try {
      print("http called");
      final response = await http.get(
        Uri.parse(url),
        headers: header(),
      );
      log("Request Url is ${response.request!.url.toString()}");
      log("Status code${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      if (response.statusCode == 490) {
        throw Exception(jsonDecode(response.body)['message']);
      }
      throw Exception("error occured");
    } on Exception {
      debugPrint("exeption occured");
      rethrow;
    } catch (e) {
      debugPrint("error is $e");
    }
  }

  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      print("http called");
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: header(),
      );
      log("Request Url is ${response.request!.url.toString()}");
      log("Status code${response.statusCode}");
      log("Reponse body is ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      if (response.statusCode == 490) {
        throw Exception(jsonDecode(response.body)['message']);
      }
      throw Exception("error occured");
    } on Exception {
      debugPrint("exeption occured");
      rethrow;
    } catch (e) {
      debugPrint("error is $e");
    }
  }

  Map<String, String> header() {
    return {'Content-Type': 'application/json'};
  }
}
