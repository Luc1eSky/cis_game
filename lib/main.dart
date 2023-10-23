import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pwa_install/pwa_install.dart';
import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';
import 'localData/sembastDataRepository.dart';
import 'main_screen/main_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // make sure that everything is initialized (e.g. all assets are ready)
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // removes the # in front of the web address
    setPathUrlStrategy();
    debugPrint("its a web app");
    //document.documentElement?.requestFullscreen();

    // setup PWA install
    PWAInstall().setup();

    // check if install prompt is available
    // PWA e.g. should not show the prompt
    if (PWAInstall().installPromptEnabled) {
      try {
        PWAInstall().promptInstall_();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  // TODO: show loading animation for startup
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ),
  );

  // TODO: initialize local database
  //await Future.delayed(const Duration(seconds: 2));
  final localDataRepository = await SembastDataRepository.makeDefault();
  print('sambast initialized');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print('firebase initialized');

  // start up
  runApp(
    ProviderScope(
      overrides: [
        localDataRepositoryProvider.overrideWithValue(localDataRepository),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
      // global context that can be used in the app
      navigatorKey: navigatorKey,
    );
  }
}
