import 'dart:convert';

import 'package:http/http.dart';
import 'package:mightyAdmin/utils/AppConstants.dart';
import 'package:nb_utils/nb_utils.dart';

bool isSuccessful(int code) {
  return code >= 200 && code <= 206;
}

Future buildTokenHeader() async {
  var pref = await getSharedPref();

  var header = {
    "token": "${pref.getString(TOKEN)}",
    "id": "${pref.getInt(USER_ID)}",
    "Content-Type": "application/json",
    //"Accept": "application/json",
  };
  print(jsonEncode(header));
  return header;
}

Future handleResponse(Response response) async {
  if (!await isNetworkAvailable()) {
    throw 'You are not connected to Internet';
  }
  String body = response.body.trim();

  if (isSuccessful(response.statusCode)) {
    return jsonDecode(body);
  } else {
    bool string = body.isJson();

    if (string) {
      throw jsonDecode(body);
    } else {
      throw 'Please try again later.';
    }
  }
}
