import 'package:flutter/material.dart';

class MedicineListScreen extends StatelessWidget {
  const MedicineListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine List'),
      ),
      body: const Center(
        child: Text('List of medicines will be displayed here.'),
      ),
    );
  }
}
