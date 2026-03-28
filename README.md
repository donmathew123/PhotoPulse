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











