import 'package:flutter/material.dart';

class SourceConfig {
  final String baseUrl;
  final int countryId;
  final String envName;
  final String appVariant;
  final String countryPartner;
  final Color colorIndicator;

  SourceConfig._({
    required this.envName,
    required this.colorIndicator,
    required this.baseUrl,
    required this.countryId,
    required this.appVariant,
    required this.countryPartner,
  });

  String get appSuffix {
    if (envName == "prod") return "";
    return " - $envName";
  }



  static SourceConfig prod = SourceConfig._(
    baseUrl: "https://5efdb0b9dd373900160b35e2.mockapi.io",
    countryId: 1,
    appVariant: "doc",
    countryPartner: "BANGLADESH_ROBI",
    envName: 'prod',
    colorIndicator: Colors.green,
  );

  @override
  bool operator ==(dynamic other) => envName == other.envName;

  String toObjectString() {
    return "UrlConfig("
        "\n\tenvName: $baseUrl,"
        "\n\tcolorIndicator: $baseUrl,"
        "\n\tbaseUrl: $baseUrl,"
        "\n\tcountryId: $countryId,"
        "\n\tappVariant: $appVariant,"
        "\n\tcountryPartner: $countryPartner,"
        "\n)";
  }

  @override
  String toString() => envName;

  @override
  int get hashCode => super.hashCode;
}

class AppConfig {
  static late SourceConfig _config;

  AppConfig(SourceConfig config) {
    _config = config;
  }

  static SourceConfig get env => _config;
}
