import 'package:doc_manager/presentation/bloc/Home/home_bloc.dart';
import 'package:doc_manager/presentation/bloc/Login/login_bloc.dart';
import 'package:doc_manager/presentation/bloc/Profile/profile_bloc.dart';
import 'package:doc_manager/presentation/screens/home/home_screen.dart';
import 'package:doc_manager/presentation/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'core/di.dart' as di;
import 'core/services/app_settings.dart';
import 'core/services/session_helper.dart';
import 'data/app_data/app_config.dart';
import 'data/app_data/app_localizations.dart';
import 'data/app_data/app_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  AppConfig(SourceConfig.prod);
  await SessionHelper.init();
  HiveSingleton.instance = await Hive.openBox('login');

  String _route = SessionHelper.isLoggedIn ? "/home" : "/login";

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppSettings>(create: (_) => AppSettings()),
      ],
      child: MultiBlocProvider(
        child: LandingScreen(initialRoute: _route),
        providers: [
          BlocProvider(
            create: (context) => di.di<LoginBloc>(),
          ),
          BlocProvider(
            create: (context) => di.di<HomeBloc>(),
          ),
          BlocProvider(
            create: (context) => di.di<ProfileBloc>(),
          ),
        ],
      ),
    ),
  );
}

class LandingScreen extends StatelessWidget {
  final String? initialRoute;

  const LandingScreen({Key? key, this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kSwatch[900],
      ),
    );
    return Consumer<AppSettings>(
      builder: (_, AppSettings settings, __) {
        AppTheme appTheme = AppTheme(settings);
        return MaterialApp(
          theme: appTheme.theme,
          darkTheme: appTheme.darkTheme,
          themeMode: settings.themeMode,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('hi', 'IN'),
          ],
          locale: settings.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          routes: {
            '/home': (context) => const HomeScreen(),
            '/login': (context) => const LoginScreen(),
          },
          debugShowCheckedModeBanner: false,
          initialRoute: /*initialRoute ?? */
              (SessionHelper.sessionUser != null &&
                      SessionHelper.sessionUser!.mobile != null)
                  ? '/home'
                  : "/login",
        );
      },
    );
  }
}
