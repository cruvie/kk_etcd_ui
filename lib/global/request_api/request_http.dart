import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kk_etcd_ui/global/utils/util_navigator.dart';
import 'package:kk_ui/kk_const/kkc_request_api.dart';
import 'package:kk_ui/kk_util/kku_sp.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';

import 'api.dart';
import 'api_resp/api_resp.pb.dart';

class RequestHttp {
  static late Map<String, String> header;
  static Response response = Response('', 400);
  static ApiResp apiResp = ApiResp(code: 400, msg: 'Error');

  static requestConfig({String? currentPage, String? pageSize}) async {
    header = {
      'Content-Type': 'application/protobuf',
      KKCRequestApi.authorizationToken:
          KKUSp.getLocalStorage(KKCRequestApi.authorizationToken) ?? '',
      KKCRequestApi.currentPage: currentPage ?? '',
      KKCRequestApi.pageSize: pageSize ?? '',
    };
    // debugPrint('header: $header');
  }

  static Future<ApiResp> httpPost(String path,
      {Uint8List? queryParameters,
      String? currentPage,
      String? pageSize}) async {
    await requestConfig(currentPage: currentPage, pageSize: pageSize);
    Uri uri = Uri.http(Api.getServerAddr(), path);
    // debugPrint(uri.toString());
    try {
      response = await post(uri, headers: header, body: queryParameters);
    } catch (e) {
      debugPrint("post error：$e");
    }
    return responseInterceptor(response);
  }

  static Future<ApiResp> responseInterceptor(Response response) async {
    // debugPrint("response:${ApiResp.fromBuffer(response.bodyBytes)}");
    if (response.statusCode == 200) {
      apiResp = ApiResp.fromBuffer(response.bodyBytes);
      if (apiResp.code == 401) {
        UtilNavigator.toPageLogin();
        KKSnackBar.ok(UtilNavigator.globalContext, Text(apiResp.msg));
      }
    } else {
      debugPrint('error response: ${response.body}');
    }
    return apiResp;
  }
}
