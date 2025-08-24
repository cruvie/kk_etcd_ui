// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_kv.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(KV)
const kVProvider = KVProvider._();

final class KVProvider extends $NotifierProvider<KV, StateKV> {
  const KVProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kVProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kVHash();

  @$internal
  @override
  KV create() => KV();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StateKV value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StateKV>(value),
    );
  }
}

String _$kVHash() => r'a10da47d11a871a1623f8d6c4624f7cc323388e9';

abstract class _$KV extends $Notifier<StateKV> {
  StateKV build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<StateKV, StateKV>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StateKV, StateKV>,
              StateKV,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
