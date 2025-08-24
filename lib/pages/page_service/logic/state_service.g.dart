// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Service)
const serviceProvider = ServiceProvider._();

final class ServiceProvider extends $NotifierProvider<Service, StateService> {
  const ServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceHash();

  @$internal
  @override
  Service create() => Service();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StateService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StateService>(value),
    );
  }
}

String _$serviceHash() => r'a92af93b811a9b94f62d94e0e751b37803df5165';

abstract class _$Service extends $Notifier<StateService> {
  StateService build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<StateService, StateService>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StateService, StateService>,
              StateService,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
