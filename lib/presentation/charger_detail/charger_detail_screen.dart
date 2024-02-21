import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charger_app/presentation/util/in_app_web_view_group_options.dart';

class ChargerDetailScreen extends StatefulWidget {
  final String _chargerId;
  final String _userId;
  final String _location;

  const ChargerDetailScreen({
    super.key,
    required String chargerId,
    required String userId,
    required String location,
  })  : _chargerId = chargerId,
        _userId = userId,
        _location = location;

  @override
  State<ChargerDetailScreen> createState() => _ChargerDetailScreenState();
}

class _ChargerDetailScreenState extends State<ChargerDetailScreen> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._location),
          titleTextStyle: const TextStyle(
            fontSize: 21,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: PopScope(
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
              url: Uri.parse('http://192.168.50.116:3000'),
            ),
            initialOptions: options,
            onWebViewCreated: (controller) {
              webViewController = controller;
              controller.addJavaScriptHandler(
                handlerName: 'initDataHandler',
                callback: (args) {
                  final data = jsonEncode(
                    {
                      "chargerId": widget._chargerId,
                      "userId": widget._userId,
                    },
                  );

                  return data;
                },
              );
            },
          ),
        ));
  }
}
