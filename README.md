# PhotoPulse

product demo:
https://github.com/user-attachments/assets/b0a79137-560b-4fa0-a263-8cf964ff7c15


Download the apk using the link:https://drive.google.com/file/d/178YzDyOYuHsvH9PcvwHVusBA8yyaJa0M/view?usp=sharing  


## Pexels API Key Setup
1. Get a free API key from [Pexels API](https://www.pexels.com/api/).
2. Open `lib/services/api_service.dart`.
3. Locate the `apiKey` variable and replace its value with your newly generated API key:

```dart
class ApiService {
  // Pexels API Key 
  static const String apiKey = 'YOUR_PEXELS_API_KEY_HERE';
  static const String baseUrl = 'https://api.pexels.com/v1';
  // ...
}
```


# Tech note

1. Executive Summary
PhotoPulse is a Flutter application designed for searching, viewing, and locally saving high-resolution images via the Pexels API. It focuses on performance, state determinism, and adhering to modern Material 3 design paradigms. The primary goal is to provide a seamless caching mechanism and robust offline persistence for favourite images.

2. Technology Stack & Dependencies
Framework: Flutter SDK (>= 3.11.0)
State Management: provider (^6.1.5+1)
Networking: http (^1.6.0)
Local Storage (Database): sqflite (^2.4.2) & path (^1.9.1)
Image Handling/Caching: cached_network_image (^3.4.1)
External Links: url_launcher (^6.3.2)
Icon Fonts: cupertino_icons (^1.0.8)
3. Architecture Overview
State Management (AppProvider)
The application utilizes the provider package utilizing the ChangeNotifier pattern for reactive state management.

Centralized State: AppProvider dictates the source of truth for the entire app, encapsulating states for Search (_currentImages, _isLoading, _currentPage) and Favourites (_favourites).
Reactive UI: Screens like HomeScreen and FavouritesScreen listen to AppProvider. This allows for snappy UI updates—when a user favorites an image, it immediately updates the UI while asynchronously committing to the SQLite database.
Networking & API (ApiService)
Network requests are isolated into a dedicated ApiService class.

Pexels Integration: The app fetches external data using the Pexels REST API. Support for pagination (page and per_page parameters) is natively handled by passing the current page from the AppProvider.
Error Handling: Try-catch blocks wrap all API calls to prevent the app from crashing on network failures, safely setting the _currentImages list to empty and updating the loading state.
Local Persistence (DatabaseHelper)
We use sqflite rather than shared_preferences.

Why Sqflite? Storing a dynamic list of objects (favourited images) is safer and more queryable natively in SQLite compared to manipulating sprawling JSON strings in SharedPreferences.
Lifecycle: The database initializes and creates an images table when the app first launches. AppProvider calls _loadFavourites() immediately upon instantiation to ensure saved favourites persist across app restarts.
Operations: Features asynchronous insert (adding a favourite), delete (removing a favourite by ID), and query (fetching all favourites).

4. UI/UX and Theming
Material 3 Guidelines: The app fully embraces useMaterial3: true. Dynamic ColorScheme.fromSeed is utilized to auto-generate complementary palettes based on standard seed colors.
Adaptive Theming: Native support for switching seamlessly between light and dark modes based on ThemeMode.system.
Optimized Scrolling & Caching: Leveraging cached_network_image ensures that image fetching doesn't redownload previously viewed assets. This preserves user bandwidth and leads to silky-smooth scroll performance within dynamic grid views.
Navigation: Uses Flutter's newer Material 3 NavigationBar via a standard StatefulWidget (MainTabScreen) to flip between Search and Favourite tabs without pushing/popping routes.

5. Security & Build Considerations
API Key Management: Currently, the Pexels API key is kept within the service layer. For true production environments, it is recommended to obfuscate this via backend proxy or use --dart-define for compile-
time constants.
Launcher Icons: Uses flutter_launcher_icons to generate multi-platform app icons directly from lib/assests/icon.png._currentImages` list to empty and updating the loading state.

#### Local Persistence (`DatabaseHelper`)
We use `sqflite` rather than `shared_preferences`.
*   **Why Sqflite?** Storing a dynamic list of objects (favourited images) is safer and more queryable natively in SQLite compared to manipulating sprawling JSON strings in SharedPreferences.
*   **Lifecycle:** The database initializes and creates an `images` table when the app first launches. `AppProvider` calls `_loadFavourites()` immediately upon instantiation to ensure saved favourites persist across app restarts.
*   **Operations:** Features asynchronous `insert` (adding a favourite), `delete` (removing a favourite by ID), and `query` (fetching all favourites).

### UI/UX and Theming

*   **Material 3 Guidelines**: The app fully embraces `useMaterial3: true`. Dynamic `ColorScheme.fromSeed` is utilized to auto-generate complementary palettes based on standard seed colors.
*   **Adaptive Theming**: Native support for switching seamlessly between light and dark modes based on `ThemeMode.system`.
*   **Optimized Scrolling & Caching**: Leveraging `cached_network_image` ensures that image fetching doesn't redownload previously viewed assets. This preserves user bandwidth and leads to silky-smooth scroll performance within dynamic grid views.
*   **Navigation**: Uses Flutter's newer Material 3 `NavigationBar` via a standard `StatefulWidget` (`MainTabScreen`) to flip between Search and Favourite tabs without pushing/popping routes.

### Security & Build Considerations
*   **API Key Management**: Currently, the Pexels API key is kept within the service layer. For true production environments, it is recommended to obfuscate this via backend proxy or use `--dart-define` for compile-time constants.
*   **Launcher Icons**: Uses `flutter_launcher_icons` to generate multi-platform app icons directly from `lib/assests/icon.png`.












