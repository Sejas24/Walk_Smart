import 'package:baston_inteligente_mejorada/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';

import '../providers/login_form.dart';
import '../providers/notification_provider.dart';
import '../providers/shared_provider.dart';
import '../utils/decoration.dart';

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
                Text('Login', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
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
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
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
            onChanged: (value) => loginForm.email = value,
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
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe tener al menos 6 caracteres';
            },
          ),
          const SizedBox(height: 30),
          Row(
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
                          vertical: 15, horizontal: 2.rem),
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
                loginForm: loginForm,
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
  const _IngresarButton({
    Key? key,
    required this.loginForm,
    required this.sharedProvider,
  }) : super(key: key);

  final LoginFormProvider loginForm;
  final SharedProvider sharedProvider;

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
          onPressed: loginForm.isLoading
              ? null
              : () async {
                  FocusScope.of(context).unfocus();
                  if (!loginForm.isValidForm()) return;

                  loginForm.isLoading = true;

                  Future.delayed(const Duration(seconds: 2));

                  //TODO: validar el login con backend
                  /*print(this.sharedProvider.isBlind);
                  print(sharedProvider.isParent);*/

                  loginForm.isLoading = false;
                  try {
                     final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: loginForm.email,
                            password: loginForm.password);
                    if (sharedProvider.isBlind) {
                      Navigator.pushReplacementNamed(context, 'homeblind');
                    } else {
                      Navigator.pushReplacementNamed(context, 'homeparent');
                    }
                  } catch (e) {
                    //mostar error al usuario de contraseña o correo invalido
                    NotificationProvided.showSnackbar(e.toString());
                  }
                },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 2.rem),
            child: Text(
              loginForm.isLoading ? 'Espere' : 'Ingresar',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
