import 'package:flutter/material.dart';

class SFormInput extends StatelessWidget {
  final TextEditingController? controller;
  final bool? enabled;
  final bool? forcedBorder;
  final String? label;
  final String? hint;
  final Widget? suffixIcon;
  final String? Function(String? value)? validator;

  const SFormInput(
      {Key? key,
      this.controller,
      this.enabled,
      this.label,
      this.hint,
      this.suffixIcon,
      this.forcedBorder = false,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          prefixIcon: Align(alignment: Alignment.centerLeft, child: suffixIcon),
          errorStyle: TextStyle(
            color: Theme.of(context).errorColor,
          ),
          prefixIconConstraints: const BoxConstraints(maxWidth: 32),
          disabledBorder: (forcedBorder ?? false) ? null : InputBorder.none,
        ),
      ),
    );
  }
}

class SFormSelect extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final dynamic value;
  final bool? enabled;
  final String? label;
  final String? hint;
  final Widget? suffixIcon;
  final void Function(dynamic value)? onChanged;
  final String? Function(dynamic value)? validator;

  const SFormSelect(
      {Key? key,
      this.enabled,
      this.label,
      this.hint,
      this.suffixIcon,
      required this.items,
      this.value,
      this.onChanged,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: DropdownButtonFormField(
        icon: suffixIcon,
        value: value,
        validator: validator,
        onChanged: (enabled ?? true) ? onChanged : null,
        isExpanded: true,
        hint: Text(hint ?? "selectOption"),
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          disabledBorder: InputBorder.none,
        ),
        items: items,
      ),
    );
  }
}
