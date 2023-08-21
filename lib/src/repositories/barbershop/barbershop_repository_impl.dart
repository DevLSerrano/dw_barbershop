import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';
import '../../core/rest_client/rest_client.dart';
import '../../model/barbershop_model.dart';
import '../../model/user_model.dart';
import './barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient _restClient;

  BarbershopRepositoryImpl({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
    UserModel userModel,
  ) async {
    switch (userModel) {
      case UserModelAdm():
        final Response(data: List(first: data)) = await _restClient.auth.get(
          '/barbershop',
          queryParameters: {
            'user_id': '#userAuthRef',
          },
        );
        return Success(BarbershopModel.fromMap(data));
      case UserModelEmployee():
        final Response(:data) = await _restClient.auth.get(
          '/barbershop/${userModel.barberShopId}',
        );
        return Success(BarbershopModel.fromMap(data));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> save(
    ({
      String email,
      String name,
      List<String> openingDays,
      List<int> openingHours
    }) data,
  ) async {
    try {
      await _restClient.auth.post(
        '/barbershop',
        data: {
          'user_id': '#userAuthRef',
          'email': data.email,
          'nome': data.name,
          'opening_days': data.openingDays,
          'opening_hours': data.openingHours,
        },
      );
      return Success(Nil());
    } on DioException catch (e, s) {
      log('Erro ao adicionar barbearia', error: e, stackTrace: s);
      return Failure(RepositoryException('Erro ao adicionar barbearia'));
    }
  }
}
