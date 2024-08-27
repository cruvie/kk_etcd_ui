import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_go/kk_etcd_models/api_kv_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/pages/page_kv/logic/state_kv.dart';

import 'package:kk_ui/kk_widget/kk_card.dart';

class PageAddKV extends ConsumerStatefulWidget {
  const PageAddKV({super.key});

  @override
  ConsumerState<PageAddKV> createState() => _PageAddKVState();
}

class _PageAddKVState extends ConsumerState<PageAddKV> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var readKV = ref.read(kVProvider.notifier);
    var watchKV = ref.watch(kVProvider);
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
                    bool success = await readKV.kVPut(
                      KVPutParam(
                        key: _nameController.text,
                        value: _valueController.text,
                      ),
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
