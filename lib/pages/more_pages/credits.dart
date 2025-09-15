import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          "Credits",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(7)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Text(
                'This app is a part of a thesis project made by two students ' 
                'from University of Thessaly, department of Digital Systems.\n\n'
              
                'The front end of the app along with its functionalities is made '
                'by Nikolaos Mallidis using Flutter and it is written in Dart.\n\n'
                
                'The backend of the app is made by Alexandros Kapnotidis using an '
                'SQL database and a Spring Boot API written in Kotlin',
              ),
            ),
          ),
        ),
      ),
    );
  }
}