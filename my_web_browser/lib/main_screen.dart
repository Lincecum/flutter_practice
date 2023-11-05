import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Web Browser'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
          // IconButton( // 아래와 같음
          //   onPressed: () {},
          //   icon: const Icon(Icons.more_vert),
          // ),
          PopupMenuButton<String>(
            onSelected: (value) {
              _webViewController.loadUrl(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'https://www.google.com',
                child: Text('구글'),
              ),
              const PopupMenuItem<String>(
                value: 'https://www.naver.com',
                child: Text('네이버'),
              ),
              const PopupMenuItem<String>(
                value: 'https://www.kakao.com',
                child: Text('카카오'),
              ),
            ],
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if(await _webViewController.canGoBack()){
            await _webViewController.goBack();
            return false;
          }
          return true;
        },
        child: WebView(
          initialUrl: 'https://flutter.dev',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            _webViewController = controller;
          },
        ),
      ),
    );
  }
}
