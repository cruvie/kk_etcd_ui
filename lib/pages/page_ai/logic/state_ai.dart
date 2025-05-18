import 'package:kk_etcd_go/kk_etcd_api_hub/ai/api_def/Query.pb.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/api_ai.dart';
import 'package:kk_etcd_ui/utils/request/request.dart';
import 'package:kk_go_kit/kk_http/base_request.dart';
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
    Query_Output output = Query_Output();
    await kkBaseRequest(
      ApiAi.query,
      Query_Input(question: question),
      output,
      HttpTool.postReq,
    );
    state.answer = output.answer;
    state.loading = false;
    ref.notifyListeners();
  }
}
