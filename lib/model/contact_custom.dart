import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';

class ContactCustom extends Contact {


  String _identifier,
      _displayName,
      _givenName,
      _middleName,
      _prefix,
      _suffix,
      _familyName,
      _company,
      _jobTitle;
  String _androidAccountTypeRaw, _androidAccountName, _relation;
  AndroidAccountType _androidAccountType;
  Iterable<Item> _emails = [];
  Iterable<Item> _phones = [];
  Iterable<PostalAddress> _postalAddresses = [];
  Uint8List _avatar;
  DateTime _birthday;


  ContactCustom(
      this._identifier,
      this._displayName,
      this._givenName,
      this._middleName,
      this._prefix,
      this._suffix,
      this._familyName,
      this._company,
      this._jobTitle,
      this._androidAccountTypeRaw,
      this._androidAccountName,
      this._relation,
      this._androidAccountType,
      this._emails,
      this._phones,
      this._postalAddresses,
      this._avatar,
      this._birthday);

  set identifier(String value) {
    _identifier = value;
  }

  DateTime get birthday => _birthday;

  set birthday(DateTime value) {
    _birthday = value;
  }

  Uint8List get avatar => _avatar;

  set avatar(Uint8List value) {
    _avatar = value;
  }

  Iterable<PostalAddress> get postalAddresses => _postalAddresses;

  set postalAddresses(Iterable<PostalAddress> value) {
    _postalAddresses = value;
  }

  Iterable<Item> get phones => _phones;

  set phones(Iterable<Item> value) {
    _phones = value;
  }

  Iterable<Item> get emails => _emails;

  set emails(Iterable<Item> value) {
    _emails = value;
  }

  AndroidAccountType get androidAccountType => _androidAccountType;

  set androidAccountType(AndroidAccountType value) {
    _androidAccountType = value;
  }

  get relation => _relation;

  set relation(value) {
    _relation = value;
  }

  get androidAccountName => _androidAccountName;

  set androidAccountName(value) {
    _androidAccountName = value;
  }

  String get androidAccountTypeRaw => _androidAccountTypeRaw;

  set androidAccountTypeRaw(String value) {
    _androidAccountTypeRaw = value;
  }

  get jobTitle => _jobTitle;

  set jobTitle(value) {
    _jobTitle = value;
  }

  get company => _company;

  set company(value) {
    _company = value;
  }

  get familyName => _familyName;

  set familyName(value) {
    _familyName = value;
  }

  get suffix => _suffix;

  set suffix(value) {
    _suffix = value;
  }

  get prefix => _prefix;

  set prefix(value) {
    _prefix = value;
  }

  get middleName => _middleName;

  set middleName(value) {
    _middleName = value;
  }

  get givenName => _givenName;

  set givenName(value) {
    _givenName = value;
  }

  get displayName => _displayName;

  set displayName(value) {
    _displayName = value;
  }

}
