import 'package:flutter/material.dart';
import 'package:pc_hardware_app/models/hardware_part.dart';

class PartDetailScreen extends StatelessWidget {
  final HardwarePart part;

  PartDetailScreen({required this.part});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(part.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              part.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(part.description),
            SizedBox(height: 8.0),
            Text(
              '\$${part.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
