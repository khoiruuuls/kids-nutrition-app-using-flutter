import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;
  late String currentUserId; // Make it non-nullable

  final flutterLocalNotification = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission();
    final token = await firebaseMessaging.getToken();

    // Access the current user after authentication
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      currentUserId = user.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({'token': token});

      var androidInitilize =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettings =
          InitializationSettings(android: androidInitilize);
      flutterLocalNotification.initialize(initializationSettings,
          onSelectNotification: (String? payload) {
        try {
          if (payload != null && payload.isNotEmpty) {
          } else {}
          // ignore: empty_catches
        } catch (e) {}
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print("========================= Message =========================");
        print(
            "onMessage : ${message.notification?.title}/${message.notification?.body}");

        BigTextStyleInformation bigText = BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContentTitle: true,
        );

        AndroidNotificationDetails androidNotification =
            AndroidNotificationDetails(
          'kids-nutritions-app-channel-id',
          'kids-nutritions-app-channel-name',
          importance: Importance.high,
          styleInformation: bigText,
          priority: Priority.high,
          playSound: true,
        );

        NotificationDetails notificationDetails =
            NotificationDetails(android: androidNotification);

        await flutterLocalNotification.show(
          0,
          message.notification?.title,
          message.notification?.body,
          notificationDetails,
          payload: message.data['body'],
        );
      });
    }
  }
}
