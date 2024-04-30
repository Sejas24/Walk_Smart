import 'package:flutter/material.dart';
import 'package:baston_inteligente_mejorada/widgets/widgets.dart';
import '../providers/shared_provider.dart';
import 'login_screen.dart';

class TipoRegistro extends StatelessWidget {
  final SharedProvider sharedProvider;

  const TipoRegistro({Key? key, required this.sharedProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: TypeRegisterBackground(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

  const ButtonRegisterBlind({Key? key, required this.sharedProvider})
      : super(key: key);

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
                  builder: (context) =>
                      LoginScreen(sharedProvider: sharedProvider),
                ),
              );
              sharedProvider.isBlind = true;
              sharedProvider.isParent = false;
            },
            child: Image.asset(
              'assets/Persona_novidente.png',
              height: 300, // Ajusta el tamaño de la imagen
              width: 300, // Ajusta el tamaño de la imagen
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

  const ButtonRegisterParent({Key? key, required this.sharedProvider})
      : super(key: key);

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
                  builder: (context) =>
                      LoginScreen(sharedProvider: sharedProvider),
                ),
              );
              sharedProvider.isParent = true;
              sharedProvider.isBlind = false;
            },
            child: Image.asset(
              'assets/Persona_novidente_familiar.png',
              height: 300, // Ajusta el tamaño de la imagen
              width: 300, // Ajusta el tamaño de la imagen
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
