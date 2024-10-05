import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:baston_inteligente_mejorada/services/services.dart';

import '../models/models.dart';

class TrafficService {
  final Dio _dioTraffic;
  final Dio _dioPlaces;

  final String _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _basePlacesUrl =
      'https://api.mapbox.com/search/geocode/v6/forward';

  TrafficService()
      : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor()),
        _dioPlaces = Dio()..interceptors.add(PlacesInterceptor());

  Future<TrafficResponse> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final coorsString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';

    final url = '$_baseTrafficUrl/driving/$coorsString';

    final resp = await _dioTraffic.get(url);

    // final data = TrafficResponse.fromJson(jsonEncode(resp.data));
    final data = TrafficResponse.fromMap(resp.data);

    return data;
  }

  Future<List<Feature>> getResultsByQuery(
      LatLng proximity, String query) async {
    if (query.isEmpty) return [];

    final url = '$_basePlacesUrl?q=$query.json';

    final resp = await _dioPlaces.get(url, queryParameters: {
      'country': 'bo',
      'limit': 5,
      'proximity': '${proximity.longitude},${proximity.latitude}',
      'language': 'es',
    });

    final placesResponse = PlacesResponse.fromMap(resp.data);

    return placesResponse.features;
  }

  Future<Feature> getInformationByCoors(LatLng coors) async {
    final url = '$_basePlacesUrl?${coors.longitude},${coors.latitude}.json';

    final resp = await _dioPlaces.get(url, queryParameters: {
      'country': 'bo',
      'limit': 1,
      'language': 'es',
    });
    final placesResponse = PlacesResponse.fromMap(resp.data);
    // final placesResponse = PlacesResponse.fromJson(resp.data);

    return placesResponse.features[0];
  }
}
