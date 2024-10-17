import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/Provider/demo_provider.dart';
import 'package:qr_code_scanner/Router/app_routes.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DemoProvider(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: myRouter,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // final pro = Provider.of<DemoProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 28, 28),
      body: SafeArea(
          child: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(0.0, -1),
            child: OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                fixedSize: const WidgetStatePropertyAll(Size(100, 15)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                side: const WidgetStatePropertyAll(
                  BorderSide(color: Colors.yellow),
                ),
                padding: const WidgetStatePropertyAll(
                    EdgeInsets.zero), // Remove default padding
              ),
              child: const Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0.0, vertical: 0.0), // Custom padding
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Pending',
                      style: TextStyle(color: Colors.yellow),
                    ),
                    SizedBox(width: 0), // Space between label and icon
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.yellow,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

// Container(
//               width: 110,
//               height: 30,
//               color: Colors.yellow,
//             )

// Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Home Page',
//           style: TextStyle(fontSize: 24, color: Colors.black),
//         ),
//         backgroundColor: Colors.blue.shade400,
//       ),
//       body: Column(
//         mainAxisSize: MainAxisSize.max,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//               onPressed: () {
//                 context.pushNamed('page1');
//               },
//               child: const Text('Add Name')),
//           const SizedBox(
//             height: 100,
//           ),
//           SizedBox(
//             height: 300,
//             child: ListView(
//               children: [
//                 ...pro.name.map((ele) {
//                   return Text(
//                     ele,
//                     style: TextStyle(),
//                   );
//                 })
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 100,
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 context.pushNamed('page2');
//               },
//               child: const Text('GO to Page 2'))
//         ],
//       ),
//     );