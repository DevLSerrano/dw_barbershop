import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/exceptions/auth_exception.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';
import '../../core/rest_client/rest_client.dart';
import '../../model/user_model.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;

  UserRepositoryImpl({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<AuthException, String>> login(
    String email,
    String password,
  ) async {
    try {
      final Response(:data) = await _restClient.unAuth.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      return Success(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('Login oou senha inválidos', error: e, stackTrace: s);
          return Failure(AuthUnauthorized());
        }
      }
      log('Error ao realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar login'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await _restClient.auth.get('/me');

      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Error ao buscar utilizador logado.', error: e, stackTrace: s);
      return Failure(RepositoryException('Erro ao buscar utilizador logado.'));
    } on ArgumentError catch (e, s) {
      log('Invalid json!', error: e, stackTrace: s);
      return Failure(RepositoryException(e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
    ({String email, String name, String password}) userData,
  ) async {
    try {
      await _restClient.unAuth.post(
        '/users',
        data: {
          'name': userData.name,
          'email': userData.email,
          'password': userData.password,
          'profile': 'ADM',
        },
      );
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registar utilizador ADM', error: e, stackTrace: s);
      return Failure(
        RepositoryException(
          'Erro ao registar utilizador ADM',
        ),
      );
    }
  }
}
