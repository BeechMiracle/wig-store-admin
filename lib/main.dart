import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1_admin/constants.dart';
import 'package:untitled1_admin/error%20message.dart';
import 'package:untitled1_admin/login%20screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Screens page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: kButtonColor,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Something went wrong!',
                style: kTitleTextStyle,
              ),
            );
          } else if (snapshot.hasData) {
            return const Screens();
          } else {
            return const AdminLogin();
          }
        },
      ),
      routes: {
        'login_screen': (context) => const AdminLogin(),
        'screen_page': (context) => const Screens(),
      },
    );
  }
}
