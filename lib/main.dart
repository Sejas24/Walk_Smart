import 'package:baston_inteligente_mejorada/providers/login_form.dart';
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
    ], child: App());
  }
}

// ignore: must_be_immutable
class App extends StatelessWidget {
  SharedProvider sharedProvider = SharedProvider();

  App({super.key});

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
        'register_blind': (context) => const RegisterBlind(),
        'register_parent': (context) => const RegisterParent(),
        'login': (context) => LoginScreen(sharedProvider: sharedProvider),
        'code_register_parent': (context) => const CodeRegisterParentScreen(),
        'homeblind': (context) => const HomeBlind(),
        'homeparent': (context) => const HomeParent(),
      },
      // scaffoldMessengerKey: NotificationService.messengerkey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[350],
      ),
    );
  }
}
