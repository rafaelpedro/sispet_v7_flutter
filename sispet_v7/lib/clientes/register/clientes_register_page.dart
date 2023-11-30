import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestor_market/clientes/clientes_controller.dart';
import 'package:gestor_market/models/clientes_model.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../widgets/default_text_form_field.dart';

class ClientesRegisterPage extends StatefulWidget {
  final ClientesModel? clienteEdit;
  const ClientesRegisterPage({super.key, this.clienteEdit});

  @override
  State<ClientesRegisterPage> createState() => _ClientesRegisterPageState();
}

class _ClientesRegisterPageState extends State<ClientesRegisterPage> {
  var _nomeEC = TextEditingController();
  var _cpfEC = TextEditingController();
  var _emailEC = TextEditingController();
  var _telefoneEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.clienteEdit != null) {
      final cli = widget.clienteEdit;
      _nomeEC = TextEditingController(text: cli!.nome);
      _cpfEC = TextEditingController(text: cli.cpf);
      _emailEC = TextEditingController(text: cli.email);
      _telefoneEC = TextEditingController(text: cli.telefone);
    }

    super.initState();
  }

  @override
  void dispose() {
    _nomeEC.dispose();
    _cpfEC.dispose();
    _emailEC.dispose();
    _telefoneEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ClientesController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Cliente (PET)'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: <Widget>[
              DefaultTextFormField(
                label: 'Nome e Especie do PET',
                controller: _nomeEC,
                validator: Validatorless.multiple(
                    [Validatorless.required("Campo obrigatório")]),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultTextFormField(
                label: 'Email',
                controller: _emailEC,
                keyboardType: TextInputType.emailAddress,
                validator: Validatorless.multiple([
                  Validatorless.email("Email inválido!"),
                  Validatorless.required("Campo obrigatório")
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultTextFormField(
                label: 'Telefone',
                controller: _telefoneEC,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter()
                ],
                validator: Validatorless.multiple(
                    [Validatorless.required("Campo obrigatório")]),
              ),
              DefaultTextFormField(
                label: 'CPF',
                controller: _cpfEC,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter()
                ],
                validator: Validatorless.multiple([
                  Validatorless.cpf("CPF inválido!"),
                  Validatorless.required("Campo obrigatório")
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: () async {
                    final validate = _formKey.currentState?.validate() ?? false;
                    if (validate) {
                      final cliente = ClientesModel(
                          id: widget.clienteEdit != null
                              ? widget.clienteEdit!.id
                              : null,
                          nome: _nomeEC.text,
                          cpf: _cpfEC.text,
                          email: _emailEC.text,
                          telefone: _telefoneEC.text);

                      if (widget.clienteEdit == null) {
                        await controller.cadastrar(cliente: cliente);
                      } else {
                        await controller.editar(cliente: cliente);
                        await controller.buscaTodos();
                      }

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
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
