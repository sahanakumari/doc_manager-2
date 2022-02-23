
part of '../forms.dart';
class FormSelect extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final dynamic value;
  final bool? enabled;
  final String? label;
  final String? hint;
  final Widget? suffixIcon;
  final void Function(dynamic value)? onChanged;
  final String? Function(dynamic value)? validator;

  const FormSelect(
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
