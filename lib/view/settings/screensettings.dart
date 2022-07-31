import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:one/util/color/app_colors.dart';
import 'package:one/view/Homepage/home.dart';
import 'package:one/view/pageSettings/screensettings.dart';
import 'package:one/view/widget/notificationwidget.dart';
import 'package:one/view/widget/resetpopup.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SreenSettings extends StatefulWidget {
  const SreenSettings({Key? key}) : super(key: key);

  @override
  State<SreenSettings> createState() => _SreenSettingsState();
}

class _SreenSettingsState extends State<SreenSettings> {
  TimeOfDay currentTime = TimeOfDay.now();
  bool _switchvalue = true;
  @override
  void initState() {
    super.initState();
    NotificationApi().init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() {
    NotificationApi.onNotifications.listen(onClickNotifications);
  }

  onClickNotifications(String? payload) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const MainScreen(),
    ));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueColor,
        title: const Text(
          'Settings',
          textScaleFactor: 1.3,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF223055),
                      radius: 20,
                      child: Icon(
                        Icons.hourglass_top_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Set Daily Limit',
                      textScaleFactor: 1.6,
                      style: TextStyle(
                          fontFamily: 'Settingsfont',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [Icon(Icons.arrow_forward_ios)]),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Settings()));
              },
            ),
            InkWell(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF223055),
                      radius: 20,
                      child: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Contact Us',
                      textScaleFactor: 1.6,
                      style: TextStyle(
                          fontFamily: 'Settingsfont',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [Icon(Icons.arrow_forward_ios)]))
                ],
              ),
              onTap: () {
                _url();
              },
            ),
            InkWell(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF223055),
                      radius: 20,
                      child: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Share this App',
                      textScaleFactor: 1.6,
                      style: TextStyle(
                          fontFamily: 'Settingsfont',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [Icon(Icons.arrow_forward_ios)]),
                  ),
                ],
              ),
              onTap: ()async{
                Share.share('Hey! check out this new app https://play.google.com/store/apps/details?id=com.fouty.pocket_trace');
              },
            ),
            InkWell(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF223055),
                      radius: 20,
                      child: Icon(
                        Icons.notification_add_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Notifications',
                      textScaleFactor: 1.6,
                      style: TextStyle(
                          fontFamily: 'Settingsfont',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Switch(
                            activeColor:kBlueColor,
                            value: _switchvalue,
                            onChanged: (bool value) {
                              setState(() {
                                _switchvalue = value;
                              });
                            })
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () {
                timePicking(context: context);
              },
            ),
            InkWell(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF223055),
                      radius: 20,
                      child: Icon(
                        Icons.restart_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Reset App',
                      textScaleFactor: 1.6,
                      style: TextStyle(
                          fontFamily: 'Settingsfont',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [Icon(Icons.arrow_forward_ios)]))
                ],
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return dialogShow(ctx);
                    });
              },
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Version : 1.0.0',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _url() async {
    // ignore: deprecated_member_use
    if (await launch('mailto:jishnupvkd@gmail.com')) {
      throw 'could not launch';
    }
  }

  timePicking({required context}) async {
    final TimeOfDay? pickedTIme = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: currentTime,
    );
    if (pickedTIme != null && pickedTIme != currentTime) {
      setState(
        () {
          NotificationApi.showScheduledNotifications(
              title: "Pocket Trace",
              body: "You forgot to add something !",
              scheduledTime: Time(pickedTIme.hour, pickedTIme.minute, 0));
        },
      );
    }
  }
}
