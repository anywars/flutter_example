
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class Analytics {

  static Analytics? _instance;
  static Analytics get instance {
    _instance ??= Analytics();
    return _instance!;
  }

  FirebaseAnalyticsObserver get observer {
    _analyticsObserver ??= FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
    return _analyticsObserver!;
  }

  FirebaseAnalyticsObserver? _analyticsObserver;


  Future<void> logEvent({required String name, Map<String, Object?>? params}) async {
    await FirebaseAnalytics.instance.logEvent(name: name, parameters: params);
  }

  Future<void> logScreen(String screenName) async {
    await FirebaseAnalytics.instance.setCurrentScreen(screenName: screenName);
  }

  Future<void> logAppOpen() async {
    await FirebaseAnalytics.instance.logAppOpen();
  }

  Future<void> logSignUp(String signUpMethod) async {
    await FirebaseAnalytics.instance.logSignUp(signUpMethod: signUpMethod);
  }

  Future<void> logLogin(String loginMethod, String userId) async {
    await FirebaseAnalytics.instance.logLogin(loginMethod: loginMethod);
    await FirebaseAnalytics.instance.setUserId(id: userId);
  }

}