import 'dart:convert';

class PlacesResponse {
  final String type;
  final List<Feature> features;
  final String attribution;

  PlacesResponse({
    required this.type,
    required this.features,
    required this.attribution,
  });

  factory PlacesResponse.fromJson(String str) =>
      PlacesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlacesResponse.fromMap(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        features:
            List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
      };
}

class Feature {
  final String type;
  final String id;
  final Geometry geometry;
  final Properties properties;

  Feature({
    required this.type,
    required this.id,
    required this.geometry,
    required this.properties,
  });

  factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        type: json["type"],
        id: json["id"],
        geometry: Geometry.fromMap(json["geometry"]),
        properties: Properties.fromMap(json["properties"]),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "id": id,
        "geometry": geometry.toMap(),
        "properties": properties.toMap(),
      };
}

class Geometry {
  final String type;
  final List<double> coordinates;

  Geometry({
    required this.type,
    required this.coordinates,
  });

  factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  final String mapboxId;
  final String featureType;
  final String fullAddress;
  final String name;
  final String namePreferred;
  final Coordinates coordinates;
  final Context context;

  Properties({
    required this.mapboxId,
    required this.featureType,
    required this.fullAddress,
    required this.name,
    required this.namePreferred,
    required this.coordinates,
    required this.context,
  });

  factory Properties.fromJson(String str) =>
      Properties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        mapboxId: json["mapbox_id"],
        featureType: json["feature_type"],
        fullAddress: json["full_address"],
        name: json["name"],
        namePreferred: json["name_preferred"],
        coordinates: Coordinates.fromMap(json["coordinates"]),
        context: Context.fromMap(json["context"]),
      );

  Map<String, dynamic> toMap() => {
        "mapbox_id": mapboxId,
        "feature_type": featureType,
        "full_address": fullAddress,
        "name": name,
        "name_preferred": namePreferred,
        "coordinates": coordinates.toMap(),
        "context": context.toMap(),
      };
}

class Context {
  final Postcode? postcode;
  final Locality? locality;
  final District? neighborhood;
  final District? district;

  Context({
    this.postcode,
    this.locality,
    this.neighborhood,
    this.district,
  });

  factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Context.fromMap(Map<String, dynamic> json) => Context(
        postcode: json["postcode"] == null
            ? null
            : Postcode.fromMap(json["postcode"]),
        locality: json["locality"] == null
            ? null
            : Locality.fromMap(json["locality"]),
        neighborhood: json["neighborhood"] == null
            ? null
            : District.fromMap(json["neighborhood"]),
        district: json["district"] == null
            ? null
            : District.fromMap(json["district"]),
      );

  Map<String, dynamic> toMap() => {
        "postcode": postcode?.toMap(),
        "locality": locality?.toMap(),
        "neighborhood": neighborhood?.toMap(),
        "district": district?.toMap(),
      };
}

class Country {
  final String mapboxId;
  final String name;
  final String? wikidataId;
  final String? countryCode;
  final String? countryCodeAlpha3;
  final Translations translations;

  Country({
    required this.mapboxId,
    required this.name,
    this.wikidataId,
    this.countryCode,
    this.countryCodeAlpha3,
    required this.translations,
  });

  factory Country.fromJson(String str) => Country.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Country.fromMap(Map<String, dynamic> json) => Country(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        countryCode: json["country_code"],
        countryCodeAlpha3: json["country_code_alpha_3"],
        translations: Translations.fromMap(json["translations"]),
      );

  Map<String, dynamic> toMap() => {
        "mapbox_id": mapboxId,
        "name": name,
        "wikidata_id": wikidataId,
        "country_code": countryCode,
        "country_code_alpha_3": countryCodeAlpha3,
        "translations": translations.toMap(),
      };
}

class Translations {
  final Es es;

  Translations({
    required this.es,
  });

  factory Translations.fromJson(String str) =>
      Translations.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Translations.fromMap(Map<String, dynamic> json) => Translations(
        es: Es.fromMap(json["es"]),
      );

  Map<String, dynamic> toMap() => {
        "es": es.toMap(),
      };
}

class Es {
  final String language;
  final String name;

  Es({
    required this.language,
    required this.name,
  });

  factory Es.fromJson(String str) => Es.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Es.fromMap(Map<String, dynamic> json) => Es(
        language: json["language"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "language": language,
        "name": name,
      };
}

class District {
  final String mapboxId;
  final String name;
  final Translations translations;
  final String? wikidataId;

  District({
    required this.mapboxId,
    required this.name,
    required this.translations,
    this.wikidataId,
  });

  factory District.fromJson(String str) => District.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory District.fromMap(Map<String, dynamic> json) => District(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        translations: Translations.fromMap(json["translations"]),
        wikidataId: json["wikidata_id"],
      );

  Map<String, dynamic> toMap() => {
        "mapbox_id": mapboxId,
        "name": name,
        "translations": translations.toMap(),
        "wikidata_id": wikidataId,
      };
}

class Locality {
  final String mapboxId;
  final String name;
  final String? wikidataId;
  final Translations translations;

  Locality({
    required this.mapboxId,
    required this.name,
    this.wikidataId,
    required this.translations,
  });

  factory Locality.fromJson(String str) => Locality.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Locality.fromMap(Map<String, dynamic> json) => Locality(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        translations: Translations.fromMap(json["translations"]),
      );

  Map<String, dynamic> toMap() => {
        "mapbox_id": mapboxId,
        "name": name,
        "wikidata_id": wikidataId,
        "translations": translations.toMap(),
      };
}

class Place {
  final String mapboxId;
  final String name;
  final String? wikidataId;
  final Translations translations;
  final Alternate? alternate;

  Place({
    required this.mapboxId,
    required this.name,
    this.wikidataId,
    required this.translations,
    this.alternate,
  });

  factory Place.fromJson(String str) => Place.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Place.fromMap(Map<String, dynamic> json) => Place(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        translations: Translations.fromMap(json["translations"]),
        alternate: json["alternate"] == null
            ? null
            : Alternate.fromMap(json["alternate"]),
      );

  Map<String, dynamic> toMap() => {
        "mapbox_id": mapboxId,
        "name": name,
        "wikidata_id": wikidataId,
        "translations": translations.toMap(),
        "alternate": alternate?.toMap(),
      };
}

class Alternate {
  final String mapboxId;
  final String name;
  final Translations translations;

  Alternate({
    required this.mapboxId,
    required this.name,
    required this.translations,
  });

  factory Alternate.fromJson(String str) => Alternate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Alternate.fromMap(Map<String, dynamic> json) => Alternate(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        translations: Translations.fromMap(json["translations"]),
      );

  Map<String, dynamic> toMap() => {
        "mapbox_id": mapboxId,
        "name": name,
        "translations": translations.toMap(),
      };
}

class Postcode {
  final String mapboxId;
  final String name;

  Postcode({
    required this.mapboxId,
    required this.name,
  });

  factory Postcode.fromJson(String str) => Postcode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Postcode.fromMap(Map<String, dynamic> json) => Postcode(
        mapboxId: json["mapbox_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "mapbox_id": mapboxId,
        "name": name,
      };
}

class Region {
  final String mapboxId;
  final String name;
  final String wikidataId;
  final String? regionCode;
  final String? regionCodeFull;
  final Translations translations;

  Region({
    required this.mapboxId,
    required this.name,
    required this.wikidataId,
    this.regionCode,
    this.regionCodeFull,
    required this.translations,
  });

  factory Region.fromJson(String str) => Region.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Region.fromMap(Map<String, dynamic> json) => Region(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        regionCode: json["region_code"],
        regionCodeFull: json["region_code_full"],
        translations: Translations.fromMap(json["translations"]),
      );

  Map<String, dynamic> toMap() => {
        "mapbox_id": mapboxId,
        "name": name,
        "wikidata_id": wikidataId,
        "region_code": regionCode,
        "region_code_full": regionCodeFull,
        "translations": translations.toMap(),
      };
}

class Coordinates {
  final double longitude;
  final double latitude;

  Coordinates({
    required this.longitude,
    required this.latitude,
  });

  factory Coordinates.fromJson(String str) =>
      Coordinates.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Coordinates.fromMap(Map<String, dynamic> json) => Coordinates(
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "longitude": longitude,
        "latitude": latitude,
      };
}
