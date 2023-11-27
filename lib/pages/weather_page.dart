import 'dart:async';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/services/weather_service.dart';
import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('1f776903aa2f1d26e01ca477f65a6058');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    //get weatger for city

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //animations

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'lib/assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'lib/assets/normalclouds.json';
      case 'mist':
        return 'lib/assets/clouds.json';
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'rain':
        return 'lib/assets/showerrain.json';
      case 'drizzle':
        return 'lib/assets/showerrain.json';
      case 'shower rain':
        return 'lib/assets/showerrain.json';
      case 'thunderstorm':
        return 'lib/assets/thunder4.json';
      case 'clear':
        return 'lib/assets/sunny.json';

      default:
        return 'lib/assets/sunny.json';
    }
  }

  //init state

  late String _greeting;

  @override
  void initState() {
    super.initState();

    _fetchWeather();
    _updateGreeting();

    // Update the greeting every minute
    Timer.periodic(Duration(minutes: 1), (timer) {
      _updateGreeting();
    });
  }

  _updateGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 5 && hour < 12) {
      setState(() {
        _greeting = 'Good Morning';
      });
    } else if (hour >= 12 && hour < 17) {
      setState(() {
        _greeting = 'Good Afternoon';
      });
    } else if (hour >= 17 && hour < 20) {
      setState(() {
        _greeting = 'Good Evening';
      });
    } else {
      setState(() {
        _greeting = 'Good Night';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF673AB7)),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(color: Color(0xFFFFAB40)),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _weather?.cityName ?? "loading city ...",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 250.0,
                      child: DefaultTextStyle(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText('$_greeting',
                                speed: const Duration(milliseconds: 300)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Lottie.asset(
                        getWeatherAnimation(_weather?.mainCondition),
                      ),
                    ),
                    Center(
                      child: Text(
                        '${_weather?.temperature.round()}°C',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 55,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Center(
                      child: Text(
                        _weather?.mainCondition.toUpperCase() ?? "",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Text(
                        _weather?.date ?? "",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'lib/assets/sunrise.png',
                              scale: 8,
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sunrise',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  _weather?.sunrise ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'lib/assets/sunset.png',
                              scale: 8,
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sunset',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  _weather?.sunset ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 7.0),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Humidity',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${_weather?.humidity ?? 0}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Precipitation',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${_weather?.precipitation ?? 0.0}mm',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 7.0),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Visibility',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${_weather?.visibility ?? 0.0} km',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Cloudiness',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${_weather?.cloudiness ?? 0}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
