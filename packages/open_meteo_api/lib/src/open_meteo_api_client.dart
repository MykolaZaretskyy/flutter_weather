import 'dart:convert';

import 'package:http/http.dart' as _httpClient;
import '../open_meteo_api.dart';

const String _baseUrlGeocoding = 'api.open-meteo.com';

Future<Location> locationSearch(String query) async {
  final locationRequest = Uri.https(
    _baseUrlGeocoding,
    '/v1/search',
    {'name': query, 'count': '1'},
  );

  final locationResponse = await _httpClient.get(locationRequest);
  if (locationResponse.statusCode != 200) {
    throw Exception('Location request failed');
  }

  final locationJson = jsonDecode(locationResponse.body) as Map;
  if (!locationJson.containsKey('results')) {
    throw Exception('Location not found');
  }

  final results = locationJson['results'] as List;
  if (results.isEmpty) {
    throw Exception('Location not found');
  }

  return Location.fromJson(results.first as Map<String, dynamic>);
}