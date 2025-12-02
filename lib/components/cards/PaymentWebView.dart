import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:lottie/lottie.dart';

class PaymentWebViewe extends StatefulWidget {
  final String url;

  const PaymentWebViewe({super.key, required this.url, required String userId});

  @override
  State<PaymentWebViewe> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebViewe> {
  bool isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                setState(() {
                  isLoading = true;
                });
              },
              onPageFinished: (url) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Paiement",
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            Container(
              color: Colors.white,
              child: Center(
                child: Lottie.asset(
                  'assets/lottie/progess.json', // ton animation
                  width: 180,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
            ),
        ],
      ),
    );
  }
}



/*

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:html' as html; // seulement pour le web

class PaymentWebViewe extends StatefulWidget {
  final String url;

  const PaymentWebViewe({super.key, required this.url});

  @override
  State<PaymentWebViewe> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebViewe> {
  bool isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (_) => setState(() => isLoading = true),
            onPageFinished: (_) => setState(() => isLoading = false),
          ),
        )
        ..loadRequest(Uri.parse(widget.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // Pour le web, ouvrir le lien dans un nouvel onglet
      html.window.open(widget.url, "_blank");
      return const Scaffold(
        body: Center(
          child: Text("WebView non supporté sur le Web, ouverture dans un nouvel onglet."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Paiement")),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
*/ 