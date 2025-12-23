import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jura/controllers/provider/user.provider.dart';
import 'package:provider/provider.dart'; 
import 'package:jura/firebase_options.dart';
import 'package:jura/jura_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp( 
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
      ],
      child: const JurApp(),
    ),
  );;
}
