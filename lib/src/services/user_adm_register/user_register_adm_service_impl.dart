import '../../core/exceptions/service_exception.dart';
import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';
import '../../repositories/user/user_repository.dart';
import '../users_login/users_login_service.dart';
import 'user_register_adm_service.dart';

class UserRegisterAdmServiceImpl implements UserRegisterAdmService {
  final UserRepository _userRepository;
  final UserLoginService _userLoginService;

  UserRegisterAdmServiceImpl({
    required UserRepository userRepository,
    required UserLoginService userLoginService,
  })  : _userRepository = userRepository,
        _userLoginService = userLoginService;

  @override
  Future<Either<ServiceException, Nil>> execute(
    ({String email, String name, String password}) userData,
  ) async {
    final registerResult = await _userRepository.registerAdmin(
      userData,
    );

    switch (registerResult) {
      case Success():
        return _userLoginService.execute(userData.email, userData.password);
      case Failure(:final exception):
        return Failure(
          ServiceException(exception.message),
        );
    }
  }
}
