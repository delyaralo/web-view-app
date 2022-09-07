import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'myhomepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  Connectivity connectivity = Connectivity();

  @override
  void initState() {
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        connectivityResult = result;
      });
      log(result.name);
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  String connectivityCheck(ConnectivityResult result) {
    if (result == ConnectivityResult.wifi) {
      return "You are now connected to wifi";
    } else if (result == ConnectivityResult.mobile) {
      return "You are now connected to mobile data";
    } else if (result == ConnectivityResult.ethernet) {
      return "You are now connected to ethernet";
    } else if (result == ConnectivityResult.bluetooth) {
      return "You are now connected to bluetooth";
    } else if (result == ConnectivityResult.none) {
      return "No connection available";
    } else {
      return "No Connection!!";
    }
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: FireStoreDataBase().getData(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         return const Text(
    //           "Something went wrong",
    //         );
    //       }
    //       if (snapshot.connectionState == ConnectionState.done) {
    return AnimatedSplashScreen(
      duration: 4000,
      splashIconSize: double.infinity,
      // backgroundColor: Colors.red,
      splash: Image.asset(
        'assets/splashscreenapp.png',
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // snapshot.data.toString(),

        fit: BoxFit.cover,
      ),
      nextScreen: connectivityResult == ConnectivityResult.none
          ? Image_Connectivity()
          : MyHomePage(),
    );
  }

//           return const Center(child: null);
//         });
}

class Image_Connectivity extends StatefulWidget {
  @override
  State<Image_Connectivity> createState() => _Image_ConnectivityState();
}

class _Image_ConnectivityState extends State<Image_Connectivity> {
  String connectivityCheck(ConnectivityResult result) {
    if (result == ConnectivityResult.wifi) {
      return "You are now connected to wifi";
    } else if (result == ConnectivityResult.mobile) {
      return "You are now connected to mobile data";
    } else if (result == ConnectivityResult.ethernet) {
      return "You are now connected to ethernet";
    } else if (result == ConnectivityResult.bluetooth) {
      return "You are now connected to bluetooth";
    } else if (result == ConnectivityResult.none) {
      return "No connection available";
    } else {
      return "No Connection!!";
    }
  }

  ConnectivityResult connectivityResult = ConnectivityResult.none;
  Connectivity connectivity = Connectivity();

  void initState() {
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        connectivityResult = result;
      });
      log(result.name);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 300,
              color: Colors.red,
            ),
            Text(
              ' No internet connection  ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              ' Please Turn on Wifi or Mobile data and try again ',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  connectivityCheck(connectivityResult);
                  setState(() {
                    connectivityResult == ConnectivityResult.none
                        ? null
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                  });
                },
                child: Text('Retry again')),
          ],
        )),
      ),
    );
  }
}
