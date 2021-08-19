
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class Analytics {
  Analytics._({required this.analytics});

  static Analytics? _instance;
  static Analytics get instance {
    _instance ??= Analytics._(analytics: FirebaseAnalytics());
    return _instance!;
  }

  FirebaseAnalyticsObserver get _observer {
    return _analyticsObserver ??= FirebaseAnalyticsObserver(analytics: analytics);
  }

  FirebaseAnalytics analytics;
  FirebaseAnalyticsObserver? _analyticsObserver;


  Future<void> logEvent(String name) async {
    await analytics.logEvent(name: name);
  }

  Future<void> logAppOpen() async {
    await analytics.logAppOpen();
  }

  Future<void> logSignUp(String signUpMethod) async {
    await analytics.logSignUp(signUpMethod: signUpMethod);
  }

  Future<void> logLogin(String loginMethod, String userId) async {
    await analytics.logLogin(loginMethod: loginMethod);
    await analytics.setUserId(userId);
  }

}