import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:web_view_store/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context,child)=>
          ResponsiveWrapper.builder(
            child,maxWidth: 1200,minWidth: 480,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(
                600,name: MOBILE,),
              ResponsiveBreakpoint.resize(
                800,name: TABLET,),
              ResponsiveBreakpoint.resize(
                1000,name: DESKTOP,),
            ],
            background:
            Container(color: Color(0xFFF5F35F5),),),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      title: 'WebView App',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
