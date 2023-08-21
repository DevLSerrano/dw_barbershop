sealed class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return switch (json['profile']) {
      'ADM' => UserModelAdm.fromMap(json),
      'EMPLOYEE' => UserModelEmployee.fromMap(json),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}

class UserModelAdm extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;

  UserModelAdm({
    required int id,
    required String name,
    required String email,
    this.workDays,
    this.workHours,
    String? avatar,
  }) : super(
          id: id,
          name: name,
          email: email,
          avatar: avatar,
        );

  factory UserModelAdm.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
      } =>
        UserModelAdm(
          id: id,
          name: name,
          email: email,
          avatar: json['avatar'],
          workDays: json['work_days']?.cast<String>(),
          workHours: json['work_hours']?.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}

class UserModelEmployee extends UserModel {
  final int barberShopId;
  final List<String> workDays;
  final List<int> workHours;

  UserModelEmployee({
    required int id,
    required String name,
    required String email,
    required this.barberShopId,
    required this.workDays,
    required this.workHours,
    String? avatar,
  }) : super(
          id: id,
          name: name,
          email: email,
          avatar: avatar,
        );

  factory UserModelEmployee.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        'barbershop_id': final int barberShopId,
        'work_days': final List workDays,
        'work_hours': final List workHours,
      } =>
        UserModelEmployee(
          id: id,
          name: name,
          email: email,
          barberShopId: barberShopId,
          avatar: json['avatar'],
          workDays: workDays.cast<String>(),
          workHours: workHours.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
