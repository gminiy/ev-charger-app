import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

class ChargerDetailScreen extends StatefulWidget {
  final String? _chargerId;
  final String? _userId;
  final String? _location;

  const ChargerDetailScreen({
    super.key,
    String? chargerId,
    String? userId,
    String? location,
  })  : _chargerId = chargerId,
        _location = location,
        _userId = userId;

  @override
  State<ChargerDetailScreen> createState() => _ChargerDetailScreenState();
}

class _ChargerDetailScreenState extends State<ChargerDetailScreen> {
  String? chargerId;
  String? userId;
  String? location;

  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    chargerId = widget._chargerId;
    userId = widget._userId;
    location = widget._location;
  }

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      javaScriptEnabled: true,
      javaScriptCanOpenWindowsAutomatically: true,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final bool hasInitData = (userId != null && chargerId != null);

    return Scaffold(
      appBar: AppBar(
        title: Text(location == null ? '' : location!),
        titleTextStyle: const TextStyle(
          fontSize: 21,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: hasInitData
          ? PopScope(
              canPop: false,
              onPopInvoked: (didPop) async {
                final canGoBack = await webViewController?.canGoBack() ?? false;

                if (canGoBack) {
                  webViewController?.goBack();
                  return;
                }

                if (!mounted) return;

                context.pop();
                return;
              },
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse('http://10.0.2.2:3000'),
                ),
                initialOptions: options,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                  controller.addJavaScriptHandler(
                    handlerName: 'initDataHandler',
                    callback: (args) {
                      final data = jsonEncode(
                        {
                          "chargerId": chargerId,
                          "userId": userId,
                        },
                      );

                      return data;
                    },
                  );
                },
              ),
            )
          : const Center(
              child: Text('잘못된 접근입니다. 다시 시도해주세요.'),
            ),
    );
  }
}
