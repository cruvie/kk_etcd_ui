import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kk_etcd_ui/logic_global/state_global.dart';
import 'package:kk_etcd_ui/main.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/tools/local_storage.dart';
import 'package:kk_etcd_ui/utils/tools/tool_navigator.dart';
import 'package:kk_go_kit/kk_models/pb_response.pb.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';
import 'package:protobuf/protobuf.dart';

class HttpTool {
  static PBResponse defaultApiResp = PBResponse(
    code: Int64(400),
    msg: 'default resp',
  );

  static Future<Map<String, String>> getHeader() async {
    return {
      'Accept': 'application/x-protobuf',
      'Content-Type': 'application/x-protobuf',
      "UserName":
      globalProviderContainer
          .read(globalProvider.notifier)
          .getCurrentUser()
          .userName,
      "Password":
      globalProviderContainer
          .read(globalProvider.notifier)
          .getCurrentUser()
          .password,
      LSAuthorizationToken.authorizationToken:
      await LSAuthorizationToken.get() ?? '',
    };
  }

  //for download file
  // static Future<_Output> httpGet(String url,
  //     {String path = '',
  //     Map<String, dynamic>? query_Inputeters,
  //     String? currentPage,
  //     String? pageSize}) async {
  //   await requestConfig(currentPage: currentPage, pageSize: pageSize);
  //   // log.info(query_Inputeters.toString());
  //   //编码
  //   Map<String, dynamic> params = {
  //     'data': base64Encode(utf8.encode(jsonEncode(query_Inputeters)))
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

  static Future<PBResponse> postReq(String path,
      GeneratedMessage requestData,) async {
    if (!await LSAuthorizationToken.exists()) {
      ToolNavigator.toPageLogin();
    }

    Map<String, String> header = await getHeader();

    //这里也可以带参数，不过是在url？后面
    Uri uri = Uri.http(await LSServiceAddr.get(), path);
    // log.info(url.toString());
    Response response = Response('', 400);
    try {
      response = await post(
        uri,
        headers: header,
        body: requestData.writeToBuffer(),
      );
    } catch (e) {
      KKSnackBar.error(
        getGlobalCtx(),
        Text('post error\n$path\n$e'),
        action: SnackBarAction(
          label: 'Feedback',
          onPressed: () {}, //todo
        ),
      );
      return defaultApiResp;
    }
    return responseInterceptor(path, response);
  }

  ///响应拦截
  static Future<PBResponse> responseInterceptor(String targetUrl,
      Response response,) async {
    // log.info("响应拦截:${response.statusCode}");
    // log.info("响应拦截:${PBResponse.fromBuffer(response.bodyBytes)}");
    PBResponse apiResp = defaultApiResp.deepCopy();
    if (response.statusCode == 200) {
      // 解析response
      apiResp = PBResponse.fromBuffer(response.bodyBytes);
      if (apiResp.code != 200) {
        KKSnackBar.error(
          getGlobalCtx(),
          Text('${apiResp.msg}\n$targetUrl'),
          action: SnackBarAction(
            label: 'Feedback',
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
          label: 'Feedback',
          onPressed: () {}, //todo
        ),
      );
    }
    return apiResp;
  }
}
