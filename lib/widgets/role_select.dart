import 'package:flutter/material.dart';

class RoleSelect extends StatefulWidget {
  final String defaultValue;
  final Function(String) onChange;

  const RoleSelect({
    super.key,
    required this.defaultValue,
    required this.onChange,
  });

  @override
  State<RoleSelect> createState() => _RoleSelectState();
}

class _RoleSelectState extends State<RoleSelect> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200, // Réduit la largeur pour que le widget soit plus petit
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Réduit le padding pour un aspect plus compact
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8), // Bordures arrondies
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: widget.defaultValue,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.blueGrey),
            isExpanded: true,
            dropdownColor: Colors.white,
            onChanged: (String? newValue) {
              setState(() {
                widget.onChange(newValue!);
              });
            },
            items: [
              DropdownMenuItem(
                value: 'ORGANIZER',
                child: Row(
                  children: const [
                    Icon(Icons.event, color: Colors.blueGrey, size: 18), // Icône plus petite
                    SizedBox(width: 8),
                    Text('Organisateur'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'STAND_HOLDER',
                child: Row(
                  children: const [
                    Icon(Icons.storefront, color: Colors.blueGrey, size: 18),
                    SizedBox(width: 8),
                    Text('Teneur de Stand'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'PARENT',
                child: Row(
                  children: const [
                    Icon(Icons.family_restroom, color: Colors.blueGrey, size: 18),
                    SizedBox(width: 8),
                    Text('Parent'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
