import 'package:bloc/bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:meta/meta.dart';

part 'web_view_state.dart';

class WebViewCubit extends Cubit<WebViewState> {
  WebViewCubit() : super(WebViewInitial());

  webViewData() {
    // emit(WebViewLoading());
    try {
      WebUri webUri = WebUri.uri(Uri.parse('https://more.neomindeg.com/'));
      emit(WebViewSuccess());
    } catch (e) {
      emit(WebViewFailure(errorMessage: e.toString(),),);
    }
  }
}
