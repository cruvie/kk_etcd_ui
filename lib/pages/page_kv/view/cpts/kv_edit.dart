import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/kv/kVPut/api.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/pages/page_kv/logic/state_kv.dart';

import 'package:kk_ui/kk_widget/kk_card.dart';

class KVEdit extends ConsumerStatefulWidget {
  const KVEdit({super.key});

  @override
  ConsumerState<KVEdit> createState() => _KVEditState();
}

class _KVEditState extends ConsumerState<KVEdit> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var readKV = ref.read(kVProvider.notifier);
    var watchKV = ref.watch(kVProvider);
    _valueController.text = watchKV.currentKV.value;
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          KKCard(
              padding: const EdgeInsets.all(20),
              child: Text(watchKV.currentKV.key)),
          KKCard(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: _valueController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 10,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'value empty';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await readKV.kVPut(
                    KVPut_Input(
                      key: watchKV.currentKV.key,
                      value: _valueController.text,
                    ),
                  );
                }
              },
              child: Text(lTr(context).buttonSave),
            ),
          )
        ],
      ),
    );
  }
}
