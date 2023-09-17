import 'package:flutter/material.dart';
import 'package:kk_etcd_go/key_prefix.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/page_logics/logic_etcd/logic_etcd.dart';
import 'package:kk_ui/kk_widget/kk_card.dart';

class PageAddConfig extends StatefulWidget {
  const PageAddConfig({super.key});

  @override
  State<PageAddConfig> createState() => _PageAddConfigState();
}

class _PageAddConfigState extends State<PageAddConfig> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            KKCard(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  icon: Text(lTr(context).name),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'name empty';
                  }
                  return null;
                },
              ),
            ),
            KKCard(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: _valueController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 10,
                decoration: InputDecoration(
                  icon: Text(lTr(context).value),
                ),
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
                    bool success = await LogicEtcd.to.kVPut(
                      context,
                      KeyPrefix.config + _nameController.text,
                      _valueController.text,
                    );
                    if (success) {
                      _nameController.clear();
                      _valueController.clear();
                    }
                  }
                },
                child: Text(lTr(context).buttonSave),
              ),
            )
          ],
        ),
      ),
    );
  }
}
