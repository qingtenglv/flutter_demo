import 'package:demo/config/resource_mananger.dart';
import 'package:demo/ui/widget/input_widget.dart';
import 'package:demo/ui/widget/provider_widget.dart';
import 'package:demo/view_model/register_model.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<RegisterPage> {
  TextEditingController _accountController,
      _passwordController,
      _rePasswordController;

  @override
  void initState() {
    super.initState();
    _accountController = TextEditingController();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("注册"),
        ),
        body: Form(
            child: Container(
                constraints: BoxConstraints.expand(),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset(
                            ImageHelper.connectAssets("ic_wandroid.png"),
                            color: Theme.of(context).primaryColor,
                            width: 120,
                          ),
                          InputWidget(
                            controller: _accountController,
                            hint: "账号",
                            autoFocus: true,
                            obscureText: false,
                            validator: (value) {
                              return value.trim().length > 0 ? null : "用户名不能为空";
                            },
                          ),
                          InputWidget(
                            controller: _passwordController,
                            hint: "密码",
                            obscureText: true,
                            validator: (value) {
                              return value.trim().length > 0 ? null : "密码不能为空";
                            },
                          ),
                          InputWidget(
                            controller: _rePasswordController,
                            hint: "确认密码",
                            obscureText: true,
                            validator: (value) {
                              return value.trim().length > 0
                                  ? null
                                  : "确认密码不能为空";
                            },
                          ),
                          Container(
                              constraints: BoxConstraints.expand(height: 45),
                              margin: EdgeInsets.fromLTRB(30, 30, 30, 10),
                              child: ProviderWidget<RegisterModel>(
                                model: RegisterModel(),
                                builder: (context, model, child) {
                                  return RaisedButton(
                                    child: model.isLoading
                                        ? CircularProgressIndicator(valueColor:AlwaysStoppedAnimation(Colors.white),)
                                        : Text(
                                            "注册",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      if (model.isLoading) return;
                                      if (Form.of(context).validate()) {
                                        model
                                            .register(
                                                account:
                                                    _accountController.text,
                                                password:
                                                    _passwordController.text,
                                                rePassword:
                                                    _rePasswordController.text)
                                            .then((value) {
                                          if (value) {
                                            Navigator.of(context)
                                                .pop(_accountController.text);
                                          } else {
                                            model.showErrorToast(context);
                                          }
                                        });
                                      }
                                    },
                                  );
                                },
                              )),
                        ],
                      ),
                    ],
                  ),
                ))));
  }
}
