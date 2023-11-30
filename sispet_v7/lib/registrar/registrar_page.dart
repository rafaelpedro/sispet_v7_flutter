import 'package:flutter/material.dart';
import 'package:gestor_market/models/user_model.dart';
import 'package:gestor_market/registrar/registrar_controller.dart';
import 'package:gestor_market/widgets/default_text_form_field.dart';
import 'package:validatorless/validatorless.dart';
import 'package:provider/provider.dart';

class RegistrarPage extends StatefulWidget {
  const RegistrarPage({super.key});

  @override
  State<RegistrarPage> createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage> {
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<RegistrarController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados da conta'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              DefaultTextFormField(
                controller: _nameEC,
                label: 'Nome',
                validator: Validatorless.multiple(
                    [Validatorless.required("Campo obrigatório!")]),
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultTextFormField(
                controller: _emailEC,
                label: 'Email',
                validator: Validatorless.multiple([
                  Validatorless.email('Email inválido!'),
                  Validatorless.required("Campo obrigatório!")
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultTextFormField(
                controller: _passwordEC,
                label: 'Senha',
                obscureText: true,
                validator: Validatorless.multiple([
                  Validatorless.min(
                      6, 'A senha deve conter no minimo 6 caracteres!'),
                  Validatorless.required("Capo obrigatório!")
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
                      final user = UserModel(
                          nome: _nameEC.text,
                          email: _emailEC.text,
                          senha: _passwordEC.text,
                          logado: 0,
                          image: '');
                      await _controller.registrar(user: user);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 16),
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
