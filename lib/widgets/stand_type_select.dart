import 'package:flutter/material.dart';

class StandTypeSelect extends StatefulWidget {
  final String defaultValue;
  final Function(String) onChange;

  const StandTypeSelect({
    super.key,
    required this.defaultValue,
    required this.onChange,
  });

  @override
  State<StandTypeSelect> createState() => _StandTypeSelectState();
}

class _StandTypeSelectState extends State<StandTypeSelect> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: screenWidth * 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.category, color: Colors.black54),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButton<String>(
                value: widget.defaultValue,
                onChanged: (String? newValue) {
                  setState(() {
                    widget.onChange(newValue!);
                  });
                },
                isExpanded: true,
                underline: SizedBox.shrink(),
                icon: const Icon(Icons.arrow_drop_down),
                items: const [
                  DropdownMenuItem(
                    value: 'ACTIVITY',
                    child: Text('Activité'),
                  ),
                  DropdownMenuItem(
                    value: 'CONSUMPTION',
                    child: Text('Consommation'),
                  ),
                ],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                dropdownColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
