import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class TextInput extends StatefulWidget {
  const TextInput(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.errorText,
      required this.label,
      required this.placeholder,
      this.isPassword})
      : super(key: key);
  final String? value;
  final Function(String)? onChanged;
  final String? errorText;
  final String label;
  final String placeholder;
  final bool? isPassword;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              widget.label,
              style: TextStyle(
                color: HexColor("#263245"),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            initialValue: widget.value,
            obscureText: (widget.isPassword ?? false) && hidePassword,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              suffixIcon: (widget.isPassword ?? false)
                  ? IconButton(
                      color: HexColor("#C3C8D2"),
                      iconSize: 20,
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(!hidePassword
                          ? FontAwesomeIcons.solidEye
                          : FontAwesomeIcons.solidEyeSlash),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                color: HexColor("#C6CBD4"),
              ),
              errorText: widget.errorText,
              fillColor: HexColor("#F6F7F9"),
              filled: true,
            ),
          )
        ],
      ),
    );
  }
}
