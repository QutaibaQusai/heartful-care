import 'package:flutter/material.dart';

class MutiSelect extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;

  const MutiSelect({Key? key, required this.items, required this.selectedItems})
      : super(key: key);

  @override
  State<MutiSelect> createState() => _MutiSelectState();
}

class _MutiSelectState extends State<MutiSelect> {
  final List<String> _selectedItems = [];

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void submit() {
    if (_selectedItems.isNotEmpty) {
      Navigator.pop(context, _selectedItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select why you need a nurse"),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              value: _selectedItems.contains(item),
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isChecked) => _itemChange(item, isChecked!),
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: submit,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
