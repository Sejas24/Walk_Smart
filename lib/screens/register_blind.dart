import 'package:baston_inteligente_mejorada/utils/decoration.dart';
import 'package:baston_inteligente_mejorada/screens/background_screens.dart';
import 'package:baston_inteligente_mejorada/screens/card_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/blind_model.dart';
import '../services/services.dart';
import 'code_user_baston.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class RegisterBlind extends StatelessWidget {
  final BlindProvider blindProvider;
  final SharedProvider sharedProvider;
  const RegisterBlind(
      {super.key, required this.blindProvider, required this.sharedProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Nueva Cuenta No Vidente',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider.value(
                      value: blindProvider,
                      child: _BlindRegisterForm(
                          sharedProvider: sharedProvider,
                          blindProvider: blindProvider),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(
                    Colors.indigo.withOpacity(0.6),
                  ),
                  shape: WidgetStateProperty.all(const StadiumBorder()),
                ),
                child: const Text(
                  '¿Ya tienes una cuenta?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BlindRegisterForm extends StatelessWidget {
  final SharedProvider sharedProvider;
  final BlindProvider blindProvider;

  const _BlindRegisterForm(
      {required this.sharedProvider, required this.blindProvider});

  @override
  Widget build(BuildContext context) {
    //var confirmePass = "";
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Pedro',
              labelText: 'Nombre',
              prefixIcon: Icons.person,
            ),
            onChanged: (value) => blindProvider.currentBlind.name = value,
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Rodriguez',
              labelText: 'Apellido',
              prefixIcon: Icons.person_outline_rounded,
            ),
            onChanged: (value) => blindProvider.currentBlind.lastName = value,
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'pepito@host.com',
              labelText: 'Correo Electrónico',
              prefixIcon: Icons.email,
            ),
            onChanged: (value) => sharedProvider.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El correo electrónico no es válido';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: '********',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock,
            ),
            onChanged: (value) => sharedProvider.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe tener al menos 6 caracteres';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: '********',
              labelText: 'Confirmar Contraseña',
              prefixIcon: Icons.lock,
            ),
            validator: (value) {
              return (value == null || value.length < 6)
                  ? 'La contraseña debe tener al menos 6 caracteres'
                  : value != sharedProvider.password
                      ? 'Las contraseñas no coinciden'
                      : null;
            },
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centra los botones horizontalmente
            children: [
              Expanded(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width * 0.04,
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: const Text(
                      'Volver',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _IngresarButton(
                    sharedProvider: sharedProvider,
                    blindProvider: blindProvider),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IngresarButton extends StatelessWidget {
  final SharedProvider sharedProvider;
  final BlindProvider blindProvider;

  const _IngresarButton(
      {Key? key, required this.sharedProvider, required this.blindProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          disabledColor: Colors.grey,
          elevation: 0,
          color: Colors.deepPurple,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width * 0.04,
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Text(
              sharedProvider.isLoading ? 'Espere' : 'Ingresar',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          onPressed: () async {
            FocusScope.of(context).unfocus();
            if (!sharedProvider.isValidForm(formKey)) return;

            sharedProvider.isLoading = true;

            Future.delayed(const Duration(seconds: 2));

            sharedProvider.isLoading = false;

            try {
              final credential =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: sharedProvider.email,
                password: sharedProvider.password,
              );

              if (credential.user != null && context.mounted) {
                Blind blind = Blind(
                  name: blindProvider.currentBlind.name,
                  lastName: blindProvider.currentBlind.lastName,
                  email: sharedProvider.email,
                  codeBlind: credential.user!.uid.substring(0, 7),
                  altitud: blindProvider.currentBlind.altitud,
                  latitud: blindProvider.currentBlind.latitud,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CodeBlindScreen(
                      code: credential.user?.uid.substring(0, 7),
                      blindProvider: blindProvider,
                    ),
                  ),
                );
                blindProvider.postNewBlindUser(blind);
              }
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }
          },
        ),
      ],
    );
  }
}
