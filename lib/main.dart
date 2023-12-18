import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:health_vista_pro/Localization/localizations.dart';
import 'package:health_vista_pro/firebase_options.dart';
import 'package:health_vista_pro/provider/providers.dart';
import 'package:health_vista_pro/services/services.dart';
import 'package:provider/provider.dart';

import 'bloc/blocs.dart';
import 'pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance
      // Your personal reCaptcha public key goes here:
      .activate(
    androidProvider: AndroidProvider.debug,
  );

  await DbHelper.initDb();
  await SharedPrefs.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      initialData: null,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PageBloc()..add(GoToWelcomePage()),
          ),
          BlocProvider(
            create: (context) => UserBloc(),
          ),
          BlocProvider(create: (context) => ThemeBloc())
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
              ChangeNotifierProvider(create: (_) => UserProvider()),
              ChangeNotifierProvider(create: (_) => LocalizationController()),
            ],
            child: MaterialApp(
              navigatorKey: navkey,
              debugShowCheckedModeBanner: false,
              locale: View.of(context).platformDispatcher.locale,
              supportedLocales: LocalizationService.supportedLocales,
              localizationsDelegates: LocalizationService.localizationsDelegate,
              theme: themeState.themeData,
              home: Wrapper(),
            ),
          ),
        ),
      ),
    );
  }
}
