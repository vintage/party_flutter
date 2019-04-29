import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static FirebaseAnalytics analytics = FirebaseAnalytics();

  static logEvent(String name, Map<String, dynamic> parameters) {
    analytics.logEvent(name: name, parameters: parameters);
  }
}
