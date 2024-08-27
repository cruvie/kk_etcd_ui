import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_user_kk_etcd.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_user_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/pages/page_user/logic/state_user.dart';
import 'package:kk_etcd_ui/utils/const/static_etcd.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';

part 'state_global.g.dart';

class StateGlobal {
  PBUser currentUser = PBUser();

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
    loadLocalData();
  }

  loadLocalData() {
    String? userJson = KKUSp.get(StaticEtcd.myInfo);
    if (userJson != null) {
      state.currentUser = PBUser.fromJson(userJson);
    }
    ref.notifyListeners();
  }

  updateCurrentUser(PBUser info) async {
    state.currentUser = info;
    await KKUSp.set(StaticEtcd.myInfo, state.currentUser.writeToJson());
    ref.notifyListeners();
  }

  PBUser getCurrentUser() {
    return state.currentUser;
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
    int index = allPages.indexWhere((element) =>
        element.runtimeType.toString() == page.runtimeType.toString());
    state.pageController.jumpToPage(index);
  }
}
