import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:more_in/constant.dart';

class WebViewScreenBody extends StatefulWidget {
  WebViewScreenBody({super.key, this.url = kWebUrl});
  String url;
  @override
  State<WebViewScreenBody> createState() => _WebViewScreenBodyState();
}

class _WebViewScreenBodyState extends State<WebViewScreenBody> {
  InAppWebViewController? webViewController;
  late PullToRefreshController refreshController;
  late WebUri webUri;
  @override
  void initState() {
    super.initState();
    webUri = WebUri(widget.url);
    refreshController = PullToRefreshController(
      onRefresh: () {
        webViewController!.reload();
      },
      settings: PullToRefreshSettings(
        color: Colors.white,
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<bool> goBack() async {
    if (await webViewController!.canGoBack()) {
      webViewController!.goBack();
      return false;
    } else {
      SystemNavigator.pop();
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool, result) {
       
        goBack();
      },
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                InAppWebView(
                  // onLoadStart: (controller, url) {
                  //   isLoading = true;
                  //   setState(() {});
                  // },
                  pullToRefreshController: refreshController,
                  onLoadStop: (controller, url) {
                    refreshController.endRefreshing();
                    // isLoading = false;
                    setState(() {});
                  },
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },

                  initialUrlRequest: URLRequest(url: webUri),
                ),
                // Visibility(child: CustomLoadingIndicator(), visible: isLoading),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
