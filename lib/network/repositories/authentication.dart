

import '../api/user_api.dart';
import 'repository.dart';

class AuthenticationRepo extends Repository {
  Future<dynamic> submitLoginForm(jsonData) async =>
      await UserApi().userLogin(jsonData);
}
