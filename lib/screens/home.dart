import 'package:flutter/material.dart';
import 'package:note/_widgets/shared/auth_wrapper.dart';
import 'package:note/screens/note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: AuthWrapper(child: NotesPage())),
    );
  }
}
