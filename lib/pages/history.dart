import 'package:flutter/material.dart';
import 'package:ratemybite/assets/elements/history_item.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              spacing: 10,
              children: [
                HistoryItem(),
                HistoryItem(),
                HistoryItem(),
              ],
            ),
          ),
        ),
      )
    );
  }
}
