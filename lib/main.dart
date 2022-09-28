import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:web_view_store/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(
            600,
            name: MOBILE,
          ),
          const ResponsiveBreakpoint.resize(
            800,
            name: TABLET,
          ),
          const ResponsiveBreakpoint.resize(
            1000,
            name: DESKTOP,
          ),
        ],
        background: Container(
          color: Color(0xfff5f35f5),
        ),
      ),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      title: 'Asankary App',
      theme: ThemeData(
        primaryColor: Colors.orangeAccent,
      ),
      home: const SplashScreen(),
    );
  }
}
