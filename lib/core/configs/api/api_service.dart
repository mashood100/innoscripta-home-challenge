import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:innoscripta_home_challenge/core/packages/http/http_handler.dart';

enum RequestType { GET, POST, PUT, PATCH, DELETE, MULTIPART }

class ApiService {
  final baseUrl = 'https://api.todoist.com/rest/v2';
  final String token = '64ed568f10d1982d4c6a40dcfc3408bdc176ea08';

  Future<http.Response> makeRequest(RequestData requestData,
      {String? orgId}) async {
    try {
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      };

      if (requestData.headers != null && requestData.headers!.isNotEmpty) {
        requestHeaders.addAll(requestData.headers!);
      }

      final HttpHandler httpHandler = HttpHandler(
        baseUrl,
        requestHeaders,
      );
      final String endpoint = requestData.endpoint;
      final RequestType requestType = requestData.requestType;
      final Map<String, dynamic>? queryParameters = requestData.queryParameters;
      final Map<String, dynamic>? payload = requestData.payload;
      final File? file = requestData.file;
      switch (requestType) {
        case RequestType.GET:
          return httpHandler.get(endpoint,
              body: payload, queryParams: queryParameters);
        case RequestType.POST:
          return httpHandler.post(endpoint,
              body: payload, queryParams: queryParameters);
        case RequestType.PUT:
          return httpHandler.put(endpoint,
              body: payload, queryParams: queryParameters);
        case RequestType.PATCH:
          return httpHandler.patch(endpoint,
              body: payload, queryParams: queryParameters);
        case RequestType.DELETE:
          return httpHandler.delete(endpoint,
              body: payload, queryParams: queryParameters);
        case RequestType.MULTIPART:
          return httpHandler.multipartRequest(endpoint, file);
      }
    } catch (e) {
      rethrow;
    }
  }
}

class RequestData {
  final String endpoint;
  final RequestType requestType;
  final Map<String, String>? headers;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? payload;
  final File? file;

  RequestData(
    this.endpoint,
    this.requestType, {
    this.headers,
    this.file,
    this.queryParameters,
    this.payload,
  });
}
