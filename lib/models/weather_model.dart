import 'package:intl/intl.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String date;
  final String mainCondition;
  final String sunrise;
  final String sunset;
  final double precipitation;
  final int humidity;
  final int airQuality;
  final double cloudiness;
  final double visibility;

  Weather({
    required this.date,
    required this.visibility,
    required this.airQuality,
    required this.precipitation,
    required this.humidity,
    required this.cloudiness,
    required this.cityName,
    required this.mainCondition,
    required this.temperature,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      date: _parseDate(json['dt']),
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      sunrise: _parseTime(json['sys']?['sunrise'], json['timezone']),
      sunset: _parseTime(json['sys']?['sunset'], json['timezone']),
      precipitation: (json['rain']?['3h'] as num?)?.toDouble() ?? 0.0,
      humidity: json['main']['humidity'],
      cloudiness: (json['clouds']['all'] as num?)?.toDouble() ?? 0.0,
      airQuality: json['main']['aqi'] ?? 0,
      visibility:
          _parseVisibility((json['visibility'] as num?)?.toDouble() ?? 0.0),
    );
  }
  static String _parseDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedDate = DateFormat('EEEE dd - hh:mm a').format(dateTime);
    return formattedDate;
  }

  static String _parseTime(int? timestamp, int? timezone) {
    if (timestamp == null || timestamp == 0 || timezone == null) {
      return '';
    }
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    DateTime localDateTime = dateTime.add(Duration(seconds: timezone));
    String formattedTime = DateFormat('hh:mm a').format(localDateTime);
    return formattedTime;
  }

  static double _parseVisibility(double? visibility) {
    if (visibility == null) {
      return 0.0; // or any default value you prefer
    }

    double visibilityInKm = visibility / 1000.0;
    return visibilityInKm;
  }
}
