import 'dart:async';
import 'dart:convert';

import 'package:cms_company_profile/class/api.dart';
import 'package:http/http.dart' as http;

String urlApi = "http://biiio-studio.com:5868";

Future<ResponseRequestApi> connectApi(
    String url, String method, dynamic body) async {
  if (method == "post") {
    final response = await http.post(Uri.parse(urlApi + url), body: body);
    print("URL : " + urlApi + url);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      ResponseRequestApi responseRequest = ResponseRequestApi(
          status: response.statusCode,
          message: json['message'],
          data: json['data']);
      return responseRequest;
    } else {
      Map json = jsonDecode(response.body);
      ResponseRequestApi responseRequest = ResponseRequestApi(
          status: response.statusCode,
          message: json['message'],
          data: json['data']);
      return responseRequest;
    }
  } else if (method == "get") {
    final response = await http.get(Uri.parse(urlApi + url));
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      ResponseRequestApi responseRequest = ResponseRequestApi(
          status: response.statusCode,
          message: json['message'],
          data: json['data']);
      return responseRequest;
    } else {
      Map json = jsonDecode(response.body);
      ResponseRequestApi responseRequest = ResponseRequestApi(
          status: response.statusCode,
          message: json['message'],
          data: json['data']);
      return responseRequest;
    }
  } else if (method == "put") {
    final response = await http.put(Uri.parse(urlApi + url), body: body);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      ResponseRequestApi responseRequest = ResponseRequestApi(
          status: response.statusCode,
          message: json['message'],
          data: json['data']);
      return responseRequest;
    } else {
      Map json = jsonDecode(response.body);
      ResponseRequestApi responseRequest = ResponseRequestApi(
          status: response.statusCode,
          message: json['message'],
          data: json['data']);
      return responseRequest;
    }
  } else {
    final response = await http.delete(Uri.parse(urlApi + url), body: body);
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      ResponseRequestApi responseRequest = ResponseRequestApi(
          status: response.statusCode,
          message: json['message'],
          data: json['data']);
      return responseRequest;
    } else {
      Map json = jsonDecode(response.body);
      ResponseRequestApi responseRequest = ResponseRequestApi(
          status: response.statusCode,
          message: json['message'],
          data: json['data']);
      return responseRequest;
    }
  }
}
