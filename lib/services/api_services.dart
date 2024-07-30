import 'package:apiproject/services/api_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final Map<String, String> commonHeaders = {
    'Content-Type': 'application/json',
    // Add any other common headers here
  };



  /// Sends a GET request to the given URL.
  ///
  /// [url] - The URL to which the GET request is sent.
  /// [headers] - Optional headers to include in the request.
  ///
  /// Returns the response data if successful, or throws an exception if an error occurs.
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _buildHeaders(headers),
      );
      return _handleResponse(response);
    } catch (error) {
      _handleException(error);
    }
  }





  /// Sends a POST request to the given URL with the provided body.
  ///
  /// [url] - The URL to which the POST request is sent.
  /// [body] - The body of the POST request, which is encoded as JSON.
  /// [headers] - Optional headers to include in the request.
  ///
  /// Returns the response data if successful, or throws an exception if an error occurs.
  Future<dynamic> post(String url, dynamic body, {Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: _buildHeaders(headers),
        body: json.encode(body),
      );
      return _handleResponse(response);
    } catch (error) {
      _handleException(error);
    }
  }





  /// Sends a PUT request to the given URL with the provided body.
  ///
  /// [url] - The URL to which the PUT request is sent.
  /// [body] - The body of the PUT request, which is encoded as JSON.
  /// [headers] - Optional headers to include in the request.
  ///
  /// Returns nothing if successful, or throws an exception if an error occurs.
  Future<void> put(String url, dynamic body, {Map<String, String>? headers}) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: _buildHeaders(headers),
        body: json.encode(body),
      );
      _handleResponse(response, expectData: false);
    } catch (error) {
      _handleException(error);
    }
  }




  /// Sends a DELETE request to the given URL.
  ///
  /// [url] - The URL to which the DELETE request is sent.
  /// [headers] - Optional headers to include in the request.
  ///
  /// Returns nothing if successful, or throws an exception if an error occurs.
  Future<void> delete(String url, {Map<String, String>? headers}) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: _buildHeaders(headers),
      );
      _handleResponse(response, expectData: false);
    } catch (error) {
      _handleException(error);
    }
  }




  /// Combines common headers with any additional headers provided.
  ///
  /// [headers] - Optional headers to merge with common headers.
  ///
  /// Returns a map of headers to be used in HTTP requests.
  Map<String, String> _buildHeaders(Map<String, String>? headers) {
    if (headers != null) {
      return {...commonHeaders, ...headers};
    }
    return commonHeaders;
  }




  /// Handles the HTTP response and decodes the body if necessary.
  ///
  /// [response] - The HTTP response to handle.
  /// [expectData] - Whether the response is expected to contain data. Defaults to true.
  ///
  /// Returns the decoded response body if successful and data is expected,
  /// or throws an exception if the response status code indicates an error.
  dynamic _handleResponse(http.Response response, {bool expectData = true}) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (expectData) {
        return json.decode(response.body);
      }
      return;
    } else {
      throw InvalidResponseException('Failed to load data: ${response.statusCode}');
    }
  }




  /// Handles exceptions thrown during HTTP requests.
  ///
  /// [error] - The error to handle.
  ///
  /// Throws a specific exception based on the type of error.
  void _handleException(dynamic error) {
    if (error is http.ClientException) {
      throw NetworkException('Network error: ${error.message}');
    } else if (error is ApiException) {
      throw error;
    } else {
      throw UnexpectedException('Unexpected error: $error');
    }
  }
}
