import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputCalendar extends StatefulWidget {
  const InputCalendar({Key? key}) : super(key: key);

  @override
  State<InputCalendar> createState() => _InputCalendarState();
}

class _InputCalendarState extends State<InputCalendar> {
  DateTime selected = DateTime.now();
  bool showYears = false;
  bool shoWmonths = false;
  //bool showYears = false;
  ScrollController controller = ScrollController(
    initialScrollOffset: 900.h,
    keepScrollOffset: true,
  );

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      children: [
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {
                setState(() {
                  showYears = !showYears;
                });
              },
              icon: const Icon(Icons.arrow_drop_down),
              style: TextButton.styleFrom(
                elevation: 0,
              ),
              label: Text(
                DateFormat.y().format(
                  selected,
                ),
              ),
            ),
            // TextButton.icon(
            //   onPressed: () {
            //     setState(() {
            //       showYears = !showYears;
            //     });
            //   },
            //   icon: const Icon(Icons.arrow_drop_down),
            //   style: TextButton.styleFrom(
            //     elevation: 0,
            //   ),
            //   label: Text(
            //     DateFormat.MMMM().format(
            //       selected,
            //     ),
            //   ),
            // ),
            // Text(
            //   selected.day.toString(),
            //   style: TextStyle(
            //     color: Theme.of(context).primaryColor,
            //   ),
            // ),
          ],
        ),
        SizedBox(
          width: 360.w,
          //height: 300.h,
          child: showYears
              ? Container(
                  height: 200.h,
                  child: GridView.builder(
                    controller: controller,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 2),
                    itemCount: 150,
                    shrinkWrap: true,
                    itemBuilder: (c, i) {
                      int year = 2050 - i;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(100.w, 10.h),
                              primary: selected.year == year
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              onPrimary: selected.year != year
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).secondaryHeaderColor,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  selected = DateTime(
                                      2050 - i, selected.month, selected.day);
                                  showYears = !showYears;
                                },
                              );
                            },
                            child: Text("${2050 - i}")),
                      );
                    },
                  ),
                )
              : TableCalendar(
                  onHeaderTapped: (focusedDay) {
                    setState(() {
                      showYears = !showYears;
                    });
                  },
                  rowHeight: 40.h,
                  pageJumpingEnabled: true,
                  firstDay: DateTime(1000),
                  onDaySelected: (d1, d2) {
                    setState(() {
                      selected = d1;
                    });
                  },
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    headerPadding: EdgeInsets.zero,
                    // titleTextFormatter: (date, x) {
                    //   return DateFormat.MMMM().format(date);
                    // },
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                  selectedDayPredicate: (day) => day == selected,
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: false,
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  focusedDay: selected,
                  currentDay: selected,
                  lastDay: DateTime(2025),
                  calendarFormat: CalendarFormat.month,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    dowTextFormatter: (date, locale) =>
                        DateFormat.E(locale).format(date)[0],
                    weekdayStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                    weekendStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selected);
              },
              child: const Text("Save"),
            )
          ],
        )
      ],
    );
  }
}
