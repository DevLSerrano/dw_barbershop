import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/local_storage_keys.dart';
import '../../core/exceptions/auth_exception.dart';
import '../../core/exceptions/service_exception.dart';
import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';
import '../../repositories/user/user_repository.dart';
import './users_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository _userRepository;

  UserLoginServiceImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<Either<ServiceException, Nil>> execute(
    String email,
    String password,
  ) async {
    final loginResult = await _userRepository.login(email, password);

    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        await sp.setString(LocalStorageKeys.accessToken, accessToken);
        return Success(nil);
      case Failure(:final exception):
        return switch (exception) {
          AuthError() => Failure(ServiceException('Erro ao realizar login.')),
          AuthUnauthorized() =>
            Failure(ServiceException('Login ou Senha inválidos')),
        };
    }
  }
}
