import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kk_etcd_ui/logic_global/global_tool.dart';
import 'package:kk_etcd_ui/logic_global/state_global.dart';
import 'package:kk_etcd_ui/main.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/tools/local_storage.dart';
import 'package:kk_etcd_ui/utils/tools/tool_navigator.dart';
import 'package:kk_go_kit/kk_models/pb_response.pb.dart';
import 'package:kk_etcd_ui/utils/tools/local_storage.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';
import 'package:protobuf/protobuf.dart';

class HttpTool {
  static late Map<String, String> header;
  static PBResponse defaultApiResp =
      PBResponse(code: Int64(400), msg: 'default resp error');

  static requestConfig({String? currentPage, String? pageSize}) {
    if (!LSAuthorizationToken.exists()) {
      ToolNavigator.toPageLogin();
    }

    ///请求头配置
    header = {
      'Content-Type': 'application/protobuf',
      "UserName": globalProviderContainer
          .read(globalProvider.notifier)
          .getCurrentUser()
          .userName,
      "Password": globalProviderContainer
          .read(globalProvider.notifier)
          .getCurrentUser()
          .password,
      LSAuthorizationToken.authorizationToken:
          LSAuthorizationToken.get() ?? '',
    };
  }

  //for download file
  // static Future<Response> httpGet(String url,
  //     {String path = '',
  //     Map<String, dynamic>? queryParameters,
  //     String? currentPage,
  //     String? pageSize}) async {
  //   await requestConfig(currentPage: currentPage, pageSize: pageSize);
  //   // log.info(queryParameters.toString());
  //   //编码
  //   Map<String, dynamic> params = {
  //     'data': base64Encode(utf8.encode(jsonEncode(queryParameters)))
  //   };
  //   Uri uri = Uri.http(url, path, params);
  //   // log.info(url.toString());
  //   // log.info('请求header$header');
  //   try {
  //     response = await get(uri, headers: header);
  //   } catch (e) {
  //     log.info("get请求发送异常：$e");
  //   }
  //   return response;
  // }

  static Future<PBResponse> postReq(
      String path, GeneratedMessage requestData) async {
    requestConfig();

    //这里也可以带参数，不过是在url？后面
    Uri uri = Uri.http(GlobalTool.getServerAddr(), path);
    // log.info(url.toString());
    Response response = Response('', 400);
    try {
      response = await post(uri, headers: header, body: requestData);
    } catch (e) {
      KKSnackBar.error(
        getGlobalCtx(),
        Text('post error\n$path\n$e'),
        action: SnackBarAction(
          label: '一键反馈',
          onPressed: () {}, //todo
        ),
      );
    }
    return responseInterceptor(path, response);
  }

  ///响应拦截
  static Future<PBResponse> responseInterceptor(
      String targetUrl, Response response) async {
    // log.info("响应拦截:${response.statusCode}");
    // log.info("响应拦截:${PBResponse.fromBuffer(response.bodyBytes)}");
    PBResponse apiResp = PBResponse.fromBuffer(defaultApiResp.writeToBuffer());
    if (response.statusCode == 200) {
      // 解析response
      apiResp = PBResponse.fromBuffer(response.bodyBytes);
      if (apiResp.code != 200) {
        KKSnackBar.error(
          getGlobalCtx(),
          Text('${apiResp.msg}\n$targetUrl'),
          action: SnackBarAction(
            label: '一键反馈',
            onPressed: () {}, //todo
          ),
        );
      }
      if (apiResp.code == 401) {
        ToolNavigator.toPageLogin();
      }
    } else {
      KKSnackBar.error(
        getGlobalCtx(),
        Text('resp error\n$targetUrl\n${response.body}'),
        action: SnackBarAction(
          label: '一键反馈',
          onPressed: () {}, //todo
        ),
      );
    }
    return apiResp;
  }
}
