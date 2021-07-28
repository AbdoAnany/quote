import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'provider_preferences.dart';
import 'screen/splash_screen.dart';
//import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();
  //MobileAds.instance.initialize();

  // runApp(BaseflowPluginExample(
  //     pluginName: 'Permission Handler',
  //     githubURL: 'https://github.com/Baseflow/flutter-permission-handler',
  //     pubDevURL: 'https://pub.dev/packages/permission_handler',
  //     pages: [MyAppProviderSet()]));
  runApp(MyAppProviderSet());
}

class MyAppProviderSet extends StatefulWidget {
  MyAppProviderSet();

  @override
  _MyAppProviderSetState createState() => _MyAppProviderSetState();
}

class _MyAppProviderSetState extends State<MyAppProviderSet> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MyApp(),
    );
  }
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final userPreference =
        ChangeNotifierProvider<UserPreference>((ref) => UserPreference());
    final userPreferences = watch(userPreference);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quote',
      theme: ThemeData(
        fontFamily: TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 3,
                fontWeight: FontWeight.bold)
            .fontFamily,
        primarySwatch: Colors.teal,
        primaryColor: Colors.black,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          size: 25,
          color: Color(0xff263238),
        ),
        accentColor: Color(0xff263238),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Color(0xff504944),
        accentColor: Color(0xff263238),
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}
