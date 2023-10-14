import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pwa_install/pwa_install.dart';

import 'main_screen/main_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  //if (kIsWeb) {
  //   // removes the # in front of the web address
  //   setPathUrlStrategy();
  //debugPrint("its a web app");
  //document.documentElement?.requestFullscreen();
  //}

  // make sure that everything is initialized (e.g. all assets are ready)
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(const ProviderScope(child: MyApp()));
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
