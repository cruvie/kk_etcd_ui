///
//  Generated code. Do not modify.
//  source: pb_role.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use pBRoleDescriptor instead')
const PBRole$json = const {
  '1': 'PBRole',
  '2': const [
    const {'1': 'Name', '3': 1, '4': 1, '5': 9, '10': 'Name'},
    const {'1': 'Key', '3': 2, '4': 1, '5': 9, '10': 'Key'},
    const {'1': 'RangeEnd', '3': 3, '4': 1, '5': 9, '10': 'RangeEnd'},
    const {'1': 'PermissionType', '3': 4, '4': 1, '5': 5, '10': 'PermissionType'},
  ],
};

/// Descriptor for `PBRole`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pBRoleDescriptor = $convert.base64Decode('CgZQQlJvbGUSEgoETmFtZRgBIAEoCVIETmFtZRIQCgNLZXkYAiABKAlSA0tleRIaCghSYW5nZUVuZBgDIAEoCVIIUmFuZ2VFbmQSJgoOUGVybWlzc2lvblR5cGUYBCABKAVSDlBlcm1pc3Npb25UeXBl');
@$core.Deprecated('Use pBListRoleDescriptor instead')
const PBListRole$json = const {
  '1': 'PBListRole',
  '2': const [
    const {'1': 'List', '3': 1, '4': 3, '5': 11, '6': '.models.PBRole', '10': 'List'},
  ],
};

/// Descriptor for `PBListRole`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pBListRoleDescriptor = $convert.base64Decode('CgpQQkxpc3RSb2xlEiIKBExpc3QYASADKAsyDi5tb2RlbHMuUEJSb2xlUgRMaXN0');
