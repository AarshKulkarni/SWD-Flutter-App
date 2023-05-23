import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:swd_app/main.dart';

import '../screens/user_list_screen.dart';

class NotificationController {
  Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: 'alerts',
              channelName: 'Alerts',
              channelDescription: 'User Notification',
              importance: NotificationImportance.Max,
              channelShowBadge: true,
              playSound: true,
              criticalAlerts: true)
        ],
        channelGroups: [
          NotificationChannelGroup(
            channelGroupKey: 'alerts',
            channelGroupName: 'Alerts',
          )
        ],
        debug: true);
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    });
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
    } else {
      MyApp().navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const UserListScreen()),
          (route) => false);
    }
  }

  Future<void> showNotification(
      {required final String title, required final String body}) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1, channelKey: 'alerts', title: title, body: body));
  }
}
