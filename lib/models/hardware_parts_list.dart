import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/hardware_part.dart';
import '../screens/add_part_screen.dart';
import '../screens/part_detail_screen.dart';

class HardwarePartsList extends StatefulWidget {
  @override
  _HardwarePartsListState createState() => _HardwarePartsListState();
}

class _HardwarePartsListState extends State<HardwarePartsList> {
  final List<HardwarePart> _parts = [];
  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    _fetchUserHardware();
  }

  void _fetchUserHardware() async {
    if (_currentUser != null) {
      final userHardwareSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .collection('hardware')
          .get();
      setState(() {
        _parts.clear();
        _parts.addAll(userHardwareSnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return HardwarePart(
            name: data['name'],
            description: data['description'],
            price: data['price'],
            category: data['category'],
          );
        }));
      });
    }
  }

  void _addNewPart(HardwarePart part) async {
    if (_currentUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .collection('hardware')
          .add({
        'name': part.name,
        'description': part.description,
        'price': part.price,
        'category': part.category,
      });

      // Update the local list
      setState(() {
        _parts.add(part);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PC Hardware Quotes'),
      ),
      body: const Column(
        children: [
          // Your existing code for filtering hardware parts
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPartScreen(onAdd: _addNewPart),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}