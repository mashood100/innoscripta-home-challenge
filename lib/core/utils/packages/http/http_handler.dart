import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpHandler {
  final String baseUrl;
  final Map<String, String> headers;

  HttpHandler(this.baseUrl, this.headers);

  Future<http.Response> get(String endpoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? queryParams}) async {
    try {
      final Uri uri = _buildUri(endpoint, queryParams);

      final http.Request request = http.Request('GET', uri)
        ..headers.addAll(headers);

      if (body != null) {
        request.body = jsonEncode(body);
      }
      http.StreamedResponse streamedResponse = await request.send();

      final http.Response response =
          await http.Response.fromStream(streamedResponse);

      if (response.statusCode < 200 || response.statusCode > 299) {}

      return response;
    } catch (e) {
      log('Error during GET request: ${e.toString()}');
      rethrow;
    }
  }

  Future<http.Response> post(String endpoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? queryParams}) async {
    try {
      final Uri uri = _buildUri(endpoint, queryParams);
      final http.Request request = http.Request('POST', uri)
        ..headers.addAll(headers);
      if (body != null) {
        request.body = jsonEncode(body);
      }
      http.StreamedResponse streamedResponse = await request.send();

      final http.Response response =
          await http.Response.fromStream(streamedResponse);

      if (response.statusCode < 200 || response.statusCode > 299) {}

      log('POST response: ${response.body}');

      return response;
    } catch (e) {
      log('Error during POST request: ${e.toString()}');
      rethrow;
    }
  }

  Future<http.Response> put(String endpoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? queryParams}) async {
    try {
      final Uri uri = _buildUri(endpoint, queryParams);
      final http.Request request = http.Request('PUT', uri)
        ..headers.addAll(headers);
      if (body != null) {
        request.body = jsonEncode(body);
      }
      http.StreamedResponse streamedResponse = await request.send();

      final http.Response response =
          await http.Response.fromStream(streamedResponse);

      if (response.statusCode < 200 || response.statusCode > 299) {}

      return response;
    } catch (e) {
      log('Error during PUT request: ${e.toString()}');
      rethrow;
    }
  }

  Future<http.Response> patch(String endpoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? queryParams}) async {
    try {
      final Uri uri = _buildUri(endpoint, queryParams);

      final http.Request request = http.Request('PATCH', uri)
        ..headers.addAll(headers);
      if (body != null) {
        request.body = jsonEncode(body);
      }
      http.StreamedResponse streamedResponse = await request.send();

      final http.Response response =
          await http.Response.fromStream(streamedResponse);

      if (response.statusCode < 200 || response.statusCode > 299) {}

      log('PATCH response: ${response.body}');

      return response;
    } catch (e) {
      log('Error during PATCH request: ${e.toString()}');
      rethrow;
    }
  }

  Future<http.Response> delete(String endpoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? queryParams}) async {
    try {
      final Uri uri = _buildUri(endpoint, queryParams);
      final http.Request request = http.Request('DELETE', uri)
        ..headers.addAll(headers);
      if (body != null) {
        request.body = jsonEncode(body);
      }
      http.StreamedResponse streamedResponse = await request.send();

      final http.Response response =
          await http.Response.fromStream(streamedResponse);

      if (response.statusCode < 200 || response.statusCode > 299) {}

      log('DELETE response: ${response.body}');

      return response;
    } catch (e) {
      log('Error during DELETE request: ${e.toString()}');
      rethrow;
    }
  }

  Future<http.Response> multipartRequest(String endpoint, File? file,
      {Map<String, dynamic>? queryParams}) async {
    try {
      if (file == null) throw Exception("File is null");
      final Uri uri = _buildUri(endpoint, queryParams);
      final http.MultipartRequest request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..files
            .add(await http.MultipartFile.fromPath('attachments', file.path));

      http.StreamedResponse streamedResponse = await request.send();
      final http.Response response =
          await http.Response.fromStream(streamedResponse);

      if (response.statusCode < 200 || response.statusCode > 299) {}

      return response;
    } catch (e) {
      log('Error during MULTIPART POST request: ${e.toString()}');
      rethrow;
    }
  }

  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParams) {
    var uri = Uri.parse('$baseUrl$endpoint');
    if (queryParams != null) {
      queryParams = queryParams
          .map((key, value) => MapEntry(key, value.toString()))
          .entries
          .where((entry) => entry.value != 'null')
          .fold<Map<String, String>>({}, (Map<String, String> map, entry) {
        map[entry.key] = entry.value;
        return map;
      });
      uri = uri.replace(queryParameters: queryParams);
    }
    return uri;
  }
}
