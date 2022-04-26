import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:smartagri/src/widgets/calendars/input_calendar.dart';

class DateInput extends StatefulWidget {
  const DateInput(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.errorText,
      required this.label,
      required this.placeholder,
      this.isPassword})
      : super(key: key);
  final String? value;
  final Function(String) onChanged;
  final String? errorText;
  final String label;
  final String placeholder;
  final bool? isPassword;

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 10.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              widget.label,
              style: TextStyle(
                color: HexColor("#263245"),
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          ListTile(
            onTap: () async {
              DateTime? date = await showDialog(
                context: context,
                builder: (_) => const InputCalendar(),
              );
              // DateTime? date = await showDatePicker(
              //   context: context,
              //   initialDate: DateTime.now(),
              //   firstDate: DateTime(1000)
              //   lastDate: DateTime(4000),
              // );

              if (date != null) {
                final dateStr = DateFormat.yMd().format(date);
                widget.onChanged(dateStr);
              }
            },
            contentPadding: EdgeInsets.zero,
            minLeadingWidth: 3.w,
            minVerticalPadding: 0,
            isThreeLine: false,
            title: Text(
              widget.value ?? "DD/MM/YYYY",
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
            leading: Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Icon(
                FontAwesomeIcons.solidCalendarAlt,
                color: Theme.of(context).primaryColor,
                size: 20.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
