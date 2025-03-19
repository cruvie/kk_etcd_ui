
import 'package:kk_etcd_go/kk_etcd_api_hub/ai/query/api.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/ai/query/api.pb.dart';
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
    Query_Output resp = Query_Output();
    await apiQuery(Query_Input(question: question), resp, HttpTool.postReq,
        okFunc: () {
      state.answer = resp.answer;
    });
    state.loading = false;
    ref.notifyListeners();
  }
}
