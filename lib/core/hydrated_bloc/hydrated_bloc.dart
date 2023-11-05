// import 'package:employee_management_fe_app/core/storage/storage_service.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';

// abstract class HydratedCubit<State> extends BlocBase<State>
//     with HydratedMixin<State> {
//   HydratedCubit(State initialState) : super(initialState) {
//     hydrate();
//   }
// }

// mixin HydratedMixin<State> on BlocBase<State> {
//   void hydrate() {
//     final storage = GetIt.I.get<AppStorageService>().appStorage;
//     try {
//       final stateJson = storage.get(storageToken) as Map<dynamic, dynamic>?;
//       _state = _fromJson(stateJson);
//       emit(state);
//     } catch (error, stackTrace) {
//       onError(error, stackTrace);
//     }
//   }

//   State? _state;

//   @override
//   State get state {
//     final storage = GetIt.I.get<AppStorageService>().appStorage;
//     if (_state != null) return _state!;
//     try {
//       final stateJson = storage.get(storageToken) as Map<dynamic, dynamic>?;

//       final cachedState = _fromJson(stateJson);
//       if (cachedState == null) {
//         _state = cachedState;
//         return _state!;
//       }
//       _state = cachedState;
//       return cachedState;
//     } catch (error, stackTrace) {
//       onError(error, stackTrace);
//       _state = super.state;
//       return super.state;
//     }
//   }

//   @override
//   void onChange(Change<State> change) {
//     super.onChange(change);
//     final storage = GetIt.I.get<AppStorageService>().appStorage;
//     final state = change.nextState;
//     try {
//       final stateJson = _toJson(state);
//       if (stateJson != null) {
//         storage.put(storageToken, stateJson);
//       }
//     } catch (error, stackTrace) {
//       onError(error, stackTrace);
//       rethrow;
//     }
//     _state = state;
//   }

//   State? _fromJson(dynamic json) {
//     final castJson = _cast<Map<String, dynamic>>(fromJson(json));
//     return fromJson(castJson ?? <String, dynamic>{});
//   }

//   Map<String, dynamic>? _toJson(State state) {
//     return _cast<Map<String, dynamic>>(toJson(state));
//   }

//   T? _cast<T>(dynamic x) => x is T ? x : null;

//   /// [id] is used to uniquely identify multiple instances
//   /// of the same [HydratedBloc] type.
//   /// In most cases it is not necessary;
//   /// however, if you wish to intentionally have multiple instances
//   /// of the same [HydratedBloc], then you must override [id]
//   /// and return a unique identifier for each [HydratedBloc] instance
//   /// in order to keep the caches independent of each other.
//   String get id => '';

//   /// Storage prefix which can be overridden to provide a custom
//   /// storage namespace.
//   /// Defaults to [runtimeType] but should be overridden in cases
//   /// where stored data should be resilient to obfuscation or persist
//   /// between debug/release builds.
//   String get storagePrefix => runtimeType.toString();

//   /// `storageToken` is used as registration token for hydrated storage.
//   /// Composed of [storagePrefix] and [id].
//   String get storageToken => '$storagePrefix$id';

//   /// [clear] is used to wipe or invalidate the cache of a [HydratedBloc].
//   /// Calling [clear] will delete the cached state of the bloc
//   /// but will not modify the current state of the bloc.
//   void clear() =>
//       GetIt.I.get<AppStorageService>().appStorage.delete(storageToken);

//   /// Responsible for converting the `Map<String, dynamic>` representation
//   /// of the bloc state into a concrete instance of the bloc state.
//   State? fromJson(Map<String, dynamic> json);

//   /// Responsible for converting a concrete instance of the bloc state
//   /// into the the `Map<String, dynamic>` representation.
//   ///
//   /// If [toJson] returns `null`, then no state changes will be persisted.
//   Map<String, dynamic>? toJson(State state);
// }
