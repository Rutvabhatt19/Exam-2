import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app_with_opps/Provider.dart';
import 'package:firebase_chat_app_with_opps/Splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  late FirebaseApp app;
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDsfg0cvEj8suwU_J1ql0ZWoXCUHWlzhks',
          appId: '1:814995435510:android:0fdb44971a3eeb5e71a1d7',
          messagingSenderId: '',
          projectId: 'chattapp-c5fe5'));
  await GetStorage.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => NameProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: GetStorage().read("appTheme") == true
          ? ThemeMode.dark
          : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
