///
//  Generated code. Do not modify.
//  source: pb_role.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class PBRole extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PBRole', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Name', protoName: 'Name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Key', protoName: 'Key')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'RangeEnd', protoName: 'RangeEnd')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PermissionType', $pb.PbFieldType.O3, protoName: 'PermissionType')
    ..hasRequiredFields = false
  ;

  PBRole._() : super();
  factory PBRole({
    $core.String? name,
    $core.String? key,
    $core.String? rangeEnd,
    $core.int? permissionType,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (key != null) {
      _result.key = key;
    }
    if (rangeEnd != null) {
      _result.rangeEnd = rangeEnd;
    }
    if (permissionType != null) {
      _result.permissionType = permissionType;
    }
    return _result;
  }
  factory PBRole.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PBRole.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PBRole clone() => PBRole()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PBRole copyWith(void Function(PBRole) updates) => super.copyWith((message) => updates(message as PBRole)) as PBRole; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PBRole create() => PBRole._();
  PBRole createEmptyInstance() => create();
  static $pb.PbList<PBRole> createRepeated() => $pb.PbList<PBRole>();
  @$core.pragma('dart2js:noInline')
  static PBRole getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PBRole>(create);
  static PBRole? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get key => $_getSZ(1);
  @$pb.TagNumber(2)
  set key($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get rangeEnd => $_getSZ(2);
  @$pb.TagNumber(3)
  set rangeEnd($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRangeEnd() => $_has(2);
  @$pb.TagNumber(3)
  void clearRangeEnd() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get permissionType => $_getIZ(3);
  @$pb.TagNumber(4)
  set permissionType($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPermissionType() => $_has(3);
  @$pb.TagNumber(4)
  void clearPermissionType() => clearField(4);
}

class PBListRole extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PBListRole', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..pc<PBRole>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'List', $pb.PbFieldType.PM, protoName: 'List', subBuilder: PBRole.create)
    ..hasRequiredFields = false
  ;

  PBListRole._() : super();
  factory PBListRole({
    $core.Iterable<PBRole>? list,
  }) {
    final _result = create();
    if (list != null) {
      _result.list.addAll(list);
    }
    return _result;
  }
  factory PBListRole.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PBListRole.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PBListRole clone() => PBListRole()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PBListRole copyWith(void Function(PBListRole) updates) => super.copyWith((message) => updates(message as PBListRole)) as PBListRole; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PBListRole create() => PBListRole._();
  PBListRole createEmptyInstance() => create();
  static $pb.PbList<PBListRole> createRepeated() => $pb.PbList<PBListRole>();
  @$core.pragma('dart2js:noInline')
  static PBListRole getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PBListRole>(create);
  static PBListRole? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PBRole> get list => $_getList(0);
}

