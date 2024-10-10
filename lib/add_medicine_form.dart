import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class AddMedicineForm extends StatefulWidget {
  const AddMedicineForm({super.key}); // Updated to use super parameter

  @override
  _AddMedicineFormState createState() => _AddMedicineFormState();
}

class _AddMedicineFormState extends State<AddMedicineForm> {
  final _medicineNameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _frequencyController = TextEditingController();
  final _timeController = TextEditingController();

  List<String> medicineHistory = [];
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  void initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin!.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(String medicineName) async {
    var scheduledTime = tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)); // For testing
    await flutterLocalNotificationsPlugin!.zonedSchedule(
      0,
      'Time to take your medicine',
      'Don\'t forget to take $medicineName',
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          // 'your_channel_description',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exact, // Updated to avoid deprecated use
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void _addMedicine() {
    String medicineName = _medicineNameController.text;
    String dosage = _dosageController.text;
    String frequency = _frequencyController.text;
    String time = _timeController.text;

    // Schedule notification
    scheduleNotification(medicineName);

    // Add to medicine history
    setState(() {
      medicineHistory.add('$medicineName - $dosage - $frequency - $time');
    });

    // Clear input fields
    _medicineNameController.clear();
    _dosageController.clear();
    _frequencyController.clear();
    _timeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _medicineNameController,
            decoration: const InputDecoration(labelText: 'Medicine Name'), // Use const
          ),
          TextField(
            controller: _dosageController,
            decoration: const InputDecoration(labelText: 'Dosage'), // Use const
          ),
          TextField(
            controller: _frequencyController,
            decoration: const InputDecoration(labelText: 'Frequency (e.g., Daily)'), // Use const
          ),
          TextField(
            controller: _timeController,
            decoration: const InputDecoration(labelText: 'Time (HH:MM)'), // Use const
          ),
          ElevatedButton(
            onPressed: _addMedicine,
            child: const Text('Add Medicine'), // Use const
          ),
          Expanded(
            child: ListView.builder(
              itemCount: medicineHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(medicineHistory[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
