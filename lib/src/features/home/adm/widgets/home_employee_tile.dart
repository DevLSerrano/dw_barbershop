import 'package:flutter/material.dart';

import '../../../../core/ui/constants/constants_colors.dart';
import '../../../../core/ui/constants/constants_image.dart';
import '../../../../core/ui/icons/barbershop_icons.dart';
import '../../../../model/user_model.dart';

class HomeEmployeeTile extends StatelessWidget {
  final UserModel employee;
  const HomeEmployeeTile({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: ConstantsColors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: ConstantsColors.grey,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: switch (employee.avatar) {
                  final avatar? => NetworkImage(avatar),
                  _ => const AssetImage(ConstantsImage.avatar),
                } as ImageProvider<Object>,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        maximumSize: const Size(double.infinity, 56),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Agendar',
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onPressed: () {},
                      child: const Text('Ver Agenda'),
                    ),
                    const Icon(
                      BarbershopIcons.penEdit,
                      color: ConstantsColors.brow,
                      size: 16,
                    ),
                    const Icon(
                      BarbershopIcons.trash,
                      color: ConstantsColors.red,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
