import 'package:flights_app/constants.dart';
import 'package:flights_app/models/title_model.dart';
import 'package:flights_app/screens/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => TitleModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ru'),
        ],
        locale: const Locale('ru'),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          bottomSheetTheme: const BottomSheetThemeData(backgroundColor: grey8),
          scaffoldBackgroundColor: black,
          canvasColor: black,
          useMaterial3: true,
        ),
        home: const BottomBar(
          selectedPage: 0,
        ));
  }
}
