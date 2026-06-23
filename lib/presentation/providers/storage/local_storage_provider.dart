import 'package:moviedb/infrastructure/datasources/drift_datasource.dart';
import 'package:moviedb/infrastructure/repositories/local_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(DriftDatasource());
});
