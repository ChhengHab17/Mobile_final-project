import 'package:flutter/material.dart';
import '../../model/subscription_plan.dart';

class SubscriptionState extends ChangeNotifier {
  SubscriptionModel? _activePass;
  DateTime? _expireDate;

  SubscriptionModel? get activePass => _activePass;
  DateTime? get expireDate => _expireDate;

  bool get hasActivePass => _activePass != null;

  void setActivePass(SubscriptionModel pass) {
    _activePass = pass;

    final now = DateTime.now();

    switch (pass.period) {
      case "day":
        _expireDate = now.add(const Duration(days: 1));
        break;
      case "month":
        _expireDate = DateTime(now.year, now.month + 1, now.day);
        break;
      case "year":
        _expireDate = DateTime(now.year + 1, now.month, now.day);
        break;
      default:
        _expireDate = null;
    }

    notifyListeners();
  }

  void cancelPass() {
    _activePass = null;
    _expireDate = null;
    notifyListeners();
  }
}
