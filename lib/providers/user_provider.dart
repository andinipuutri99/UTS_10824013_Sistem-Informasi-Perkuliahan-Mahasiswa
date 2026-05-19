// lib/providers/user_provider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../databases/database_helper.dart';

class UserProvider extends ChangeNotifier {
  UserProfile? _user;
  bool _isAuthenticated = false;

  UserProfile? get user => _user;
  bool get isAuthenticated => _isAuthenticated;

  UserProvider() {
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUser = prefs.getString('kampusin_user');
    if (savedUser != null) {
      _user = UserProfile.fromJson(jsonDecode(savedUser));
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<void> login(String nim, String password) async {
    final db = DatabaseHelper.instance;

    final result = await db.getUser(nim, password);

    if (result != null) {
      _user = UserProfile.fromJson(result);
      _isAuthenticated = true;
      notifyListeners();
      return;
    }

    throw Exception('NIM atau password salah');
  }

  Future<void> register({
    required String fullName,
    required String nim,
    required String username,
    required String email,
    required String className,
    required String studyProgram,
    required String faculty,
    required String yearOfEntry,
    required String password,
  }) async {
    final db = DatabaseHelper.instance;

    final user = {
      'fullName': fullName,
      'nim': nim,
      'username': username,
      'email': email,
      'className': className,
      'studyProgram': studyProgram,
      'faculty': faculty,
      'yearOfEntry': yearOfEntry,
      'password': password,
      'points': 100,
      'level': 'Bronze',
    };

    try {
      await db.createUser(user);
    } catch (e) {
      throw Exception('NIM sudah terdaftar');
    }
  }

  Future<void> logout() async {
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> updateProfile(UserProfile updated) async {
    _user = updated;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('kampusin_user', jsonEncode(updated.toJson()));
    notifyListeners();
  }

  Future<void> addPoints(int amount) async {
    if (_user == null) return;
    final newPoints = (_user!.points + amount).clamp(0, 999999);
    String newLevel = _user!.level;
    if (newPoints > 1000) {
      newLevel = 'Gold';
    } else if (newPoints > 500) {
      newLevel = 'Silver';
    }
    final updated = _user!.copyWith(points: newPoints, level: newLevel);
    await updateProfile(updated);
  }
}

extension DateTimeExt on DateTime {
  String toDateString() => '$year-$month-$day';
}
