import 'package:flutter/material.dart';
import 'package:more_in/features/splash/presentation/views/widgets/spalsh_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: SplashViewBody());
  }
}
