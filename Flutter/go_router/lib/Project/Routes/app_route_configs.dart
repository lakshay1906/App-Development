import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_project/Pages/home.dart';
import 'package:go_router_project/Pages/homePage.dart';
import 'package:go_router_project/Pages/otpPage.dart';

class MyRoutes {
  GoRouter router = GoRouter(routes: [
    GoRoute(
        name: 'home',
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(child: Home())),
    GoRoute(
        name: 'otpPage',
        path: '/otp_page',
        pageBuilder: (context, state) => const MaterialPage(child: Otppage())),
    GoRoute(
        name: 'homePage',
        path: '/home_page',
        pageBuilder: (context, state) => const MaterialPage(child: Homepage())),
  ]);
}
