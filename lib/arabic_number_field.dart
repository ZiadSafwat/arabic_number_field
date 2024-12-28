library arabic_number_field;


class ArabicNumberField extends StatefulWidget {
  const ArabicNumberField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.hintText,
    this.suffix,
    this.prefix,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.obscure = false,
    this.lines,
    this.regExp,
  });

  final bool obscure;
  final int? lines;
  final bool readOnly;
  final TextInputType keyboardType;
  final String hintText;
  final Widget? prefix;
  final Widget? suffix;
  final void Function()? onTap;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final RegExp? regExp;

  @override
  State<ArabicNumberField> createState() => _ArabicNumberFieldState();
}

class _ArabicNumberFieldState extends State<ArabicNumberField> {

  String _convertToArabicNumbers(String input) {
    Map<String, String> numbersMap = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };

    String result = input;
    numbersMap.forEach((key, value) {
      result = result.replaceAll(key, value);
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.lines ?? 1,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscure,
      readOnly: widget.readOnly,
      textDirection: TextDirection.rtl,
      keyboardType: widget.keyboardType,
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.suffix,
        prefix: widget.prefix,
        suffixIconColor: Colors.grey[600],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
      onChanged: (value) {
        widget.controller.text = _convertToArabicNumbers(value);
      },
      onTapOutside: (focusNode) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      onTap: widget.onTap,
    );
  }
}

