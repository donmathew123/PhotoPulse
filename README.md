# PhotoPulse

A beautifully designed Flutter application that allows users to search for images using the Pexels API, view high-resolution detailed images, and save their favourites locally.

## Features
- **Search & Discovery**: Search through the Pexels Image API with pagination support.
- **Detailed View**: View high-resolution images with photographer details and quick access to the original image on a web browser.
- **Favourites & Persistence**: Save images with the heart icon. Favourites are persisted to the device locally using a robust SQLite database and remain across app restarts.

## How to Run

1. Clone or download this repository.
2. Ensure you have Flutter installed (`flutter doctor`).
3. Run `flutter pub get` to fetch dependencies.
4. **PEXELS API KEY (Crucial Step)**: 
   - Open `lib/services/api_service.dart`.
   - Locate line 7: `static const String apiKey = 'YOUR_PEXELS_API_KEY';`
   - Replace `'YOUR_PEXELS_API_KEY'` with your actual API key to retrieve images.
5. Connect your device or emulator and run `flutter run`.

## Build Artifact (APK)
You can directly build a release APK to install on an Android device:
```bash
flutter build apk --release
```
The result will be located at: `build/app/outputs/flutter-apk/app-release.apk`

## Tech Note: Local Data Storage Approach

For local data persistence, I chose to use the `sqflite` (SQLite) package integrated with `path`. 

**Why Sqflite?**
- **Structured Data**: While packages like `shared_preferences` are great for simple key-values (like auth tokens or tiny user settings), caching a list of complex objects (User Favourites) that may scale up is best suited for a relational database. `sqflite` ensures that each saved object adheres to a strictly typed schema (`ImageModel`).
- **Reliability and Querying**: `sqflite` allows performing efficient queries (e.g., deleting by exact ID, fetching in specific orders) without parsing large, unwieldy JSON strings as you would inherently need to do in `shared_preferences` if you stored large lists.
- **State Management Integration**: To keep the UI reactive, I combined `sqflite` with `provider`. On app startup, `AppProvider` requests all records from the `DatabaseHelper`. When a user toggles a favourite, `AppProvider` instantly handles the in-memory state transition for a completely snappy, uninterrupted UI, while asynchronously syncing the action with the `sqflite` database in the background.

## UI/UX Considerations
- **State Feedback**: Proper handling of disabled buttons natively in Flutter, displaying loading indicators during network requests, and creating informative empty states.
- **Caching**: Integrated `cached_network_image` to cache image requests locally. This makes scrolling extremely smooth and limits unnecessary API calls on the network.
- **Theming**: Fully compliant with Material 3 UI constraints, beautifully accommodating system light and dark modes natively.
