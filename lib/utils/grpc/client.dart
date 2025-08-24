import 'package:grpc/grpc.dart';
import 'package:kk_etcd_go/internal/service_hub/backup/api_def/service.pbgrpc.dart';
import 'package:kk_etcd_go/internal/service_hub/kv/api_def/service.pbgrpc.dart';
import 'package:kk_etcd_go/internal/service_hub/role/api_def/service.pbgrpc.dart';
import 'package:kk_etcd_go/internal/service_hub/service/api_def/service.pbgrpc.dart';
import 'package:kk_etcd_go/internal/service_hub/user/api_def/service.pbgrpc.dart';
import 'package:kk_etcd_ui/pages/page_kv/logic/state_kv.dart';
import 'package:kk_etcd_ui/utils/tools/local_storage.dart';

import 'interceptor.dart';

final GrpcInterceptor _responseInterceptor = GrpcInterceptor();

final _options = CallOptions();

final _channel = ClientChannel(
  LSServiceAddr.getHost() as Object,
  port: LSServiceAddr.getPort() ?? 0,
  options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
);

final BackupClient backupClientStub = BackupClient(
  _channel,
  options: _options,
  interceptors: [_responseInterceptor],
);

final KVClient kvClientStub = KVClient(
  _channel,
  options: _options,
  interceptors: [_responseInterceptor],
);

final RoleClient roleClientStub = RoleClient(
  _channel,
  options: _options,
  interceptors: [_responseInterceptor],
);

final ServiceClient serviceClientStub = ServiceClient(
  _channel,
  options: _options,
  interceptors: [_responseInterceptor],
);

final UserClient userClientStub = UserClient(
  _channel,
  options: _options,
  interceptors: [_responseInterceptor],
);
