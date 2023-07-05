import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/global/utils/util_navigator.dart';
import 'package:kk_etcd_ui/pages/page_content/page_content.dart';
import 'package:kk_etcd_ui/pages/page_index/page_login.dart';
import 'package:kk_ui/kk_const/kkc_request_api.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {

  @override
  Widget build(BuildContext context) {
    UtilNavigator.globalContext = context;
    // debugPrint(KKUSp.getLocalStorage(KKCRequestApi.authorizationToken));
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: (KKUSp.getLocalStorage(KKCRequestApi.authorizationToken) ==
                    null)
                ? const PageLogin()
                : const PageContent(),
          ),
        ],
      ),
    );
  }
}
