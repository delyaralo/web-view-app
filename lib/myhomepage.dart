import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(title: Text('WebView App',),),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://delyaralo.com/',
      ),
    );
  }
}
