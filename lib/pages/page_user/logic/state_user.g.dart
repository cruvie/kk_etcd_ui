// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(User)
const userProvider = UserProvider._();

final class UserProvider extends $NotifierProvider<User, StateUser> {
  const UserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userHash();

  @$internal
  @override
  User create() => User();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StateUser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StateUser>(value),
    );
  }
}

String _$userHash() => r'06bd13ff9b2d05753bdbbe3646253f5f5bb940e7';

abstract class _$User extends $Notifier<StateUser> {
  StateUser build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<StateUser, StateUser>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StateUser, StateUser>,
              StateUser,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
