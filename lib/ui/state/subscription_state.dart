import 'package:flutter/material.dart';
import '../../model/subscription_plan.dart';

class UserPassState extends ChangeNotifier {
  SubscriptionModel? _activePass;

  SubscriptionModel? get activePass => _activePass;
  bool get hasActivePass => _activePass != null;

  void setActivePass(SubscriptionModel pass) {
    _activePass = pass;
    notifyListeners();
  }

  void cancelPass() {
    _activePass = null;
    notifyListeners();
  }
}
