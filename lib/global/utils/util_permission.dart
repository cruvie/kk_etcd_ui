import 'package:flutter/cupertino.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';

class UtilPermission {
  static const int read = 0;
  static const int write = 1;
  static const int readWrite = 2;

  static String getPermissionType(BuildContext context, int permissionType) {
    switch (permissionType) {
      case read:
        return lTr(context).read;
      case write:
        return lTr(context).write;
      case readWrite:
        return lTr(context).readWrite;
      default:
        return "invalid permission type!";
    }
  }
}
