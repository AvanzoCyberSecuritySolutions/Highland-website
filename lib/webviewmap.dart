import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Import webview_flutter

class WebviewMap extends StatefulWidget {
  const WebviewMap({super.key});

  @override
  State<WebviewMap> createState() => _WebviewMapState();
}

class _WebviewMapState extends State<WebviewMap> {
  late WebViewController
      _webViewController; // Use WebViewController for controlling the WebView
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    // Initialize WebView
    // Ensure WebView is initialized
    WebView.platform = SurfaceAndroidWebView(); // For Android WebView
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To find here'),
        actions: <Widget>[
          // Reload Button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Reload the WebView
              _webViewController.reload();
            },
          ),
        ],
      ),
      body: WebView(
        initialUrl:
            'https://www.google.com/maps/place/Highland+Hospital/@12.8664995,74.8546887,890m/data=!3m2!1e3!4b1!4m6!3m5!1s0x3ba35a34c13203f9:0xfb2782cbf31a7784!8m2!3d12.8664995!4d74.8546887!16s%2Fg%2F1thcl645?entry=ttu&g_ep=EgoyMDI0MTIxMS4wIKXMDSoASAFQAw%3D%3Dm', // Set initial URL
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController =
              webViewController; // Initialize the WebViewController
        },
        onPageStarted: (String url) {
          setState(() {
            _isLoading =
                true; // Show loading indicator when the page starts loading
          });
        },
        onPageFinished: (String url) {
          setState(() {
            _isLoading =
                false; // Hide loading indicator once the page finishes loading
          });
        },
      ),
      // Optionally, show a loading indicator while the page is loading
      floatingActionButton:
          _isLoading ? CircularProgressIndicator() : Container(),
    );
  }
}
