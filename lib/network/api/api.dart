import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/constants.dart';

class Api {
  final _host = Constants.hostname;
  final _protocol = Constants.protocol;
  final stringToBase64Url = utf8.fuse(base64Url);

  Future<Map> requestPOST({required String? path, dynamic parameters}) async {
    bool chk = parameters!.containsKey("token");
    var headersData = _headers;
    dynamic res = jsonEncode(parameters);
    if (chk) {
      headersData['Authorization'] = 'Bearer ${parameters['token']}';
    }
    dynamic uri;
    if (_protocol == 'https') {
      uri = Uri.https(_host, path!);
    } else {
      uri = Uri.http(_host, path!);
    }

    final results = await http.post(uri, headers: headersData, body: res);
    if (results.body.isNotEmpty) {
      final jsonObject = json.decode(results.body);
      return jsonObject;
    } else {
      return {};
    }
  }

  // Future<dynamic> requestGET(
  //     {required String path, Map<String, Object>? parameters}) async {
  //   bool chk = parameters!.containsKey('token');
  //   var headersData = _headers;
  //   if (chk) {
  //     headersData['Authorization'] = 'Bearer ${parameters['token']}';
  //   }
  //   dynamic uri;
  //   if (_protocol == 'https') {
  //     uri = Uri.https(_host, path, parameters);
  //   } else {
  //     uri = Uri.http(_host, path, parameters);
  //   }

  //   final result = await http.get(uri, headers: headersData);

  //   if (result.body.isNotEmpty) {
  //     final jsonObject = json.decode(result.body);
  //     return jsonObject;
  //   } else {
  //     return {};
  //   }
  // }
  Future<dynamic> requestGET(
      {required String path, Map<String, Object>? parameters}) async {
    bool chk = parameters!.containsKey('token');
    var headersData = _headers;
    if (chk) {
      headersData['Authorization'] = 'Bearer ${parameters['token']}';
    }
    dynamic uri;
    if (_protocol == 'https') {
      uri = Uri.https(_host, path, parameters);
    } else {
      uri = Uri.http(_host, path, parameters);
    }

    final result = await http.get(uri, headers: headersData);

    if (result.body.isNotEmpty) {
      final jsonObject = json.decode(result.body);
      return jsonObject;
    } else {
      return {};
    }
  }

  Future<Map> requestDELETE(
      {required String? path, Map<String, Object>? parameters}) async {
    bool chk = parameters!.containsKey("token");
    var headersData = {
      'Accept': 'application/json, text/plain',
    };
    if (chk) {
      headersData['Authorization'] = 'Bearer ${parameters['token']}';
    }
    dynamic uri;
    if (_protocol == 'https') {
      uri = Uri.https(_host, path!);
    } else {
      uri = Uri.http(_host, path!);
    }
    final results =
        await http.delete(uri, headers: headersData, body: parameters);
    if (results.body.isNotEmpty) {
      final jsonObject = jsonDecode(results.body);
      return jsonObject;
    } else {
      return {};
    }
  }

  Future<Map> requestPUT(
      {required String? path, Map<String, Object>? parameters}) async {
    bool chk = parameters!.containsKey("token");
    var headersData = _headers;
    if (chk) {
      headersData['Authorization'] = 'Bearer ${parameters['token']}';
    }
    dynamic uri;
    if (_protocol == 'https') {
      uri = Uri.https(_host, path!);
    } else {
      uri = Uri.http(_host, path!);
    }

    final results =
        await http.put(uri, headers: headersData, body: jsonEncode(parameters));

    if (results.body.isNotEmpty) {
      final jsonObject = jsonDecode(results.body);
      return jsonObject;
    } else {
      return {};
    }
  }

  dynamic stringToBase64(data) {
    return stringToBase64Url.decode(data);
  }

  Map<String, String> get _headers => {
        'Accept': 'application/json, text/plain',
        "Content-Type": "application/json"
      };
}
