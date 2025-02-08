import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:more_in/constant.dart';
import 'package:more_in/features/webview/presentation/view_model/web_view_cubit/web_view_cubit.dart';
import 'package:more_in/features/webview/presentation/views/widgets/web_view_screen_body.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key});

  static String id = 'WebViewScreen';
  // String? url;
  @override
  Widget build(BuildContext context) {
    var url = ModalRoute.of(context)!.settings.arguments as String? ;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<WebViewCubit, WebViewState>(
          builder: (context, state) {
            if (state is WebViewFailure) {
              return Text('${state.errorMessage}');
            } else {
              return WebViewScreenBody(url: url?? kWebUrl);
            }
          },
        ),
      ),
    );
  }
}
