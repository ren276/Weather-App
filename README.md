# Flutter Weather App

![App Demo](demo.gif)

## Overview

This Flutter Weather App is a simple and intuitive application that allows users to check the current weather conditions and forecasts for different locations. It is powered by the OpenWeatherMap API, providing accurate and up-to-date weather information.

## Features

- **Current Weather:** Get real-time information about the current weather, including temperature, humidity, wind speed, and more.
  
- **Forecast:** View the weather forecast for the next few days to plan ahead.

- **Location-based Weather:** Automatically fetch weather data based on the user's location.

- **Search Locations:** Search for weather information in specific locations around the world.

## Getting Started

To use this app, follow these steps:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/flutter-weather-app.git
   ```

2. **Navigate to the Project:**
   ```bash
   cd flutter-weather-app
   ```

3. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the App:**
   ```bash
   flutter run
   ```

## Configuration

Before running the app, you need to obtain an API key from OpenWeatherMap. Follow these steps:

1. **Get API Key:**
   - Visit [OpenWeatherMap](https://openweathermap.org/) and sign up for a free account.
   - Generate an API key in your account dashboard.

2. **Add API Key to the App:**
   - Open the `lib/pages/weather_page.dart` file.
   - Replace the `Put Your apiKey` placeholder with your actual API key.

```dart
final _weatherService = WeatherService('Put Your apiKey');
```

## Architecture

The app is designed using the BLoC (Business Logic Component) architecture. The BLoC pattern helps manage the state of the application and separate the business logic from the UI.

## Future Improvements

- **BLoC Implementation:** The app currently uses basic HTTP requests. Future versions will implement the BLoC architecture for improved state management.

- **Additional Features:** Enhance the app with additional features such as multiple weather data sources, dark mode, and customizable themes.

## Contributions

Contributions are welcome! If you find any issues or have suggestions for improvements, please create an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
