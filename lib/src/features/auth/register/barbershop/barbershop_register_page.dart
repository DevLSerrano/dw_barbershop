import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/form_helper.dart';
import '../../../../core/ui/helpers/messages.dart';
import '../../../../core/ui/widgets/hours_panel.dart';
import '../../../../core/ui/widgets/week_day_panel.dart';
import 'barbershop_register_state.dart';
import 'barbershop_register_vm.dart';

class BarbershopRegisterPage extends ConsumerStatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  ConsumerState<BarbershopRegisterPage> createState() =>
      _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState
    extends ConsumerState<BarbershopRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barbershopRegisterVm =
        ref.watch(barbershopRegisterVmProvider.notifier);
    ref.listen(barbershopRegisterVmProvider, (previousState, nextState) {
      switch (nextState.state) {
        case BarberShopRegisterStateStatus.initial:
          break;
        case BarberShopRegisterStateStatus.error:
          Messages.showError('Erro ao cadastrar barbearia', context);
        case BarberShopRegisterStateStatus.success:
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home/adm',
            (route) => false,
          );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Barbearia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 19,
                ),
                TextFormField(
                  controller: nameEC,
                  onTapOutside: (event) => context.unFocus(),
                  validator: Validatorless.required('Nome obrigatório'),
                  decoration: const InputDecoration(
                    labelText: 'Nome da Barbearia',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Email obrigatório'),
                    Validatorless.email('Email inválido'),
                  ]),
                  onTapOutside: (event) => context.unFocus(),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                WeekDayPanel(
                  onDayPressed: (weekDay) {
                    barbershopRegisterVm.addOrRemoveOpenDay(weekDay);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                HoursPanel(
                  startTime: 6,
                  endTime: 23,
                  onTimePressed: (hour) {
                    barbershopRegisterVm.addOrRemoveOpenHour(hour);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case false || null:
                        Messages.showError('Formulario inválido', context);
                      case true:
                        barbershopRegisterVm.register(
                          nameEC.text,
                          emailEC.text,
                        );
                    }
                  },
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
