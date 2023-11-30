import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestor_market/home/home_controller.dart';
import 'package:gestor_market/home/widgets/home_card_button.dart';
import 'package:gestor_market/login/login_controller.dart';
import 'package:gestor_market/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    final homeController = Provider.of<HomeController>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
          onPressed: () async {
            await loginController.logout();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false);
          },
        ),
        title: const Text(''),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: homeController.image != null
                      ? FileImage(homeController.image!)
                      : null,
                  child: homeController.image == null
                      ? const Icon(
                          Icons.camera_alt,
                          size: 40,
                        )
                      : null,
                ),
                TextButton(
                    onPressed: () {
                      homeController.getImage(user: widget.user);
                    },
                    child: const Text('Alterar')),
                const SizedBox(
                  height: 20,
                ),
                GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    childAspectRatio: 1.4,
                    mainAxisSpacing: 1,
                    children: [
                      HomeCardButton(
                        title: 'PETS (CLIENTES)',
                        icon: Icons.flutter_dash,
                        onTap: () {
                          Navigator.of(context).pushNamed('/home/clientes/');
                        },
                      ),
                      HomeCardButton(
                        title: 'PRODUTOS PETSHOP',
                        icon: Icons.home_repair_service_outlined,
                        onTap: () {
                          Navigator.of(context).pushNamed('/home/produto/');
                        },
                      ),
                      HomeCardButton(
                        title: 'FORNECEDOR PRODUTOS PET',
                        icon: Icons.flight_takeoff,
                        onTap: () {
                          Navigator.of(context).pushNamed('/home/fornecedor/');
                        },
                      ),
                    ]),
              ],
            ),
          )),
    );
  }
}
