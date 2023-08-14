import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late WebViewController _controller;
  bool _isLoading = true;
  double _progress = 0.0;

  @override
  void initState() {
    PlatformWebViewControllerCreationParams params =
        const PlatformWebViewControllerCreationParams();

    if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      params = AndroidWebViewControllerCreationParams
          .fromPlatformWebViewControllerCreationParams(
        params,
      );
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    Uri parsedUri = Uri.parse(widget.url);

    // If no scheme is provided, assume http
    if (parsedUri.scheme.isEmpty) {
      parsedUri = parsedUri.replace(scheme: 'http');
    }

    // Remove 'www' subdomain if present
    if (parsedUri.host.startsWith('www.')) {
      parsedUri = parsedUri.replace(host: parsedUri.host.substring(4));
    }

    final fixedurl = parsedUri.toString();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print('progress : $progress, loading : $_isLoading');
            setState(() {
              _progress = progress * 0.01;
              if (progress == 100) {
                _isLoading = false;
              }
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(fixedurl));
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    _controller = controller;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_isLoading)
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: LinearProgressIndicator(
                  value: _progress,
                ),
              ),
            )
          : WebViewWidget(
              controller: _controller,
            ),
    );
  }
}
