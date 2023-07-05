import 'package:flutter/material.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_ui/kk_widget/kk_card.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

PackageInfo packageInfo = PackageInfo(
  appName: '',
  packageName: '',
  version: '',
  buildNumber: '',
);

Future<void> _initData() async {
  packageInfo = await PackageInfo.fromPlatform();
}

aboutInfo(BuildContext context) {
  _initData();
  showModalBottomSheet(
    showDragHandle: true,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.only(bottom: 10),
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView(
          children: [
            Center(
              child: KKCard(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('App Name: ${packageInfo.appName}'),
                    Text('Version : ${packageInfo.version}'),
                    const Text('License : MIT'),
                    TextButton(
                      onPressed: () {
                        launchUrl(
                          Uri.parse("https://github.com/gkdgo/kk_etcd_ui"),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: const Text('Homepage'),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: KKCard(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(lTr(context).donate, style: const TextStyle(fontSize: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(lTr(context).alipay),
                            Image.asset(
                              'lib/assets/pay/alipay.png',
                              width: 200,
                              height: 200,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(lTr(context).wechatPay),
                            Image.asset(
                              'lib/assets/pay/wechat.png',
                              width: 200,
                              height: 200,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
