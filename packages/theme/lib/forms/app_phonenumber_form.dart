part of '../forms.dart';

class AppPhoneNumberForm extends AppForm<String> {
  const AppPhoneNumberForm({
    required super.name,
    super.key,
    super.validator,
    this.mobileValidator,
    super.label,
    PhoneNumber? super.initialValue,
    super.fieldKey,
    this.onChanged,
    this.required = true,
    this.decoration = const InputDecoration(),
    this.onFieldSubmitted,
    super.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
  });

  final void Function(String?)? onChanged;
  final bool required;
  final String? Function(PhoneNumber?)? mobileValidator;
  final void Function(PhoneNumber value)? onFieldSubmitted;
  final InputDecoration decoration;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  @override
  State<AppPhoneNumberForm> createState() => _AppPhoneNumberFormState();
}

class _AppPhoneNumberFormState extends State<AppPhoneNumberForm> {
  PhoneNumber? _currentPhoneNumber;
  bool _isValidPhoneNumber = false;

  @override
  Widget build(BuildContext context) {
    return widget.buildContainer(
        context,
        FormBuilderField<String>(
          enabled: widget.enabled,
          name: widget.name,
          validator: widget.validator,
          onChanged: widget.onChanged,
          initialValue: (widget.initialValue as PhoneNumber?)?.international,
          builder: (FormFieldState<String> field) {
            // Check if the field is valid - only show red when phone number is complete and valid
            final bool isValid = _isValidPhoneNumber && field.errorText == null;

            return PhoneFormField(
              enabled: widget.enabled,
              initialValue: widget.initialValue as PhoneNumber? ??
                  PhoneNumber.parse('+91'),
              validator: widget.mobileValidator,
              decoration: InputDecoration(
                hintText: 'Enter your mobile number',
                hintStyle: TextStyle(
                  color: AppColors.textfieldOutline.withOpacity(0.5),
                  fontSize: 16,
                ),
                fillColor: AppColors.textfield,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                prefixIcon: widget.prefixIcon,
                suffixIcon: Icon(
                  Icons.check_circle,
                  color: isValid ? AppColors.primaryRedColor : Colors.grey,
                  size: 20,
                ),
              ),
              onChanged: (phoneNumber) {
                _currentPhoneNumber = phoneNumber;
                // Check if the phone number is valid and complete
                _isValidPhoneNumber = phoneNumber.international.isNotEmpty &&
                    phoneNumber.international.length > 5;

                field.didChange(phoneNumber.international);

                // Trigger rebuild to update the suffix icon
                setState(() {});
              },
              onSubmitted: widget.onFieldSubmitted,
              countrySelectorNavigator: const CountrySelectorNavigator.dialog(
                height: 600,
                width: 500,
              ),
              countryButtonStyle: const CountryButtonStyle(
                showIsoCode: false,
                flagSize: 10,
                showDropdownIcon: true,
                showFlag: false,
                textStyle: TextStyle(
                  color: AppColors.textfieldOutline,
                  fontSize: 16,
                ),
              ),
              style: const TextStyle(
                color: AppColors.title,
                fontSize: 16,
              ),
              cursorColor: AppColors.primaryColor,
            );
          },
        ));
  }
}
