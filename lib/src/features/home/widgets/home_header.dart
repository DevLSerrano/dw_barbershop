import 'package:flutter/material.dart';

import '../../../core/ui/constants/constants_colors.dart';
import '../../../core/ui/constants/constants_image.dart';
import '../../../core/ui/icons/barbershop_icons.dart';

class HomeHeader extends StatelessWidget {
  final bool hideFilter;
  const HomeHeader({
    super.key,
  }) : hideFilter = false;

  const HomeHeader.withoutFilter({
    super.key,
  }) : hideFilter = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(ConstantsImage.backgroundChair),
          fit: BoxFit.cover,
          opacity: .5,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            centerTitle: false,
            backgroundColor: Colors.transparent,
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFBDBDBD),
              child: SizedBox.shrink(),
            ),
            title: const Row(
              children: [
                Expanded(
                  child: Text(
                    'Leonardo Canhizares Dias Serrano',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    'Editar',
                    style: TextStyle(
                      color: ConstantsColors.brow,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  BarbershopIcons.exit,
                  color: ConstantsColors.brow,
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Bem-vindo',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Agende um Cliente',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 40,
            ),
          ),
          Offstage(
            offstage: hideFilter,
            child: const SizedBox(
              height: 24,
            ),
          ),
          Offstage(
            offstage: hideFilter,
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Buscar colaborador',
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 24.0),
                  child: Icon(
                    BarbershopIcons.search,
                    color: ConstantsColors.brow,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
