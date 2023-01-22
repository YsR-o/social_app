import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../styles/icon_broken.dart';

Widget defaultButton({
  required String text,
  required dynamic onPressed,
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
}) {
  return Container(
    width: width,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      color: background,
    ),
    child: MaterialButton(
      onPressed: onPressed,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  String? Function(String?)? validate,
  VoidCallback? onTap,
  Function? onChange,
  bool isPassword = false,
  IconData? suffix,
  VoidCallback? suffixPressed,
}) {
  return TextFormField(
    validator: validate,
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onTap: () {
      onTap!();
      print('Taped');
    },
    onChanged: (String s) => onChange!(s),
    decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: suffixPressed,
        ),
        label: Text(label),
        prefixIcon: Icon(prefix),
        border: const OutlineInputBorder()),
  );
}

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) {
  return AppBar(
    titleSpacing: 0.0,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(IconBroken.Arrow___Left_2),
    ),
    title: Text(title??''),
    actions: actions,
  );
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndKill(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
