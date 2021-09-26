import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

/// ServerFacade acts as the api client interface to interact with backend
class ServerFacade {
  static final ServerFacade _singleton = ServerFacade._internal();
  final http.Client _client = http.Client();
  static final String apiUrl = ''; //TODO: PUT THE API URL HERE
  static Map<String, String> headers = {};
  FirebaseAuth _auth = FirebaseAuth.instance;

  ServerFacade._internal();
  factory ServerFacade() {
    headers["Content-Type"] = "application/json";
    return _singleton;
  }


  String _checkResponseBody(http.Response response, int statusCode) {
    if (response.statusCode == statusCode) {
      print(response.body);
      return response.body;
    } else {
      throw Exception(
          "Did not return Success Status code. Received a ${response.statusCode}");
    }
  }

  Future<String> _getBearerToken() async {
    return 'Bearer ' + await _auth.currentUser.getIdToken();
  }

  Stream<String> _receiveReactiveStream(http.Request request) {
    final controller = StreamController<String>();
    _client.send(request).then((response) {
      if (response.statusCode != 200) {
        controller.close();
        throw HttpException(
            "Not a success. and the status code is ${response.statusCode}",
            uri: response.request.url);
      }
      response.stream
          .toStringStream()
          .transform(LineSplitter())
          .listen((chunk) {
        var lines = chunk;
        if (lines != "") {
          controller.add(lines);
        }
      }).onDone(() {
        controller.close();
        debugPrint("Closed Http Controller.");
      });
    });
    return controller.stream;
  }
}
