import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/application_providers.dart';
import '../../../../services/user_adm_register/user_register_adm_service.dart';
import '../../../../services/user_adm_register/user_register_adm_service_impl.dart';

part 'user_register_provider.g.dart';

@riverpod
UserRegisterAdmService userRegisterAdmService(UserRegisterAdmServiceRef ref) =>
    UserRegisterAdmServiceImpl(
      userRepository: ref.watch(userRepositoryProvider),
      userLoginService: ref.watch(userLoginServiceProvider),
    );
