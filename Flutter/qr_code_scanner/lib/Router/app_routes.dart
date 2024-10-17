import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/main.dart';
import 'package:qr_code_scanner/page_1.dart';
import 'package:qr_code_scanner/page_2.dart';

final myRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/', name: 'home', builder: (context, state) => const MyHomePage()),
  GoRoute(
      path: '/page1',
      name: 'page1',
      builder: (context, state) => const Page1()),
  GoRoute(
      path: '/page2', name: 'page2', builder: (context, state) => const Page2())
]);
