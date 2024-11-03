import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText; // The hint text to display inside the input
  final IconData icon; // Icon to be displayed in the input
  final int maxLines; // Number of lines the input can take (default is 1)
  final FormFieldValidator<String>? validator; // Validator for form validation
  final TextEditingController? controller; // Controller to handle input text

  const CustomInput({
    super.key,
    required this.hintText, // The hint text must be passed when the widget is used
    required this.icon, // The icon must be passed when the widget is used
    this.controller, // The controller can be optional
    this.maxLines = 1, // Default value for maxLines is 1
    this.validator, // The validator can be optional
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines, // Set the number of lines for the input field
      controller: controller, // Attach the controller if provided
      decoration: InputDecoration(
        hintText: hintText, // Placeholder text inside the field
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(31, 156, 155, 155), // Light gray border color
            width: 2.0, // Border thickness
          ),
          borderRadius:
              BorderRadius.all(Radius.circular(12.5)), // Rounded border
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.redAccent, // Red border when validation fails
            width: 2.0, // Border thickness
          ),
          borderRadius: BorderRadius.all(Radius.circular(12.5)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.redAccent, // Red border when validation fails
            width: 2.0, // Border thickness
          ),
          borderRadius: BorderRadius.all(Radius.circular(12.5)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.indigo, // Indigo border when the field is focused
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12.5)),
        ),
        prefixIcon: Icon(
          icon, // Icon passed via the constructor
          color: Colors.indigo, // Color of the icon
        ),
      ),
      validator: validator, // Attach the validator if provided
      autovalidateMode:
          AutovalidateMode.onUserInteraction, // Validate when the user types
    );
  }
}
