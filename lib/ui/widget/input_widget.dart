
import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final String hint;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final bool autoFocus;
  final FocusNode focusNode;

  InputWidget({
    Key key,
    this.hint,
    this.obscureText,
    this.validator,
    this.controller, this.autoFocus=false, this.focusNode,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return InputState();
  }
}

class InputState extends State<InputWidget> {
  TextEditingController _controller;

  ValueNotifier<bool> _valueNotifier;
  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _valueNotifier = ValueNotifier(true);
    _obscureText = widget.obscureText;
    _controller.addListener(() {
      _valueNotifier.value = _controller.text.isEmpty;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _valueNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness==Brightness.dark?Colors.grey[700]:Colors.grey[300],
          borderRadius: BorderRadius.all(Radius.circular(6))),
      margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: TextFormField(
        focusNode: widget.focusNode,
        autofocus: widget.autoFocus,
        maxLines: 1,
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.hint,
          border: InputBorder.none,
          suffixIcon: Builder(builder: (context) {
            if (widget.obscureText) {
              return InkWell(
                child: Icon(
                  Icons.remove_red_eye,
                  color: !_obscureText
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              );
            } else {
              return ValueListenableBuilder(
                valueListenable: _valueNotifier,
                builder: (context, bool, child) {
                  return Offstage(
                    offstage: _valueNotifier.value,
                    child: InkWell(
                      child: Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        WidgetsBinding.instance
                            .addPostFrameCallback((_) => _controller.clear());
                      },
                    ),
                  );
                },
              );
            }
          }),
        ),
        validator: widget.validator,
        obscureText: _obscureText,
      ),
    );
  }
}