import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({@required this.url});

  final String url;

  /// get response data from network call.
  /// it is async call
  /// @returns json body

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print('Response code : ${response.statusCode}');
    }
  }
}
