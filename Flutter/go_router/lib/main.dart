import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_project/Project/Routes/app_route_configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIsLoggedIn();
  }

  void getIsLoggedIn() async {
    SharedPreferences localData = await SharedPreferences.getInstance();
    bool isLoggedIn = localData.getBool('isLoggedIn')!;
    isLoggedIn == true ? context.goNamed('/homePage') : null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: MyRoutes().router,
    );
  }
}
