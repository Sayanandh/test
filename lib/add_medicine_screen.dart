import 'package:flutter/material.dart';
import 'add_medicine_form.dart';

class AddMedicineScreen extends StatelessWidget {
  const AddMedicineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medicine'),
      ),
      body: const Center(
        child: AddMedicineForm(),
      ),
    );
  }
}
