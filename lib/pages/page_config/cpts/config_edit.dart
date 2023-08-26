import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_ui/kk_widget/kk_card.dart';

class ConfigEdit extends StatefulWidget {
  const ConfigEdit({super.key});

  @override
  State<ConfigEdit> createState() => _ConfigEditState();
}

class _ConfigEditState extends State<ConfigEdit> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      _valueController.text = LogicEtcd.to.currentConfig.value.value;
      return Form(
        key: _formKey,
        child: ListView(
          children: [
            KKCard(
                padding: const EdgeInsets.all(20),
                child: Text(LogicEtcd.to.currentConfig.value.key)),
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
                  LogicEtcd.to.currentConfig.value.value = value;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await LogicEtcd.to.kVPutConfig(
                        context,
                        LogicEtcd.to.currentConfig.value.key,
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
