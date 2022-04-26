import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneInput extends StatefulWidget {
  final dynamic onChanged;
  final String? errorText;
  final String label;
  final String? value;
  final String placeholder;
  final bool isLoading;
  //final countryCode;
  final bool isValid;

  const PhoneInput(
      {Key? key,
      required this.placeholder,
      required this.onChanged,
      required this.errorText,
      required this.label,
      this.isValid = false,
      this.isLoading = false,
      this.value})
      : super(key: key);

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  String? isoCode;
  String dialCode = "+267";
  String? phone;

  @override
  initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    phone = widget.value?.split(")").last;
    isoCode = widget.value?.split(")").first.replaceAll("(", "");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 4,
              ),
              child: Text(
                widget.label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  //color: HexColor("#5C6E80"),
                  fontSize: 14,
                ),
              ),
            ),
            TextFormField(
              initialValue: phone,
              keyboardType: TextInputType.phone,
              style: TextStyle(
                fontSize: 14,
                color: HexColor("#A8A8A8"),
              ),
              onChanged: (v) {
                setState(() {
                  phone = v;
                });

                widget.onChanged("($dialCode)$phone");
              },
              decoration: InputDecoration(
                  suffixIcon: widget.isLoading
                      ? SizedBox(
                          height: 10,
                          width: 10,
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : widget.isValid
                          ? Icon(
                              FontAwesomeIcons.solidCheckCircle,
                              color: Colors.lightGreen,
                              size: 13,
                            )
                          : null,
                  errorText: widget.errorText,
                  icon: CountryCodePicker(
                    showFlag: false,
                    onChanged: (cc) {
                      setState(() {
                        dialCode = cc.dialCode ?? "+267";
                        isoCode = cc.code ?? "BW";
                      });
                      if (phone != null) {
                        widget.onChanged("($dialCode)$phone");
                      }
                    },
                    initialSelection: isoCode ?? "BW",
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    favorite: const ["BW"],
                    searchDecoration: InputDecoration(
                      fillColor: HexColor("#F6F7F9"),
                      filled: true,
                      border: const UnderlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    searchStyle: TextStyle(
                      fontSize: 14,
                      color: HexColor("#A8A8A8"),
                    ),
                    dialogTextStyle: TextStyle(
                      fontSize: 14,
                      color: HexColor("#A8A8A8"),
                    ),
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: HexColor("#A8A8A8"),
                    ),
                    alignLeft: false,
                  ),
                  fillColor: HexColor("#F6F7F9"),
                  filled: true,
                  hintText: widget.placeholder,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: HexColor("#A8A8A8"),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
