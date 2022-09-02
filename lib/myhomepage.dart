import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;

  loading() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  @override
  initState() {
    super.initState();
    loading();
  }

  late WebViewController controller;

  @override
  Widget build(BuildContext context) => isLoading
      ? buildSpinKitWanderingCubes()
      : WillPopScope(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            body: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'https://asankary.com/ku/',
              onWebViewCreated: (controller) => this.controller = controller,
            ),
          ),
          onWillPop: () async {
            return false;
          });

  Scaffold buildSpinKitWanderingCubes() {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SpinKitCircle(
        color: Colors.orangeAccent,
        size: 140,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
