import 'package:baston_inteligente_mejorada/providers/login_form.dart';
import 'package:baston_inteligente_mejorada/utils/decoration.dart';
import 'package:baston_inteligente_mejorada/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterParent extends StatelessWidget {
  const RegisterParent({super.key});

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
                Text('Nueva Cuenta de Familiar',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(), child: _LoginForm())
              ],
            )),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(Colors.indigo.withOpacity(0.6)),
                shape: MaterialStateProperty.all(const StadiumBorder()),
              ),
              child: const Text('¿Ya tienes una cuenta?',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    ));
  }
}

class _LoginForm extends StatelessWidget {
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
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 60),
                  child: const Text(
                    'Volver',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'login');
                },
              ),
              const SizedBox(width: 30),
              _IngresarButton(loginForm: loginForm),
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
  }) : super(key: key);

  final LoginFormProvider loginForm;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
              loginForm.isLoading = false;

              Navigator.pushReplacementNamed(context, 'code_register_parent');
            },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
        child: Text(
          loginForm.isLoading ? 'Espere' : 'Siguiente',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
