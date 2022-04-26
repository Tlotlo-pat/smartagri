import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum InfoType { info, error, confirm, options }

class NotificationDialog extends StatefulWidget {
  const NotificationDialog(
      {Key? key, required this.type, required this.message, this.options})
      : super(key: key);
  final InfoType type;
  final String message;
  final List<Widget>? options;

  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: widget.type != InfoType.error
          ? Icon(
              FontAwesomeIcons.infoCircle,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            )
          : Icon(
              FontAwesomeIcons.infoCircle,
              size: 30,
              color: Theme.of(context).colorScheme.secondary,
            ),
      content: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              widget.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      actions: widget.options ??
          [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ],
    );
  }
}
