import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:more_in/core/utils/firebase_notifications.dart';
import 'package:more_in/core/utils/simple_bloc_observer.dart';

import 'package:more_in/features/splash/presentation/views/spalsh_view.dart';
import 'package:more_in/features/webview/presentation/view_model/web_view_cubit/web_view_cubit.dart';
import 'package:more_in/features/webview/presentation/views/webview_screen.dart';
import 'package:more_in/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   FirebaseNotifications.instance.handleBackgroundNotification();
  await FirebaseNotifications.instance.initNotifications();
  
  Bloc.observer = SimpleBlocObserver();
  // OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // OneSignal.initialize("0d5000c6-4322-4166-aaea-2e7967a69cb2");
  // OneSignal.Notifications.requestPermission(true);
  runApp(const MoreApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MoreApp extends StatelessWidget {
  const MoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WebViewCubit(),
      child: GetMaterialApp(
        routes: {WebViewScreen.id: (context) => WebViewScreen()},
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: SplashView(),
      ),
    );
  }
}
