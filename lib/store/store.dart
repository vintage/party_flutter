import 'dart:async' show Future;
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreModel extends Model {
  Future initialize() async {}

  Future<SharedPreferences> get persistStore async =>
      await SharedPreferences.getInstance();
}
