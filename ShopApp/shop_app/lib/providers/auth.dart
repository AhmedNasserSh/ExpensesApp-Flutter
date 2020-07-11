import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_Exceptions.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer authTimer;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) return _token;
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _auth(String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyC8KZhETV-av98R2mdFJAVs6s_SAeR5DrU';
    final response = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    final data = json.decode(response.body);
    if (data == null) {
      return;
    }
    if (data['error'] != null) {
      throw HTTPException(data['error']['message']);
    }
    _token = data['idToken'];
    _userId = data['localId'];
    _expiryDate =
        DateTime.now().add(Duration(seconds: int.parse(data['expiresIn'])));
    _autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(
      {
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String()
      },
    );
    prefs.setString('userData', userData);
  }

  Future<void> signup(String email, String password) async {
    return _auth(email, password, 'signUp');
  }

  Future<void> signin(String email, String password) async {
    return _auth(email, password, 'signInWithPassword');
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final userData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(userData['expiryDate']);
    if (expiryDate == null) {
      return false;
    }
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = userData['token'];
    _userId = userData['userId'];
    _expiryDate = expiryDate;
    //  notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (authTimer != null) {
      authTimer.cancel();
      authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  void _autoLogout() {
    if (authTimer != null) {
      authTimer.cancel();
      authTimer = null;
    }
    final timeToExpire = _expiryDate.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: timeToExpire), logout);
  }
}
