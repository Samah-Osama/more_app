part of 'web_view_cubit.dart';

@immutable
sealed class WebViewState {}

final class WebViewInitial extends WebViewState {}

// final class WebViewLoading extends WebViewState {}

final class WebViewSuccess extends WebViewState {}

final class WebViewFailure extends WebViewState {
  final String errorMessage;

  WebViewFailure({required this.errorMessage});
}
