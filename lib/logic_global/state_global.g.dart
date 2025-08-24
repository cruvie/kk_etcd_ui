// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_global.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Global)
const globalProvider = GlobalProvider._();

final class GlobalProvider extends $NotifierProvider<Global, StateGlobal> {
  const GlobalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalHash();

  @$internal
  @override
  Global create() => Global();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StateGlobal value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StateGlobal>(value),
    );
  }
}

String _$globalHash() => r'f40855cf703df16f5056413e8cfa458847103939';

abstract class _$Global extends $Notifier<StateGlobal> {
  StateGlobal build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<StateGlobal, StateGlobal>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StateGlobal, StateGlobal>,
              StateGlobal,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
