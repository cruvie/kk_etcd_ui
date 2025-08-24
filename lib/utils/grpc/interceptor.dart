import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart';
import 'package:kk_etcd_ui/logic_global/global_tool.dart';
import 'package:kk_etcd_ui/page_routes/router_util.dart';
import 'package:kk_etcd_ui/utils/tools/tool_navigator.dart';
import 'package:kk_ui/kk_util/kk_id.dart';
import 'package:kk_ui/kk_util/kk_log.dart';
import 'package:kk_ui/kk_widget/kk_id.dart';
import 'package:kk_ui/kk_widget/kk_snack_bar.dart';

// 复杂用法 https://github.com/grpc/grpc-dart/pull/489#issuecomment-1117204933
// https://github.com/grpc/grpc-dart/issues/544#issuecomment-2105540826
class GrpcInterceptor extends ClientInterceptor {
  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    // 在发送请求前添加token到metadata
    CallOptions updatedOptions = _addTokenToOptions(options);
    ResponseFuture<R> responseFuture = invoker(method, request, updatedOptions);
    responseFuture.then(
      (response) {
        // log.info('Response: ${response.runtimeType}');
      },
      onError: (Object error) {
        // 处理错误响应
        log.info('Unary error: $error');
        if (error is GrpcError) {
          KKSnackBar.error(
            getGlobalCtx(),
            Text('${error.codeName} ${error.message}'),
          );
          log.info(
            'gRPC Error Code: ${error.codeName}, Message: ${error.message}',
          );
          if (error.code == StatusCode.unauthenticated) {
            // 清空本地缓存
            // log.info("清空缓存");
            // GlobalTool.resetAllInfo();
            // log.info("清空缓存成功");
            // 跳转登录页，当前中在登录/注册页则忽略
            ToolNavigator.toPageLogin();
          }
        }
        throw error;
      },
    );
    return responseFuture;
  }

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    // 在发送请求前添加token到metadata
    CallOptions updatedOptions = _addTokenToOptions(options);
    ResponseStream<R> responseStream = invoker(
      method,
      requests,
      updatedOptions,
    );
    responseStream.handleError((error) {
      // 处理错误响应
      log.info('Unary error: $error');
      if (error is GrpcError) {
        KKSnackBar.error(
          getGlobalCtx(),
          Text('${error.codeName} ${error.message}'),
        );
        log.info(
          'gRPC Error Code: ${error.codeName}, Message: ${error.message}',
        );
        if (error.code == StatusCode.unauthenticated) {
          KKSnackBar.error(getGlobalCtx(), Text('请重新登陆${error.message}'));
          // 清空本地缓存
          // log.info("清空缓存");
          // GlobalTool.resetAllInfo();
          // log.info("清空缓存成功");
          // 跳转登录页，当前中在登录/注册页则忽略
          ToolNavigator.toPageLogin();
        }
      }
      throw error;
    });
    return responseStream;
  }

  /// 添加token到CallOptions
  CallOptions _addTokenToOptions(CallOptions options) {
    // 尝试获取存储的token（注意：这是异步操作，但在实际应用中我们可能需要采用其他策略）
    // String? token = LSAuthorizationToken.get();
    //
    // if (token != null) {
    //   options = options.mergedWith(
    //     CallOptions(metadata: {LSAuthorizationToken.key: token}),
    //   );
    // }

    options = options.mergedWith(
      CallOptions(metadata: {"TraceId": KKUuid().genUUID7()}),
    );
    return options;
  }
}
