import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_form.dart';
import '../utils/decoration.dart';
import 'card_container.dart';
import 'type_register_background.dart';

class CodeRegisterParentScreen extends StatelessWidget {
  const CodeRegisterParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TypeRegisterBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 250),
            CardContainer(
                child: Column(
              children: [
                const SizedBox(height: 10),
                Text('Codigo del familiar No Vidente',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(), child: _LoginForm())
              ],
            )),
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
    return SizedBox(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'ASG350',
                labelText: 'Codigo No Vidente',
                prefixIcon: Icons.lock,
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'El codigo debe tener 6 caracteres';
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
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                    child: const Text(
                      'Volver',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'register_parent');
                  },
                ),
                const SizedBox(width: 20),
                _IngresarButton(loginForm: loginForm),
              ],
            ),
          ],
        ),
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

              Navigator.pushReplacementNamed(context, 'homeparent');
            },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
        child: const Text(
          'Ingresar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
