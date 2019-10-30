import 'package:fancy_android/http/http_methods.dart';
import 'package:fancy_android/model/user_model.dart';
import 'package:fancy_android/util/provider_util.dart';
import 'package:fancy_android/util/sharedPreferences_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _accountController = TextEditingController();
  final _pwdController = TextEditingController();

  bool doLoginOrRegister = true; //true:Login false:Register

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(doLoginOrRegister ? '登录' : '注册'),
      ),
      body: _buildLoginOrRegisterPage(),
    );
  }

  Widget _buildLoginOrRegisterPage() {
    return Column(
      children: <Widget>[
        _buildTextField(_accountController, '请输入帐号'),
        _buildTextField(_pwdController, '请输入密码'),
        _buildLoginOrRegister(doLoginOrRegister ? '登录' : '注册'),
        _buildRegister(),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Container(
      margin: EdgeInsets.all(15),
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.red,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
        controller: controller,
        style: TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  Widget _buildLoginOrRegister(String btnText) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(10),
        color: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          alignment: Alignment.center,
          height: 50,
          child: Text(
            btnText,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        _login();
      },
    );
  }

  Widget _buildRegister() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        child: Text(
          '还不是用户？注册',
          style: TextStyle(
            fontSize: 16,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () {
        _changeToRegister();
      },
    );
  }

  void _changeToRegister() {
    setState(() {
      this.doLoginOrRegister = !doLoginOrRegister;
    });
  }

  _login() async {
    HttpMethods.getInstance()
        .login(_accountController.text, _pwdController.text)
        .then((result) {
//      ProviderUtil.consumer<UserModel>(builder: (context, userModel, child) {
//        userModel.setUserInfo(result);
//      });
      Provider.of<UserModel>(context).setUserInfo(result['data']);
      Navigator.pop(context);
    });
  }
}
