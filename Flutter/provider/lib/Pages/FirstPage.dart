import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/Provider/counter_provider.dart';

// class Firstpage extends StatefulWidget {
//   const Firstpage({super.key});

//   @override
//   State<Firstpage> createState() => _FirstpageState();
// }

class Firstpage extends ConsumerWidget {
  Firstpage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final providerFunction = ref.watch(providerFunc);
    // print(providerFunction);
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Radhe Radhe',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
