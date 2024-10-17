import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/Provider/demo_provider.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<DemoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Ticket',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    pro.name.add(controller.text);
                  });
                  print(pro.name);
                  context.pushNamed('home');
                },
                child: const Text('ADD'))
          ],
        ),
      ),
    );
  }
}
