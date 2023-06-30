import 'package:all_events_task/common/route_generator.dart';
import 'package:all_events_task/generated/l10n.dart';
import 'package:all_events_task/register_login/registration_page.dart';
import 'package:all_events_task/register_login/model/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viva Technologies',
      navigatorKey: GlobalKey<NavigatorState>(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter',
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.grey,
        ),
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // CountryLocalizations.delegate,
        // FormBuilderLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: MultiProvider(
        providers: [
          Provider(create: (_) => GlobalKey<FormBuilderState>()),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => UserDetails(),
            ),
          ],
          child: const RegistrationPage(),
        ),
      ),
      onGenerateRoute: RouteGenerator.generate,
    );
  }
}
