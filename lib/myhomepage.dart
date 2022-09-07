import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override


  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin fltNotification;

  bool isLoading = false;

  loading() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }
  void pushFCMtoken() async {
    String? token=await messaging.getToken();
    print('===================================$token');
//you will get token here in the console
  }
  @override
  initState() {
    super.initState();

    super.initState();
    pushFCMtoken();
    initMessaging();
    loading();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Web_Link")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text('Loading'));
                  }
                  return Stack(
                    children: snapshot.data!.docs.map((element) {
                      return WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: element['link'],
                        onWebViewCreated: (controller) =>
                            this.controller = controller,
                      );
                    }).toList(),
                  );
                }),
          ),
          onWillPop: () async {
            if(await controller.canGoBack()){
              controller.goBack() ;
              return false ;
            }else{
              return true ;
            }
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
  void initMessaging() {
    var androiInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInit = IOSInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
    fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification.initialize(initSetting);
    var androidDetails =
    AndroidNotificationDetails('1', 'channelName',);
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails =
    NotificationDetails(android: androidDetails, iOS: iosDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification=message.notification;
      AndroidNotification? android=message.notification?.android;
      if(notification!=null && android!=null){
        fltNotification.show(
            notification.hashCode, notification.title, notification.body, generalNotificationDetails);
      }});}
}
