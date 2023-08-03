import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';


abstract class BaseWebController extends GetxController {
  late final PlatformWebViewControllerCreationParams _params =
    (WebViewPlatform.instance is WebKitWebViewPlatform) ?
      WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      ) :
      PlatformWebViewControllerCreationParams();

  late final _wc = WebViewController.fromPlatformCreationParams(_params)
    ..setNavigationDelegate(NavigationDelegate(
      onUrlChange: onUrlChange,
      onNavigationRequest: onNavigationRequest,
      onWebResourceError: onWebResourceError,
      onPageFinished: onPageFinished,
      onPageStarted: onPageStarted,
      onProgress: onProgress,
    ))
    ..addJavaScriptChannel('Example', onMessageReceived: _onMessageReceived);
  WebViewController get wc => _wc;

  onProgress(int progress) {}
  onPageStarted(String url) {}
  onPageFinished(String url) {}
  onWebResourceError(WebResourceError error) {}
  FutureOr<NavigationDecision> onNavigationRequest(NavigationRequest request) {
    return NavigationDecision.navigate;
  }
  onUrlChange(UrlChange change) {}

  loadRequest(String url) {
    _wc.loadRequest(Uri.parse(url));
  }

  _onMessageReceived(JavaScriptMessage message) {

  }

  addJavaScriptChannel(String name, {
    required void Function(JavaScriptMessage) onMessageReceived
  }) => _wc.addJavaScriptChannel(name, onMessageReceived: onMessageReceived);

  @override
  void onInit() {
    final platform = _wc.platform;
    if (platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(kDebugMode);
      platform.setMediaPlaybackRequiresUserGesture(false);
    }
    super.onInit();
  }

}