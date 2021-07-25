import 'package:logistics/comm/logistic_dio.dart';
import 'package:retrofit/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';

part 'account_nao.g.dart';

@RestApi()
abstract class AccountNao {
  factory AccountNao() => _AccountNao(logisticsDio);

  @POST("/account/login")
  Future<AccountDTO> login(@Body() AccountLoginCommand accountLoginCommand);
}

@JsonSerializable()
class AccountDTO {
  final num accountId;
  final String accountName;
  final String token;
  final String refreshToken;

  AccountDTO(this.accountId, this.accountName, this.token, this.refreshToken);

  @override
  String toString() {
    return 'AccountDTO{accountId: $accountId, accountName: $accountName, token: $token, refreshToken: $refreshToken}';
  }

  factory AccountDTO.fromJson(Map<String, dynamic> json) =>
      _$AccountDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDTOToJson(this);
}

@JsonSerializable()
class AccountLoginCommand {
  final String accountName;
  final String password;

  AccountLoginCommand(this.accountName, this.password);

  Map<String, dynamic> toJson() => _$AccountLoginCommandToJson(this);
}
