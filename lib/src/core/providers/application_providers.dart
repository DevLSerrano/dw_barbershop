import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/barbershop_model.dart';
import '../../model/user_model.dart';
import '../../repositories/barbershop/barbershop_repository.dart';
import '../../repositories/barbershop/barbershop_repository_impl.dart';
import '../../repositories/user/user_repository.dart';
import '../../repositories/user/user_repository_impl.dart';
import '../../services/users_login/user_login_service_impl.dart';
import '../../services/users_login/users_login_service.dart';
import '../fp/either.dart';
import '../rest_client/rest_client.dart';
import '../ui/barbershop_nav/barbershop_nav_global_key.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl(
      restClient: ref.read(restClientProvider),
    );

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(
      userRepository: ref.read(userRepositoryProvider),
    );

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(exception: final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
    BarbershopRepositoryImpl(
      restClient: ref.read(restClientProvider),
    );

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarberShop(GetMyBarberShopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);
  final barbershopRepository = ref.watch(barbershopRepositoryProvider);

  final result = await barbershopRepository.getMyBarbershop(userModel);

  return switch (result) {
    Success(value: final barbershopModel) => barbershopModel,
    Failure(exception: final exception) => throw exception,
  };
}

@Riverpod()
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();

  ref.invalidate(getMeProvider);
  ref.invalidate(getMyBarberShopProvider);

  Navigator.of(BarbershopNavGlobalKey.instance.navigatorKey.currentContext!)
      .pushNamedAndRemoveUntil(
    '/auth/login',
    (route) => false,
  );
}
