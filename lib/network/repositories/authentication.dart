

import '../api/user_api.dart';
import 'repository.dart';

class AuthenticationRepo extends Repository {
  final UserApi userApi = UserApi();
  Future<dynamic> submitLoginForm(jsonData) async =>
      await UserApi().userLogin(jsonData);


      Future<void> logOut(String token)async
      {
        return await userApi.logOut(token);
      }
}
