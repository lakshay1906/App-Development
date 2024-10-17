import 'package:add_guest/user_list.dart';
import 'package:flutter/material.dart';

class Addguestpage extends StatefulWidget {
  const Addguestpage({super.key});

  @override
  State<Addguestpage> createState() => _AddguestpageState();
}

class _AddguestpageState extends State<Addguestpage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Add Guest',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ]),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            TextField(
              controller: textController,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.9999,
              height: MediaQuery.sizeOf(context).height * 0.15,
              decoration: const BoxDecoration(color: Colors.yellow),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.03,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://kristalle.com/wp-content/uploads/2020/07/dummy-profile-pic-1.jpg',
                      width: 80,
                      height: 80,
                    ),
                  )
                ],
              ),
            ),
            const Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                UserList(),
                UserList(),
                UserList(),
                UserList(),
                UserList(),
                UserList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
