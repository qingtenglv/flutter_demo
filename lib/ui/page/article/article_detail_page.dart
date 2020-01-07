
import 'package:demo/model/article.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailPage extends StatefulWidget {
  final Article article;

  const ArticleDetailPage({Key key, this.article}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ArticleDetailState();
  }
}

class ArticleDetailState extends State<ArticleDetailPage> {
  Article _article;
  FlutterWebviewPlugin _flutterWebViewPlugin;


  @override
  void initState() {
    super.initState();
    _article = widget.article;
    _flutterWebViewPlugin = FlutterWebviewPlugin();
  }

  @override
  void dispose() {
    _flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(_article.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {_flutterWebViewPlugin.reload();},
          ),
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              launch(widget.article.link, forceSafariVC: false);
            },
          ),
        ],
      ),
      body: WebviewScaffold(url: _article.link),
    );
  }
}
