import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';

class ContactCustom {
  ContactCustom(
      {this.displayName,
      this.givenName,
      this.middleName,
      this.prefix,
      this.suffix,
      this.familyName,
      this.company,
      this.jobTitle,
      this.emails,
      this.phones,
      this.postalAddresses,
      this.avatar,
      this.birthday,
      this.androidAccountType,
      this.androidAccountTypeRaw,
      this.androidAccountName,
      this.relation});

  String identifier,
      displayName,
      givenName,
      middleName,
      prefix,
      suffix,
      familyName,
      company,
      jobTitle;
  String androidAccountTypeRaw, androidAccountName, relation;
  AndroidAccountType androidAccountType;
  Iterable<Item> emails = [];
  Iterable<Item> phones = [];
  Iterable<PostalAddress> postalAddresses = [];
  Uint8List avatar;
  DateTime birthday;
}
