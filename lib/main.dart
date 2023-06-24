import 'package:baston_inteligente_mejorada/providers/blind_provider.dart';
import 'package:baston_inteligente_mejorada/providers/firebase_provider.dart';
import 'package:baston_inteligente_mejorada/providers/login_form.dart';
import 'package:baston_inteligente_mejorada/providers/parent_provider.dart';
import 'package:baston_inteligente_mejorada/providers/shared_provider.dart';
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
      ChangeNotifierProvider(create: (_) => LoginFormProvider()),
      ChangeNotifierProvider(create: (_) => SharedProvider()),
    ], child: const App());
  }
}

// ignore: must_be_immutable
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
            ),
        'register_parent': (context) => const RegisterParent(),
        'login': (context) => LoginScreen(sharedProvider: sharedProvider),
        'code_register_parent': (context) => const CodeRegisterParentScreen(),
        'homeblind': (context) => HomeBlind(blindProvider: blindProvider),
        'homeparent': (context) => HomeParent(),
      },
      // scaffoldMessengerKey: NotificationService.messengerkey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[350],
      ),
    );
  }
}
