import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:more_in/constant.dart';
import 'package:more_in/features/webview/presentation/views/webview_screen.dart';
import 'package:more_in/main.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await FirebaseNotifications.instance.setupFlutterNotifications();
  await FirebaseNotifications.instance.showNotification(message);
}

//create single tone class
//  create instance from FirebaseMessaging
// create instance from FlutterLocalNotificationsPlugin
// boolean to know if FlutterLocalNotificationsPlugin is initialized
// getToken method
//permission request method
// handleMessage method
//
class FirebaseNotifications {
  FirebaseNotifications._internal();
  static final FirebaseNotifications instance =
      FirebaseNotifications._internal();
  final firebaseMessage = FirebaseMessaging.instance;
  final flutterLocalNotification = FlutterLocalNotificationsPlugin();
  bool isFlutterLocalNotificationInitialized = false;
  Future<void> initNotifications() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await permissionRequest();
    await getFCMToken();
    await initPushNotification();
  }

  Future<void> permissionRequest() async {
    NotificationSettings settings = await firebaseMessage.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
  }

  Future<String> getFCMToken() async {
    final fcmToken = await firebaseMessage.getToken() ?? '';
    log('token is $fcmToken');
    return fcmToken;
  }

  //method handles notifications received when the app is opened.
  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationInitialized) {
      return;
    }
    // android setup
    const channel = AndroidNotificationChannel(
      kChannelId, //Channel ID
      kChannelName, //Channel Name
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );
    await flutterLocalNotification
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
    // here we specify icon for notification in android
    const initializationSettingsAndroid = AndroidInitializationSettings(kLogo);
    //ios setup
    final initializationSettingsDarwin = DarwinInitializationSettings();
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotification.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {},
    );
    isFlutterLocalNotificationInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await flutterLocalNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            kChannelId,
            kChannelName,
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: handleForegroundMessageUrl(message),
      );
    }
  }

  void handleMessage(RemoteMessage? message ,Duration? duration) async {
    if (message == null || message.data.isEmpty) {
    } else {
      String? url;
      message.data.forEach((key, value) {
        if (key == "url") {
          url = value;
        }
        log('$key: $value');
      });
      log('messsssssssageeeeeeeeeee ${message.data.toString()}');
      navigatorKey.currentState!.pushNamed(WebViewScreen.id, arguments: url);
    }
  }

  // String handleForegroundMessageUrl(RemoteMessage message) {
  //   String? url = null;
  //   if (message.data.isEmpty) {
  //     return url ?? '';
  //   } else {
  //     message.data.forEach((key , va){})
  //   }
  //   {}
  // }

  String handleForegroundMessageUrl(RemoteMessage message) {
    String? url;
    message.data.forEach((key, value) {
      if (key == "url") {
        url = value;
      }
      log('$key: $value');
    });
    log('messsssssssageeeeeeeeeee ${message.data.toString()}');
    navigatorKey.currentState!.pushNamed(WebViewScreen.id, arguments: url);
    return url ?? '';
  }

  Future initPushNotification() async {
    onForegroundMessage();
    appTerminatedNotification();
    onAppOpenedNotification();
    handleBackgroundNotification();
  }

  //handle foreground message
  void onForegroundMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });
  }

  void appTerminatedNotification() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      handleMessage(message , Duration(seconds: 3));
    });
  }

  //handel background notification
  void onAppOpenedNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleMessage(message, Duration(seconds: 3));
    });
  }

  void handleBackgroundNotification() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}
