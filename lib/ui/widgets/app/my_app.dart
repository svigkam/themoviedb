import 'package:flutter/material.dart';
import 'package:themoviedb/Libarary/Widgets/Inherited/provider.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:themoviedb/ui/widgets/app/my_app_model.dart';

class MyApp extends StatelessWidget {
  // final MyAppModel model;
  static final mainNavigation = MainNavigation();
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.read<MyAppModel>(context);
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ru', 'RU'),
      ],
      debugShowCheckedModeBanner: false,
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model?.isAuth == true),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
