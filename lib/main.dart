import 'package:agrihealth/screens/homeScreen.dart';
import 'package:agrihealth/screens/splashScreen.dart';
import 'package:agrihealth/utils/nativeTheme.dart';
import 'package:agrihealth/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();




  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
 // final String routeName = "main";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agric Health',

        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: "login",
      theme: nativeTheme(),
      home:  SplashScreen()
    );
  }
}

