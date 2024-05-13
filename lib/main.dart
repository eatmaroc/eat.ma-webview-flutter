import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView with Link Handling and Back Button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyWebView(title: 'WebView'),
    );
  }
}


class MyWebView extends StatefulWidget {
  const MyWebView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late WebViewController _controller;
  final _initialUrl = 'https://www.eat.ma/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        margin: const EdgeInsets.only(top: 26),



      child: WillPopScope(
        onWillPop: () async {
          if (await _controller.canGoBack()) {
            _controller.goBack();
            return false; // Prevent the app from closing
          }
          return true; // Let the app close if WebView cannot go back
        },
        child: WebView(
          initialUrl: _initialUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
          navigationDelegate: (NavigationRequest request) {
            final url = request.url;
            if (url.startsWith('https://www.eat.ma/')) {
              // Charger l'URL dans la WebView
              return NavigationDecision.navigate;
            } else {
              // Ouvrir les URL externes dans le navigateur par défaut
              launchUrl(Uri.parse(url)); // Utilisation directe de la fonction launch sans le wrapper launchExternalUrl
              return NavigationDecision.prevent;
            }
          },
        ),
      ),
    )
    );
  }

}
