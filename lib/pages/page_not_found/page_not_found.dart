import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_ui/kk_widget/kk_back_button.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lTr(context).pageError),
        leading: const KKBackButton(),
      ),
      body: Center(
        child: Text(lTr(context).pageError),
      ),
    );
  }
}
