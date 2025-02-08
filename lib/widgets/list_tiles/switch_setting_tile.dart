import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';

class SwitchSettingTile extends StatefulWidget {
  const SwitchSettingTile({
    super.key,
    required this.title,
    required this.iconData,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final IconData iconData;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<SwitchSettingTile> createState() => _SwitchSettingTileState();
}

class _SwitchSettingTileState extends State<SwitchSettingTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      child: SwitchListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: kGrayColor200, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        tileColor: kGrayColor100,
        secondary: Icon(widget.iconData, size: 30),
        title: Text(widget.title),
        value: widget.value,
        onChanged: widget.onChanged,
        activeTrackColor: kOrangeColor300,
        inactiveThumbColor: kGrayColor300,
        inactiveTrackColor: kGrayColor200,
      ),
    );
  }
}