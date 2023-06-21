import 'package:flutter/material.dart';
import 'package:flutter_study/presentation/component/navigation_controls.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.url});

  final String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _webViewController;
  bool _isLoading = true;
  String _pageTitle = '';

  Future<void> _getPageTitle() async {
    final title = await _webViewController.getTitle();

    setState(() {
      _pageTitle = title ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            _getPageTitle();
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_pageTitle),
        actions: [
          NavigationControls(webViewController: _webViewController),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _isLoading
                ? const LinearProgressIndicator()
                : const SizedBox.shrink(),
            Expanded(
              child: WebViewWidget(controller: _webViewController),
            )
          ],
        ),
      ),
    );
  }
}
