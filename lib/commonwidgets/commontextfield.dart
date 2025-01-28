import 'package:flutter/material.dart';

Widget commonTextfield({controller, obstxt, preFixIcon, hinttext, suFFixIcon, suffIconPressed, required BuildContext context}){
  return TextField(
    controller: controller,
    obscureText: obstxt ?? false,
    decoration: InputDecoration(
      prefixIcon: Icon(preFixIcon,color: Theme.of(context).appBarTheme.foregroundColor,),
      hintText: hinttext,
      suffixIcon: IconButton(onPressed: suffIconPressed, icon: Icon(suFFixIcon,color: Theme.of(context).appBarTheme.foregroundColor,)),
      enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Theme.of(context).appBarTheme.foregroundColor!,
              width: 0.4,
            )
        ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Theme.of(context).appBarTheme.foregroundColor!,
            width: 1.0,
          )
      ),
    ),
  );
}