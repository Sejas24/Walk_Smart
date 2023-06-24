import 'package:baston_inteligente_mejorada/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../providers/shared_provider.dart';
import 'login_screen.dart';

class TipoRegistro extends StatelessWidget {
  final SharedProvider sharedProvider;

  const TipoRegistro({super.key, required this.sharedProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: TypeRegisterBackground(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonRegisterBlind(sharedProvider: sharedProvider),
                  ButtonRegisterParent(sharedProvider: sharedProvider),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonRegisterBlind extends StatelessWidget {
  final SharedProvider sharedProvider;

  const ButtonRegisterBlind({super.key, required this.sharedProvider});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(63, 63, 156, 1),
      elevation: 15,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(sharedProvider: sharedProvider),
                ),
              );
              sharedProvider.isBlind = true;
              sharedProvider.isParent = false;
            },
            child: Image.asset(
              'assets/Persona_novidente.png',
              height: 250,
              width: 250,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Usuario del Baston',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonRegisterParent extends StatelessWidget {
  final SharedProvider sharedProvider;

  const ButtonRegisterParent({super.key, required this.sharedProvider});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(63, 63, 156, 1),
      elevation: 15,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(sharedProvider: sharedProvider),
                ),
              );
              sharedProvider.isParent = true;
              sharedProvider.isBlind = false;
            },
            child: Image.asset(
              'assets/Persona_novidente_familiar.png',
              height: 250,
              width: 250,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Familiar No Vidente',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
