
part of '../forms.dart';
class FormInput extends StatelessWidget {
  final TextEditingController? controller;
  final bool? enabled;
  final bool? forcedBorder;
  final String? label;
  final String? hint;
  final Widget? suffixIcon;
  final String? Function(String? value)? validator;

  const FormInput(
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
