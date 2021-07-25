import 'dart:convert';

import 'package:logistics/manage/account/account_nao.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountDao {
  Future<void> save(AccountDTO accountDTO) async {
    final accountSp = await SharedPreferences.getInstance();
    accountSp.setString("account", jsonEncode(accountDTO.toJson()));
  }

  Future<AccountDTO?> find() async {
    final accountSp = await SharedPreferences.getInstance();
    final accountDTOJson = accountSp.getString("account");
    if (accountDTOJson == null) return null;
    return AccountDTO.fromJson(jsonDecode(accountDTOJson));
  }
}
