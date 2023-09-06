import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class InternetChecker {
  Future<bool> hasInternet() async {
    bool result = false;

    try {
      if (kIsWeb) {
        final http.Response response = await http.get(
          Uri.parse('google.com'),
        );
        if (response.statusCode == 200) {
          result = true;
        }
      } else {
        final List<InternetAddress> list =
            await InternetAddress.lookup('google.com');
        print('Chequeando internet 🐱‍🏍');
        print(list);
        print(list.first);
        if (list.isNotEmpty && list.first.rawAddress.isNotEmpty) {
          result = true;
        }
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
