import 'package:kk_etcd_go/kk_etcd_apis/api_ai.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_ai_kk_etcd.pb.dart';

import 'package:kk_etcd_ui/utils/request/request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_ai.g.dart';

class StateAI {
  String answer = "";
  bool loading = false;
}

@riverpod
class AI extends _$AI {
  @override
  StateAI build() {
    return StateAI();
  }

  Future<void> query(String question) async {
    state.loading = true;
    ref.notifyListeners();
    QueryResponse resp = QueryResponse();
    await ApiAI.query(QueryParam(question: question), resp, HttpTool.postReq,
        okFunc: () {
      state.answer = resp.answer;
    });
    state.loading = false;
    ref.notifyListeners();
  }
}
