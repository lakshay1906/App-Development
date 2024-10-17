import 'dart:async';
import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lb_alarm/alarm_notification_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  runApp(const AlarmApp());
}

class AlarmApp extends StatelessWidget {
  const AlarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AlarmHomePage(),
    );
  }
}

class AlarmHomePage extends StatefulWidget {
  const AlarmHomePage({super.key});

  @override
  State<AlarmHomePage> createState() => _AlarmHomePageState();
}

class _AlarmHomePageState extends State<AlarmHomePage> {
  AlarmSettings? alarmSettings;
  static StreamSubscription<AlarmSettings>? subscription;

  List<dynamic> alarms = [];
  bool isEnabled = true;

  @override
  void initState() {
    super.initState();
    checkAndroidNotificationPermission();
    checkAndroidScheduleExactAlarmPermission();
    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(navigateToRingScreen);
  }

  Future<void> checkAndroidNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      alarmPrint('Requesting notification permission...');
      final res = await Permission.notification.request();
      alarmPrint(
        'Notification permission ${res.isGranted ? '' : 'not '}granted',
      );
    }
  }

  Future<void> checkAndroidScheduleExactAlarmPermission() async {
    if (Platform.isAndroid) {
      // Check Android version compatibility
      if (await Permission.scheduleExactAlarm.isRestricted) {
        print('Schedule exact alarm is restricted on this device.');
        return;
      }

      final status = await Permission.scheduleExactAlarm.status;
      print('Schedule exact alarm permission: $status.');

      if (status.isDenied) {
        print('Requesting schedule exact alarm permission...');
        final res = await Permission.scheduleExactAlarm.request();
        print(
            'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.');
      }
    } else {
      print("This permission is only available on Android devices.");
    }
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  Future<void> audioPicker() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    print("picker 1:: $pickedFile");
    if (pickedFile != null) {
      String filePath = pickedFile.files.single.path!;
      print("picker 2:: $filePath");
      final DateTime time = DateTime(2024, 10, 17, 6, 50);
      if (filePath.endsWith(".mp3")) {
        alarmSettings = AlarmSettings(
          id: 1,
          dateTime: time,
          assetAudioPath: filePath,
          loopAudio: true,
          vibrate: true,
          volume: 0.8,
          fadeDuration: 3.0,
          notificationSettings:
              const NotificationSettings(title: "Wake Up", body: "Alarm Body"),
        );
        await Alarm.set(
            alarmSettings: alarmSettings ?? AlarmSettings.fromJson({}));
        loadAlarms();
      }
    }
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) =>
            AlarmNotificationScreen(alarmSettings: alarmSettings),
      ),
    );
    loadAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white, size: 28),
            onPressed: () {
              audioPicker();
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Alarm in 11 hours 57 minutes',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const Text(
            'Fri, 18 Oct, 6:00 am',
            style: TextStyle(color: Colors.grey, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                AlarmTile(
                  time: "06:00 am",
                  label: "Jai Siya Ram ❤️❤️",
                  isEnabled: isEnabled,
                  onClick: () {
                    setState(() {
                      isEnabled = !isEnabled;
                    });
                  },
                ),
                // AlarmTile(
                //     time: "6:00 am",
                //     label: "Jai Siya Ram ❤️❤️",
                //     isEnabled: true),
                // AlarmTile(time: "6:30 am", isEnabled: true),
              ],
            ),
          ),
          const BottomNavBar(),
        ],
      ),
    );
  }
}

class AlarmTile extends StatefulWidget {
  final String time;
  final String? label;
  final bool isEnabled;
  final Function onClick;

  const AlarmTile(
      {super.key,
      required this.time,
      this.label,
      this.isEnabled = true,
      required this.onClick});

  @override
  State<AlarmTile> createState() => _AlarmTileState();
}

class _AlarmTileState extends State<AlarmTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.label != null)
                Text(
                  widget.label!,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              Text(
                widget.time,
                style: TextStyle(
                  color: widget.isEnabled ? Colors.white : Colors.grey,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Switch(
                value: widget.isEnabled,
                onChanged: (value) {
                  widget.onClick();
                },
                activeColor: Colors.purple,
                inactiveTrackColor: Colors.grey,
              ),
              const Text(
                "Every day",
                style: TextStyle(color: Colors.blueAccent, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavItem(icon: Icons.alarm, label: 'Alarm', isSelected: true),
          BottomNavItem(icon: Icons.language, label: 'World Clock'),
          BottomNavItem(icon: Icons.timer, label: 'Stopwatch'),
          BottomNavItem(icon: Icons.hourglass_bottom, label: 'Timer'),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const BottomNavItem(
      {super.key,
      required this.icon,
      required this.label,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isSelected ? Colors.white : Colors.grey),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
