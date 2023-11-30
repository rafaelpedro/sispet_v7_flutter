import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestor_market/models/produto_model.dart';
import 'package:gestor_market/produto/produto_controller.dart';
import 'package:gestor_market/util/data_util.dart';
import 'package:gestor_market/util/valor_util.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../widgets/default_text_form_field.dart';

class ProdutoRegister extends StatefulWidget {
  final ProdutoModel? produtoEdit;
  const ProdutoRegister({super.key, this.produtoEdit});

  @override
  State<ProdutoRegister> createState() => _ProdutoRegisterState();
}

class _ProdutoRegisterState extends State<ProdutoRegister> {
  var _nomeEC = TextEditingController();
  var _priceEC = TextEditingController();
  var _dateEC = TextEditingController();
  var _setorEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.produtoEdit != null) {
      final prod = widget.produtoEdit;
      _nomeEC = TextEditingController(text: prod!.nome);
      _priceEC = TextEditingController(
          text: ValorUtil.convertDoubleToString(prod.preco));
      _dateEC = TextEditingController(
          text: DataUtil.convertDateTimeFromPTBR(prod.dataCadastro));
      _setorEC = TextEditingController(text: prod.setor);
    } else {
      _dateEC = TextEditingController(
          text: DataUtil.convertDateTimeFromPTBR(DateTime.now()));
    }
    super.initState();
  }

  @override
  void dispose() {
    _nomeEC.dispose();
    _priceEC.dispose();
    _dateEC.dispose();
    _setorEC.dispose();
    super.dispose();
  }

  static MaskTextInputFormatter get maskDateFormat => MaskTextInputFormatter(
        mask: '##/##/####',
        filter: {'#': RegExp(r'[0-9]')},
      );

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProdutoController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produto setor petshop'),
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
                label: 'Preço',
                controller: _priceEC,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CentavosInputFormatter(),
                ],
                validator: Validatorless.multiple(
                    [Validatorless.required("Campo obrigatório")]),
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultTextFormField(
                label: 'Data de cadastro',
                controller: _dateEC,
                inputFormatters: [maskDateFormat],
                keyboardType: TextInputType.number,
                validator: Validatorless.multiple(
                    [Validatorless.required("Campo obrigatório")]),
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultTextFormField(
                label: 'Setor',
                controller: _setorEC,
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
                      final produto = ProdutoModel(
                        id: widget.produtoEdit != null
                            ? widget.produtoEdit!.id
                            : null,
                        nome: _nomeEC.text,
                        preco: ValorUtil.convertStringToDouble(_priceEC.text),
                        dataCadastro: DateTime.now(),
                        setor: _setorEC.text,
                      );

                      if (widget.produtoEdit == null) {
                        await controller.cadastrar(produto: produto);
                      } else {
                        await controller.editar(produto: produto);
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
