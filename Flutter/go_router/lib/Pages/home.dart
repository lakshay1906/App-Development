import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    bool showError = false;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 41, 41, 41),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home Page'),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter Your Phone Number',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(height: 100),
              TextField(
                controller: textController,
                cursorColor: Colors.white,
                autofocus: true,
                keyboardType: TextInputType.number,
                maxLength: 10,
                style: const TextStyle(color: Colors.white, fontSize: 21),
                decoration: const InputDecoration(
                    counter: Offstage(),
                    prefix: Text('+91 '),
                    prefixStyle: TextStyle(color: Colors.white, fontSize: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              // const SizedBox(height: 20),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    if (textController.text.length == 10) {
                      context.goNamed('otpPage');
                    } else {
                      showError = true;
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.black,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
