import 'package:flutter/material.dart';

import '../constants/constants_colors.dart';

class WeekDayPanel extends StatelessWidget {
  final ValueChanged<String> onDayPressed;

  const WeekDayPanel({
    super.key,
    required this.onDayPressed,
  });

  @override
  Widget build(BuildContext context) {
    final listOfDays = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab', 'Dom'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione os dias da semana',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 56,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listOfDays.length,
            itemBuilder: (context, index) {
              return ButtonDay(
                label: listOfDays[index],
                onDayPressed: onDayPressed,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ButtonDay extends StatefulWidget {
  final String label;
  final ValueChanged<String> onDayPressed;

  const ButtonDay({
    super.key,
    required this.label,
    required this.onDayPressed,
  });

  @override
  State<ButtonDay> createState() => _ButtonDayState();
}

class _ButtonDayState extends State<ButtonDay> {
  var _isSelected = false;
  @override
  Widget build(BuildContext context) {
    final textColor = _isSelected ? Colors.white : ConstantsColors.grey;
    final buttonBackgroundColor =
        _isSelected ? ConstantsColors.brow : Colors.white;
    final buttonBorderColor = _isSelected ? ConstantsColors.brow : Colors.grey;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          widget.onDayPressed(widget.label);
          setState(() {
            _isSelected = !_isSelected;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 56,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: buttonBackgroundColor,
            border: Border.all(
              color: buttonBorderColor,
            ),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 12,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
