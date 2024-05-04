import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kickflip/firebase_options.dart';
import 'package:kickflip/screens/commonElements/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KickFlip',
      home: Root(),
    );
  }
}
