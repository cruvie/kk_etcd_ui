// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_backup.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Backup)
const backupProvider = BackupProvider._();

final class BackupProvider extends $NotifierProvider<Backup, StateBackup> {
  const BackupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupHash();

  @$internal
  @override
  Backup create() => Backup();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StateBackup value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StateBackup>(value),
    );
  }
}

String _$backupHash() => r'f9b0f7ecb3e85833b0e97a72843f34180ed19299';

abstract class _$Backup extends $Notifier<StateBackup> {
  StateBackup build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<StateBackup, StateBackup>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StateBackup, StateBackup>,
              StateBackup,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
