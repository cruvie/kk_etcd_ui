import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_user_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/pages/page_user/logic/state_user.dart';
import 'package:kk_etcd_ui/utils/tools/local_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_global.g.dart';

class StateGlobal {
  PBUser currentUser = PBUser();

  String serverAddr = '';

  PageController pageController = PageController();
}

@Riverpod(keepAlive: true)
class Global extends _$Global {
  @override
  StateGlobal build() {
    return StateGlobal();
  }

  Future<void> refreshCurrentUser() async {
    await ref.read(userProvider.notifier).getMyInfo();
  }

  Future<void> init() async {
    state.serverAddr = await LSServerAddr.get();
    ref.notifyListeners();
  }

  Future<void> setServerAddr(String addr) async {
    state.serverAddr = addr;
    ref.notifyListeners();
  }

  updateCurrentUser(PBUser info) async {
    state.currentUser = info;
    await LSMyInfo.set(state.currentUser);
    ref.notifyListeners();
  }

  PBUser getCurrentUser() {
    return state.currentUser;
  }

  void resetCurrentUser() {
    state.currentUser = PBUser();
    ref.notifyListeners();
  }

  initPageController() {
    state.pageController = PageController();
    ref.notifyListeners();
  }

  disposePageController() {
    state.pageController.dispose();
    ref.notifyListeners();
  }

  changeDestination(Widget page) {
    // log.info('changeDestination: ${page.toString()}');
    int index = allPages.indexWhere(
      (element) =>
          element.runtimeType.toString() == page.runtimeType.toString(),
    );
    state.pageController.jumpToPage(index);
  }
}
