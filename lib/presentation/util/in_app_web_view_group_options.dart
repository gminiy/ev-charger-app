import 'package:flutter_inappwebview/flutter_inappwebview.dart';

final InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
  crossPlatform: InAppWebViewOptions(
    useShouldOverrideUrlLoading: true,
    javaScriptEnabled: true,
    javaScriptCanOpenWindowsAutomatically: true,
  ),
  android: AndroidInAppWebViewOptions(
    useHybridComposition: true,
  ),
);
