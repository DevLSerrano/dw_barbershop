import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/fp/either.dart';
import '../../../../core/providers/application_providers.dart';
import 'barbershop_register_state.dart';

part 'barbershop_register_vm.g.dart';

@riverpod
class BarbershopRegisterVm extends _$BarbershopRegisterVm {
  @override
  BarbershopRegisterState build() => BarbershopRegisterState.initial();

  Future<void> register(String name, String email) async {
    final repository = ref.watch(barbershopRepositoryProvider);
    final BarbershopRegisterState(:openingDays, :openingHours) = state;
    final dto = (
      email: email,
      name: name,
      openingDays: openingDays,
      openingHours: openingHours,
    );

    final registerResult = await repository.save(dto);

    switch (registerResult) {
      case Success():
        ref.invalidate(getMyBarberShopProvider);
        state = state.copyWith(state: BarberShopRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(state: BarberShopRegisterStateStatus.error);
    }
  }

  void addOrRemoveOpenDay(String weekDay) {
    final openingDays = state.openingDays;

    if (openingDays.contains(weekDay)) {
      openingDays.remove(weekDay);
    } else {
      openingDays.add(weekDay);
    }

    state = state.copyWith(openingDays: openingDays);
  }

  void addOrRemoveOpenHour(int hour) {
    final openingHours = state.openingHours;

    if (openingHours.contains(hour)) {
      openingHours.remove(hour);
    } else {
      openingHours.add(hour);
    }

    state = state.copyWith(openingHours: openingHours);
  }
}
