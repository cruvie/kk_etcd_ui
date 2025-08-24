// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_role.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Role)
const roleProvider = RoleProvider._();

final class RoleProvider extends $NotifierProvider<Role, StateRole> {
  const RoleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'roleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$roleHash();

  @$internal
  @override
  Role create() => Role();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StateRole value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StateRole>(value),
    );
  }
}

String _$roleHash() => r'7f3ac693a243a4c2d6373edf8fc034e1dbb84afa';

abstract class _$Role extends $Notifier<StateRole> {
  StateRole build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<StateRole, StateRole>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StateRole, StateRole>,
              StateRole,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
