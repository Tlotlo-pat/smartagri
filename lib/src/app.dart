import 'package:flutter/material.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartagri/src/controllers/auth.dart';
import 'package:smartagri/src/forms/sign_in_form.dart';
import 'package:smartagri/src/forms/sign_up_form.dart';

import 'package:smartagri/src/controllers/auth.dart';

import 'package:smartagri/src/forms/sign_in_form.dart';
import 'package:smartagri/src/forms/sign_up_form.dart';
import 'package:smartagri/src/theme.dart';
import 'package:smartagri/src/views/auth/sign_in.dart';
import 'package:smartagri/src/views/auth/sign_up.dart';

import 'package:smartagri/src/views/home/home_screen.dart';
import 'package:smartagri/src/views/home/map.dart';

//import 'package:stepping_stones/src/views/profile/profile.dart';

import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class App extends StatefulWidget {
  const App({
    Key? key,
    required this.settingsController,
    required this.auth,
  }) : super(key: key);

  final SettingsController settingsController;
  final Auth auth;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // final Auth auth = Auth();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>.value(value: widget.auth),
        ChangeNotifierProvider<SignInForm>(
          create: (c) => SignInForm(widget.auth),
        ),
        ChangeNotifierProvider<CreateProfileForm>(
          create: (c) => CreateProfileForm(widget.auth),
        ),
      ],
      child: MaterialApp(
        // Providing a restorationScopeId allows the Navigator built by the
        // MaterialApp to restore the navigation stack when a user leaves and
        // returns to the app after it has been killed while running in the
        // background.
        restorationScopeId: 'app',

        // Provide the generated AppLocalizations to the MaterialApp. This
        // allows descendant Widgets to display the correct translations
        // depending on the user's locale.
        localizationsDelegates: const [
          //AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ],

        // Use AppLocalizations to configure the correct application title
        // depending on the user's locale.
        //
        // The appTitle is defined in .arb files found in the localization
        // directory.
        // onGenerateTitle: (BuildContext context) =>
        //     AppLocalizations.of(context)!.appTitle,

        // Define a light and dark color theme. Then, read the user's
        // preferred ThemeMode (light, dark, or system default) from the
        // SettingsController to display the correct theme.
        theme: theme,
        //darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        //themeMode: settingsController.themeMode,

        // Define a function to handle named routes in order to support
        // Flutter web url navigation and deep linking.
        onGenerateRoute: (RouteSettings routeSettings) {
          Widget page = const SignIn();
          //Auth auth = Provider.of<Auth>(context, listen: false);
          //ArticleController().fetchArticles();

          return MaterialPageRoute<void>(
            settings: routeSettings,
            maintainState: true,
            builder: (BuildContext context) {
              switch (routeSettings.name) {
                case SignUp.routeName:
                  page = SignUp();
                  break;
                case SignIn.routeName:
                  page = const SignIn();
                  break;
                case MapD.routeName:
                  page = const MapD();
                  break;
                case HomeScreenView.routeName:
                  // ignore: prefer_const_constructors
                  page = HomeScreenView(
                    text: '',
                  );
                  break;

                default:
                  page = const SignIn();
                  break;
              }

              return Scaffold(
                body: page,
              );
            },
          );
        },
      ),
    );
  }
}
