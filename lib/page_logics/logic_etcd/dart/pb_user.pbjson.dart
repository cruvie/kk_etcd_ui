///
//  Generated code. Do not modify.
//  source: pb_user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use pBUserDescriptor instead')
const PBUser$json = const {
  '1': 'PBUser',
  '2': const [
    const {'1': 'UserName', '3': 2, '4': 1, '5': 9, '10': 'UserName'},
    const {'1': 'Password', '3': 3, '4': 1, '5': 9, '10': 'Password'},
    const {'1': 'Roles', '3': 4, '4': 3, '5': 9, '10': 'Roles'},
  ],
};

/// Descriptor for `PBUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pBUserDescriptor = $convert.base64Decode('CgZQQlVzZXISGgoIVXNlck5hbWUYAiABKAlSCFVzZXJOYW1lEhoKCFBhc3N3b3JkGAMgASgJUghQYXNzd29yZBIUCgVSb2xlcxgEIAMoCVIFUm9sZXM=');
@$core.Deprecated('Use pBListUserDescriptor instead')
const PBListUser$json = const {
  '1': 'PBListUser',
  '2': const [
    const {'1': 'ListUser', '3': 1, '4': 3, '5': 11, '6': '.models.PBUser', '10': 'ListUser'},
  ],
};

/// Descriptor for `PBListUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pBListUserDescriptor = $convert.base64Decode('CgpQQkxpc3RVc2VyEioKCExpc3RVc2VyGAEgAygLMg4ubW9kZWxzLlBCVXNlclIITGlzdFVzZXI=');
