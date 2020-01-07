import 'package:flutter/material.dart';

class ViewStateLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: CircularProgressIndicator());
  }
}

class ViewStateErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback onPressed;

  const ViewStateErrorWidget(
      {Key key, @required this.error, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 200,),
          Text(error == null ? "错误" : error),
          SizedBox(height: 50,),
          RaisedButton(
            onPressed: this.onPressed,
            child: Text("重试"),
          ),
        ],
      ),
    );
  }
}

class ViewStateEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text("空"),
    );
  }
}
