import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_project/Project/Routes/app_route_configs.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Otppage extends StatefulWidget {
  const Otppage({super.key});

  @override
  State<Otppage> createState() => _OtppageState();
}

class _OtppageState extends State<Otppage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();
    bool validateOtp = true;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 36, 36),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                context.goNamed('home');
              },
              icon: const Icon(Icons.chevron_left_outlined),
              iconSize: 30,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 45, 0),
              child: Text('OTP Page'),
            ),
            const SizedBox(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 121, 0, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your OTP',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Pinput(
              controller: otpController,
              length: 6,
              autofocus: true,
              // validator: (value) {
              //   if (value == '123456') {
              //     setState(() {
              //       validateOtp = true;
              //     });
              //   } else {}
              //   return '';
              // },
              defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
            ),
            const SizedBox(
              height: 25,
            ),
            Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () async {
                      // SharedPreferences localData = await SharedPreferences.getInstance();
                      // if (validateOtp) {
                      //   localData.setBool('isLoggedIn', true);
                      // } else {
                      //   localData.setBool('isLoggedIn', false);
                      // }
                      context.goNamed('homePage');
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
