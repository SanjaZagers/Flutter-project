# Beginners Course

A comprehensive Flutter application showcasing multiple features including workout tracking, to-do list management, weather information, period tracking, RSS feeds, and more. This project demonstrates best practices in Flutter development with state management, local data persistence, and integration with external APIs.

## Features

- ** Workout Tracker** - Track your exercises and workout sessions with detailed logging
- ** To-Do List** - Manage your daily tasks and reminders
- ** Weather App** - Real-time weather information with geolocation support
- ** Period Tracker** - Calendar-based period tracking with visual heatmap
- ** RSS Feed Reader** - Stay updated with latest news from your favorite sources
- ** Settings** - Customizable app preferences and configurations
- ** Local Data Persistence** - All data is stored locally using Hive
- ** Geolocation** - GPS-based location services for weather and mapping features

## Tech Stack

- **Framework**: Flutter (v3.5.4+)
- **State Management**: Provider
- **Local Storage**: Hive & Hive Flutter
- **Geolocation**: Geolocator & Geocoding
- **Networking**: HTTP
- **UI Components**: Flutter Slidable, Lottie animations, Table Calendar, Heatmap Calendar
- **Utilities**: IntL (internationalization), Shared Preferences, URL Launcher, RSS Feed

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── pages/                    # Page/Screen widgets
│   ├── home_page.dart
│   ├── workout_page.dart
│   ├── todo_page.dart
│   ├── weather_page.dart
│   ├── periodTracker_page.dart
│   ├── rssfeed_page.dart
│   ├── settings_page.dart
│   └── ...
├── components/               # Reusable UI components
├── models/                   # Data models
├── services/                 # Business logic & API calls
├── data/                     # Data layer & state management
├── util/                     # Utility functions
└── datatime/                 # Date/time utilities
```

## Getting Started

### Prerequisites

- Flutter SDK (v3.5.4 or higher)
- Dart SDK
- An IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd beginners_course
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Platform Support

This project supports multiple platforms:
-  Android
-  iOS
-  Web
-  Windows
-  Linux
-  macOS

## Key Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| hive | ^2.2.3 | Local NoSQL database |
| provider | - | State management |
| geolocator | ^11.0.0 | GPS location services |
| geocoding | ^3.0.0 | Convert coordinates to addresses |
| http | ^1.2.2 | HTTP requests |
| table_calendar | ^3.0.9 | Calendar widget |
| flutter_heatmap_calendar | ^1.0.5 | Heatmap visualization |
| lottie | ^3.2.0 | Animations |
| rss_feed | ^1.1.1 | RSS feed parsing |

## Usage

### Workout Tracking
Navigate to the Workout section to log exercises, set target reps/weights, and track progress over time.

### Weather
The Weather page displays current conditions and forecasts based on your device's location. Ensure location permissions are granted.

### Period Tracker
View and track your period cycle on an interactive calendar with visual heatmap indicators.

### RSS Feeds
Add and read from multiple RSS feed sources. URLs are managed through the app interface.

### To-Do List
Create, update, and manage daily tasks with persistent storage.

## Project Features Demonstrated

- **State Management**: Provider for efficient app-wide state handling
- **Local Data Storage**: Hive for fast, offline-capable data persistence
- **API Integration**: HTTP calls for external data sources
- **Geolocation**: Real-time GPS and address lookup
- **Responsive UI**: Adaptive layouts for different screen sizes
- **Navigation**: Named routing for clean navigation flow
- **Animations**: Lottie animations for engaging UX

## File Assets

The app includes JSON animation assets for weather visualization:
- `assets/sunny.json`
- `assets/rain.json`
- `assets/cloud.json`
- `assets/thunder.json`
- `assets/mist.json`
- `assets/cat.json`

## Development

### Running Tests
```bash
flutter test
```

### Code Generation
This project uses Hive generators for model serialization:
```bash
flutter pub run build_runner build
```

### Linting
```bash
flutter analyze
```

## Contributing

Feel free to fork this project and submit pull requests for any improvements!

## License

This project is provided as-is for educational purposes.

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Provider Package](https://pub.dev/packages/provider)
- [Hive Database](https://docs.hivedb.dev/)
