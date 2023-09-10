import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_ui/kk_widget/kk_card.dart';

class KVEdit extends StatefulWidget {
  const KVEdit({super.key});

  @override
  State<KVEdit> createState() => _KVEditState();
}

class _KVEditState extends State<KVEdit> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      _valueController.text = LogicEtcd.to.currentKV.value.value;
      return Form(
        key: _formKey,
        child: ListView(
          children: [
            KKCard(
                padding: const EdgeInsets.all(20),
                child: Text(LogicEtcd.to.currentKV.value.key)),
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
                onChanged: (String value) {
                  LogicEtcd.to.currentKV.value.value = value;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await LogicEtcd.to.kVPut(
                        context,
                        LogicEtcd.to.currentKV.value.key,
                        _valueController.text);
                  }
                },
                child: Text(lTr(context).buttonSave),
              ),
            )
          ],
        ),
      );
    });
  }
}
