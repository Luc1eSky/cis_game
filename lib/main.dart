import 'package:cis_game/game_data_notifier.dart';
import 'package:cis_game/top_row_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_row_main_page.dart';
import 'color_palette.dart';
import 'fields_main_page.dart';
import 'main_screen_logic.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen(),
        // global context that can be used in the app
        navigatorKey: navigatorKey,
      ),
    );
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> fullWidgetList =
        createFieldWidgets(ref.watch(gameDataNotifierProvider).fieldList);
    int topRowLength = fullWidgetList.length ~/ 2;
    List<Widget> topRowList = fullWidgetList.sublist(0, topRowLength);
    topRowList.add(const Spacer());
    List<Widget> bottomRowList = fullWidgetList.sublist(topRowLength);

    return Scaffold(
      backgroundColor: ColorPalette().backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const Expanded(
                  flex: 1,
                  child: TopRowMainPage(),
                ),
                Expanded(
                  flex: 2,
                  child: FractionallySizedBox(
                    heightFactor: 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: createForecastWidgets(
                          ref.watch(gameDataNotifierProvider).currentForecast),
                    ),
                  ),
                ),
                FieldsMainPage(
                    topRowList: topRowList, bottomRowList: bottomRowList),
                const Spacer(),
                const BottomRowMainPage(),
              ],
            ),
            if (ref.watch(gameDataNotifierProvider).isNewSeason == true)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                  child: AlertDialog(
                    title: const Text('Weather Forecast'),
                    content: Image.asset('assets/images/tv_forecast.png'),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(gameDataNotifierProvider.notifier)
                              .setSeasonToCurrent();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
