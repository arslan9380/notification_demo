import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:notification_demo/notification_service.dart';
import 'package:notification_demo/widgets/inputfield_widget.dart';

class ScheduleNotification extends StatefulWidget {
  @override
  _ScheduleNotificationState createState() => _ScheduleNotificationState();
}

class _ScheduleNotificationState extends State<ScheduleNotification> {
  TextEditingController titleCon = TextEditingController();
  TextEditingController bodyCon = TextEditingController();
  TextEditingController time1Con = TextEditingController();
  TextEditingController time2Con = TextEditingController();
  DateTime selectedTime1 = DateTime.now();
  DateTime selectedTime2 = DateTime.now();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Demo"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                InputFieldWidget(
                  controller: titleCon,
                  hint: "title",
                ),
                SizedBox(
                  height: 20,
                ),
                InputFieldWidget(
                  controller: bodyCon,
                  hint: "body",
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      showPicker(
                        blurredBackground: true,
                        dialogInsetPadding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05),
                        iosStylePicker: false,
                        context: context,
                        value: TimeOfDay.fromDateTime(selectedTime1),
                        onChange: (value) {},
                        minuteInterval: MinuteInterval.ONE,
                        minMinute: 0,
                        maxMinute: 59,
                        is24HrFormat: false,
                        onChangeDateTime: (DateTime dateTime) {
                          setState(() {
                            selectedTime1 = dateTime;
                            time1Con.text =
                                DateFormat("hh:mm").format(selectedTime1);
                          });
                        },
                      ),
                    );
                  },
                  child: InputFieldWidget(
                    controller: time1Con,
                    enable: false,
                    hint: "Pick Time 1",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      showPicker(
                        blurredBackground: true,
                        accentColor: Color(0xff9BCA27),
                        dialogInsetPadding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05),
                        iosStylePicker: false,
                        context: context,
                        value: TimeOfDay.fromDateTime(selectedTime2),
                        onChange: (value) {},
                        minuteInterval: MinuteInterval.ONE,
                        disableHour: false,
                        disableMinute: false,
                        minMinute: 0,
                        maxMinute: 59,
                        is24HrFormat: true,
                        onChangeDateTime: (DateTime dateTime) {
                          setState(() {
                            selectedTime2 = dateTime;
                            time2Con.text =
                                DateFormat("hh:mm").format(selectedTime2);
                          });
                        },
                      ),
                    );
                  },
                  child: InputFieldWidget(
                    controller: time2Con,
                    enable: false,
                    hint: "Pick time 2",
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: scheduleMyNotification,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Theme.of(context).primaryColor,
                    child: Center(child: Text("Schedule")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  scheduleMyNotification() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(seconds: 1));
    String notificationTitle = titleCon.text;
    String notificationBody = bodyCon.text;

    NotificationService().showNotification(notificationTitle, notificationBody,
        selectedTime1, 0); //This way you can call notification functions.
    NotificationService().showNotification(
        notificationTitle, notificationBody, selectedTime2, 1);

    setState(() {
      loading = false;
    });

    Fluttertoast.showToast(msg: "Notification Schedule successfully");
  }
}
