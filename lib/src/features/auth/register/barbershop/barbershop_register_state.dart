enum BarberShopRegisterStateStatus {
  success,
  error,
  initial,
}

class BarbershopRegisterState {
  final BarberShopRegisterStateStatus state;
  final List<int> openingHours;
  final List<String> openingDays;

  BarbershopRegisterState.initial()
      : this(
          state: BarberShopRegisterStateStatus.initial,
          openingHours: <int>[],
          openingDays: <String>[],
        );

  BarbershopRegisterState({
    required this.state,
    required this.openingHours,
    required this.openingDays,
  });

  BarbershopRegisterState copyWith({
    BarberShopRegisterStateStatus? state,
    List<int>? openingHours,
    List<String>? openingDays,
  }) {
    return BarbershopRegisterState(
      state: state ?? this.state,
      openingHours: openingHours ?? this.openingHours,
      openingDays: openingDays ?? this.openingDays,
    );
  }
}
