import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestor_market/fornecedor/fornecedor_controller.dart';
import 'package:gestor_market/models/fornecedor_model.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../clientes/clientes_controller.dart';
import '../../widgets/default_text_form_field.dart';

class FornecedorRegisterPage extends StatefulWidget {
  final FornecedorModel? fornecedorEdit;
  const FornecedorRegisterPage({super.key, this.fornecedorEdit});

  @override
  State<FornecedorRegisterPage> createState() => _FornecedorRegisterPageState();
}

class _FornecedorRegisterPageState extends State<FornecedorRegisterPage> {
  var _nomeEC = TextEditingController();
  var _emailEC = TextEditingController();
  var _telefoneEC = TextEditingController();
  var _cnpjEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.fornecedorEdit != null) {
      final forne = widget.fornecedorEdit;
      _nomeEC = TextEditingController(text: forne!.nome);
      _emailEC = TextEditingController(text: forne.email);
      _telefoneEC = TextEditingController(text: forne.telefone);
      _cnpjEC = TextEditingController(text: forne.cnpj);
    }

    super.initState();
  }

  @override
  void dispose() {
    _nomeEC.dispose();
    _emailEC.dispose();
    _telefoneEC.dispose();
    _cnpjEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<FornecedorController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fornecedor de produtos setor petshop'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: <Widget>[
              DefaultTextFormField(
                label: 'Nome',
                controller: _nomeEC,
                validator: Validatorless.multiple(
                    [Validatorless.required("Campo obrigatório")]),
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultTextFormField(
                label: 'CNPJ',
                controller: _cnpjEC,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CnpjInputFormatter()
                ],
                validator: Validatorless.multiple([
                  Validatorless.cnpj('CNPJ inválido!'),
                  Validatorless.required("Campo obrigatório")
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultTextFormField(
                label: 'Email',
                controller: _emailEC,
                keyboardType: TextInputType.emailAddress,
                validator: Validatorless.multiple([
                  Validatorless.email("Digite um email válido!"),
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
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: () async {
                    final validate = _formKey.currentState?.validate() ?? false;
                    if (validate) {
                      final fornecedor = FornecedorModel(
                          id: widget.fornecedorEdit != null
                              ? widget.fornecedorEdit!.id
                              : null,
                          nome: _nomeEC.text,
                          cnpj: _cnpjEC.text,
                          email: _emailEC.text,
                          telefone: _telefoneEC.text);

                      if (widget.fornecedorEdit == null) {
                        await controller.cadastrar(fornecedor: fornecedor);
                      } else {
                        await controller.editar(fornecedor: fornecedor);
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
