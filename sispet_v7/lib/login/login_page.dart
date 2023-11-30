import 'package:flutter/material.dart';
import 'package:gestor_market/login/login_controller.dart';
import 'package:gestor_market/models/user_model.dart';
import 'package:gestor_market/widgets/default_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final controller = Provider.of<LoginController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final user = await controller.isLogged();
      if (user != null) {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false,
            arguments: user);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<LoginController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SISPET'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
          child: ListView(
            children: [
              const SizedBox(
                height: 25,
              ),
              Image.asset(
                'assets/images/logo.png',
                height: 230,
              ),
              DefaultTextFormField(
                label: 'Email',
                controller: _emailEC,
                validator: Validatorless.multiple([
                  Validatorless.email('Digite um email válido!'),
                  Validatorless.required('Campo obrigatório')
                ]),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 12,
              ),
              DefaultTextFormField(
                obscureText: true,
                label: 'Senha',
                controller: _passwordEC,
                validator: Validatorless.multiple([
                  Validatorless.min(6, 'Senha inválida!'),
                  Validatorless.required('Campo obrigatório')
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: () async {
                    final validate = _formKey.currentState?.validate() ?? false;
                    if (validate) {
                      final UserModel? userLogged = await _controller.login(
                          email: _emailEC.text, senha: _passwordEC.text);
                      if (userLogged != null) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home', (route) => false,
                            arguments: userLogged);
                      }
                    }
                  },
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed('/login/register');
                },
                child: const Text(
                  'Registrar-se',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
