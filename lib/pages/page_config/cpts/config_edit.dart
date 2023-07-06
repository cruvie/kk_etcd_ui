import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_ui/kk_widget/kk_card.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';

class ConfigEdit extends StatefulWidget {
  const ConfigEdit({super.key});

  @override
  State<ConfigEdit> createState() => _ConfigEditState();
}

class _ConfigEditState extends State<ConfigEdit> {
  String cfgKey = '';

  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    cfgKey = logicEtcdWatch(context).currentConfig.key;
    _textController.text = logicEtcdWatch(context).currentConfig.value;
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          KKCard(padding: const EdgeInsets.all(20), child: Text(cfgKey)),
          KKCard(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: _textController,
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
                  bool success = await logicEtcdRead(context)
                      .kVPutConfig(cfgKey, _textController.text);
                  if (success && context.mounted) {
                    KKSnackBar.ok(context, const Text("update succeed"));
                  } else {
                    KKSnackBar.error(context, const Text("update failed"));
                  }
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
