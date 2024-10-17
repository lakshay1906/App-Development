import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

class AlarmNotificationScreen extends StatefulWidget {
  final AlarmSettings alarmSettings;

  const AlarmNotificationScreen({super.key, required this.alarmSettings});

  @override
  State<AlarmNotificationScreen> createState() =>
      _AlarmNotificationScreenState();
}

class _AlarmNotificationScreenState extends State<AlarmNotificationScreen> {
  void stopAlarm() async {
    await Alarm.stop(widget.alarmSettings.id);
    Navigator.pop(context);
  }

  void snooze() {
    final now = DateTime.now();
    Alarm.set(
      alarmSettings: widget.alarmSettings.copyWith(
        dateTime: DateTime(
          now.year,
          now.month,
          now.day,
          now.hour,
          now.minute,
        ).add(const Duration(minutes: 1)),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF292929),
        title: const Text("Alarm Ringing...."),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    stopAlarm();
                  },
                  child: const Text(
                    "Stop",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
              ElevatedButton(
                  onPressed: () {
                    snooze();
                  },
                  child: const Text(
                    "Snooze",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
