// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credentials _$CredentialsFromJson(Map<String, dynamic> json) => Credentials(
      cpf: json['cpf'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$CredentialsToJson(Credentials instance) =>
    <String, dynamic>{
      'cpf': instance.cpf,
      'password': instance.password,
    };
