import 'package:baston_inteligente_mejorada/providers/blind_provider.dart';
import 'package:baston_inteligente_mejorada/providers/parent_provider.dart';
import 'package:baston_inteligente_mejorada/providers/shared_provider.dart';
import 'package:baston_inteligente_mejorada/widgets/code_register_parent.dart';
import 'package:baston_inteligente_mejorada/widgets/login_screen.dart';
import 'package:baston_inteligente_mejorada/widgets/register_parent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/widgets.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => SharedProvider()),
    ], child: const App());
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  SharedProvider sharedProvider = SharedProvider();
  BlindProvider blindProvider = BlindProvider();
  ParentProvider parentProvider = ParentProvider();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APP Monitoreo',
      initialRoute: 'tiperegister',
      routes: {
        'tiperegister': (context) => TipoRegistro(
              sharedProvider: sharedProvider,
            ),
        'register_blind': (context) => RegisterBlind(
              blindProvider: blindProvider,
              sharedProvider: sharedProvider,
            ),
        'register_parent': (context) => RegisterParent(
              sharedProvider: sharedProvider,
              parentProvider: parentProvider,
            ),
        'login': (context) => LoginScreen(
              sharedProvider: sharedProvider,
            ),
        'code_register_parent': (context) => CodeRegisterParentScreen(
              sharedProvider: sharedProvider,
              parentProvider: parentProvider,
            ),
        'homeblind': (context) => HomeBlind(
              sharedProvider: sharedProvider,
              blindProvider: blindProvider,
            ),
        'homeparent': (context) => HomeParent(
              sharedProvider: sharedProvider,
              parentProvider: parentProvider,
            ),
      },
      //scaffoldMessengerKey: NotificationService.messengerkey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[350],
      ),
    );
  }
}
