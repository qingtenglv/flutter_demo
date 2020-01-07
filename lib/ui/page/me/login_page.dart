import 'package:demo/config/resource_mananger.dart';
import 'package:demo/config/router_manager.dart';
import 'package:demo/ui/widget/input_widget.dart';
import 'package:demo/ui/widget/provider_widget.dart';
import 'package:demo/view_model/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  TextEditingController _accountController;
  TextEditingController _passwordController;
  FocusNode _accountFocusNode;
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _accountController = new TextEditingController();
    _passwordController = new TextEditingController();
    _accountFocusNode=new FocusNode();
    _passwordFocusNode=new FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("登录"),
        ),
        body: ProviderWidget<LoginModel>(
          model: LoginModel(Provider.of(context)),
          onModelReady: (model) => _accountController.text = model.getAccount(),
          builder: (context, model, child) {
            return Form(
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
                                focusNode: _accountFocusNode,
                                autoFocus: true,
                                controller: _accountController,
                                hint: "账号",
                                obscureText: false,
                                validator: (value) {
                                  return value.trim().length > 0
                                      ? null
                                      : "用户名不能为空";
                                },
                              ),
                              InputWidget(
                                focusNode: _passwordFocusNode,
                                controller: _passwordController,
                                hint: "密码",
                                obscureText: true,
                                validator: (value) {
                                  return value.trim().length > 0
                                      ? null
                                      : "密码不能为空";
                                },
                              ),
                              Container(
                                  constraints:
                                      BoxConstraints.expand(height: 45),
                                  margin: EdgeInsets.fromLTRB(30, 30, 30, 10),
                                  child: Builder(builder: (context) {
                                    return RaisedButton(
                                      child: model.isLoading
                                          ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white),)
                                          : Text(
                                              "登录",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {
                                        _accountFocusNode.unfocus();
                                        _passwordFocusNode.unfocus();
                                        if (model.isLoading) return;
                                        if (Form.of(context).validate()) {
                                          model
                                              .login(
                                                  account:
                                                      _accountController.text,
                                                  password:
                                                      _passwordController.text)
                                              .then((value) {
                                            if (value) {
                                              Navigator.of(context).pop();
                                            } else {
                                              model.showErrorToast(context);
                                            }
                                          });
                                        }
                                      },
                                    );
                                  })),
                              Align(
                                alignment: Alignment.topRight,
                                child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(RouteName.REGISTER)
                                          .then((value) =>
                                              _accountController.text = value);
                                    },
                                    child: Text("去注册")),
                              )
                            ],
                          ),
                        ],
                      ),
                    )));
          },
        ));
  }
}
