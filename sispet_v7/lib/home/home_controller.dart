import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gestor_market/databse/database.dart';
import 'package:gestor_market/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends ChangeNotifier {
  File? _image;

  File? get image => _image;

  Future getImage({required UserModel user}) async {
    final conn = await Database().getConnection();

    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      if (_image != null) {
        await conn.query(
            "UPDATE USUARIO SET IMAGE = '${pickedFile.path}' WHERE id = ${user.id}");
      }
      notifyListeners();
    }
  }
}
