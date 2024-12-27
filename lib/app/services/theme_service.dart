import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// A service class to manage theme-related functionality using GetX and GetStorage.
class ThemeService {
  // Singleton instance of ThemeService
  static final ThemeService _instance = ThemeService._internal();

  // Factory constructor to return the singleton instance
  factory ThemeService() => _instance;

  // Private constructor for singleton implementation
  ThemeService._internal() {
    // Initialize isDarkMode with the stored value
    isDarkMode.value = loadThemeFromBox();
  }

  // Instance of GetStorage for persistent storage
  final box = GetStorage();

  // Key for storing the theme preference in GetStorage
  final key = 'isDarkMode';

  // Reactive boolean to observe and update the theme state
  final isDarkMode = false.obs;

  /// Reads the theme preference from GetStorage.
  /// Returns `true` if dark mode is enabled, otherwise `false`.
  bool loadThemeFromBox() => box.read(key) ?? false;

  /// Gets the current theme mode.
  /// Returns [ThemeMode.dark] if dark mode is active, otherwise [ThemeMode.light].
  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  /// Saves the theme preference to GetStorage.
  /// [isDarkMode]: `true` for dark mode, `false` for light mode.
  void saveThemeToBox(bool isDarkMode) => box.write(key, isDarkMode);

  /// Toggles the current theme between dark and light mode.
  /// Updates the [isDarkMode] reactive variable and persists the change.
  void switchTheme() {
    isDarkMode.value = !isDarkMode.value; // Toggle the theme
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    saveThemeToBox(isDarkMode.value); // Save the updated theme to storage
  }
}
