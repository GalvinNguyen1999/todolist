/// App configuration and constants
class AppConstants {
  // API Configuration
  static const String apiBaseUrl =
      'https://68f88645deff18f212b661e3.mockapi.io/';
  
  // TODO: Thay YOUR_ID bằng ID MockAPI của bạn
  static const String todosEndpoint = '$apiBaseUrl/todos';
  
  // App Info
  static const String appName = 'Todo List App';
  static const String appVersion = '1.0.0';
  
  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration snackBarDuration = Duration(seconds: 2);
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double cardElevation = 4.0;
  static const double borderRadius = 12.0;
}

