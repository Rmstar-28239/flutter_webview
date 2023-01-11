import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShopPage extends StatefulWidget {
  ShopPage({Key key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String _title = 'Himdeve Shop';

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _buildWebView(),
      floatingActionButton: _buildShowUrlBtn(),
    );
  }

  Widget _buildWebView() {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: 'https://himdeve.eu',
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
    );
  }

  Widget _buildShowUrlBtn() {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          return FloatingActionButton(
            onPressed: () async {
              var url = await controller.data.currentUrl();
               Fluttertoast.showToast(msg: ""+url,gravity:ToastGravity.BOTTOM);
            },
            child: Icon(Icons.link),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildChangeTitleBtn() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          _title = 'Himdeve Development Tutorial';
        });
      },
      child: Icon(Icons.link),
    );
  }
}