import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final bool needDispose;
  final Function(T model) onModelReady;
  final Widget child;
  final ValueWidgetBuilder<T> builder;
  final T model;

  ProviderWidget(
      {Key key,
      this.needDispose=true,
      this.onModelReady,
      this.child,
      @required this.builder,
      @required this.model});

  @override
  State<StatefulWidget> createState() => ProviderState<T>();
}

class ProviderState<T extends ChangeNotifier> extends State<ProviderWidget<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;
    widget.onModelReady?.call(model);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.needDispose) model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Consumer(
        child: widget.child,
        builder: widget.builder,
      ),
    );
  }
}
