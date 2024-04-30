import 'package:baston_inteligente_mejorada/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';

import '../providers/shared_provider.dart';
import '../utils/decoration.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  final SharedProvider sharedProvider;
  const LoginScreen({super.key, required this.sharedProvider});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundScreen(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 250),
            CardContainer(
                child: Column(
              children: [
                const SizedBox(height: 10),
                Text('Login',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 30),
                ChangeNotifierProvider.value(
                    value: sharedProvider,
                    child: _LoginForm(sharedProvider: sharedProvider)),
              ],
            )),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () => {
                if (sharedProvider.isBlind)
                  {Navigator.pushReplacementNamed(context, 'register_blind')}
                else
                  {Navigator.pushReplacementNamed(context, 'register_parent')}
              },
              style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(Colors.indigo.withOpacity(0.6)),
                shape: MaterialStateProperty.all(const StadiumBorder()),
              ),
              child: const Text('Crear una nueva Cuenta',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    ));
  }
}

class _LoginForm extends StatelessWidget {
  final SharedProvider sharedProvider;

  const _LoginForm({required this.sharedProvider});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'sergiocordova@gmail.com',
              labelText: 'Correo  Electrónico',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Resize(
                builder: () {
                  return MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
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
                      Navigator.pushReplacementNamed(context, 'tiperegister');
                    },
                  );
                },
              ),
              const SizedBox(width: 20),
              _IngresarButton(
                sharedProvider: sharedProvider,
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

  const _IngresarButton({
    Key? key,
    required this.sharedProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Resize(
      builder: () {
        return MaterialButton(
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

              //TODO: validar el login con backend
              /*print(this.sharedProvider.isBlind);
                  print(sharedProvider.isParent);*/

              sharedProvider.isLoading = false;
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: sharedProvider.email,
                    password: sharedProvider.password);
                if (sharedProvider.isBlind && context.mounted) {
                  Navigator.pushReplacementNamed(context, 'homeblind');
                } else {
                  Navigator.pushReplacementNamed(context, 'homeparent');
                }
              } catch (e) {
                String errorMessage = 'Ocurrió un error al iniciar sesión.';
                // Verificar el tipo de error y mostrar un mensaje adecuado al usuario
                if (e is FirebaseAuthException) {
                  switch (e.code) {
                    case 'user-not-found':
                      errorMessage = 'Usuario no encontrado.';
                      break;
                    case 'wrong-password':
                      errorMessage = 'Contraseña incorrecta.';
                      break;
                    case 'invalid-email':
                      errorMessage = 'Correo electrónico inválido.';
                      break;
                    default:
                      errorMessage = 'Error: ${e.message}';
                  }
                }
                // Mostrar el mensaje de error al usuario
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
                  ),
                );
              }
            });
      },
    );
  }
}
