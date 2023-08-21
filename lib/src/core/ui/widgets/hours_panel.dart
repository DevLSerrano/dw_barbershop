import 'package:flutter/material.dart';

import '../constants/constants_colors.dart';

class HoursPanel extends StatelessWidget {
  final int startTime;
  final int endTime;
  final ValueChanged<int> onTimePressed;

  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onTimePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
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
          Wrap(
            runSpacing: 5,
            children: [
              for (int i = startTime; i <= endTime; i++)
                TimeButton(
                  label: '${i.toString().padLeft(2, '0')}:00',
                  onTimePressed: onTimePressed,
                  value: i,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimeButton extends StatefulWidget {
  final String label;
  final int value;
  final ValueChanged<int> onTimePressed;
  const TimeButton({
    super.key,
    required this.label,
    required this.value,
    required this.onTimePressed,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
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
          widget.onTimePressed(widget.value);
          setState(() {
            _isSelected = !_isSelected;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 64,
          height: 36,
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
