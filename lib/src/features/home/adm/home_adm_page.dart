import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/constants/constants_colors.dart';
import '../../../core/ui/icons/barbershop_icons.dart';
import '../../../core/ui/widgets/barbershop_loader.dart';
import '../widgets/home_header.dart';
import 'home_adm_state.dart';
import 'home_adm_vm.dart';
import 'widgets/home_employee_tile.dart';

class HomeAdmPage extends ConsumerWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeAdmVmProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ConstantsColors.brow,
        onPressed: () {},
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 12,
          child: Icon(
            BarbershopIcons.addEmployee,
            color: ConstantsColors.brow,
          ),
        ),
      ),
      body: homeState.when(
        data: (HomeAdmState data) => CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: HomeHeader(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => HomeEmployeeTile(
                  employee: data.employees[index],
                ),
                childCount: data.employees.length,
              ),
            ),
          ],
        ),
        loading: () => const BarbershopLoader(),
        error: (error, stack) {
          log(
            'Erro ao buscar colaboradores',
            error: error,
            stackTrace: stack,
          );
          return const Center(
            child: Text('Erro ao carregar pagina.'),
          );
        },
      ),
    );
  }
}
