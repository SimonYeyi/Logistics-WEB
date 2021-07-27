import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistics/comm/account_dao.dart';
import 'package:logistics/manage/account/account_nao.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatelessWidget {
  AccountNao accountNao = AccountNao();
  AccountDao accountDao = AccountDao();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 40),
              Text("大途物流管理系统", style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              TextField(
                controller: accountNameController,
                decoration: InputDecoration(
                  labelText: "帐号",
                  labelStyle: TextStyle(fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: accountPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "密码",
                  labelStyle: TextStyle(fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => login(context),
                  child: Text("登录"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    final accountName = accountNameController.text;
    final password = accountPasswordController.text;
    if (accountName.isEmpty || password.isEmpty) return;
    final accountLoginCommand = AccountLoginCommand(accountName, password);
    try {
      final accountDTO = await accountNao.login(accountLoginCommand);
      await accountDao.save(accountDTO);
      Navigator.of(context).pushReplacementNamed("/");
    } on DioError catch (e) {
      Toast.show(e.response?.data?.toString() ?? "", context, duration: 5);
    }
  }
}
