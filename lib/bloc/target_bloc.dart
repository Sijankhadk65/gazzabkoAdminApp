import 'dart:async';

import 'package:gazzabko_admin_app/data/repository.dart';
import 'package:gazzabko_admin_app/model/target.dart';
import 'package:rxdart/rxdart.dart';

class TargetBloc {
  final _repo = Repository();
  List<String> areasList = [];

  final _targetsSubject = BehaviorSubject<List<Target>>();
  Function(List<Target>) get changeTargets => _targetsSubject.sink.add;
  Stream<List<Target>> get targets => _targetsSubject.stream;

  final _selectedAreaSubject = BehaviorSubject<String>();
  Function(String) get changeArea => _selectedAreaSubject.sink.add;
  Stream<String> get area => _selectedAreaSubject.stream;

  final _targetValueSubject = BehaviorSubject<String>();
  Function(String) get changeTargetValue => _targetValueSubject.sink.add;
  Stream<String> get targetValue => _targetValueSubject.stream.transform(
          StreamTransformer.fromHandlers(handleData: (String target, sink) {
        if (target != "") {
          sink.add(target);
        } else {
          sink.addError("Empty!");
        }
      }));

  TargetBloc() {
    getTargets();
    getAreas();
  }

  getTargets() {
    _repo.getTargets().listen((targets) {
      changeTargets(targets);
    });
  }

  getAreas() {
    _repo.getAreas().listen((areas) {
      areasList = areas;
      changeArea(areasList.first);
    });
  }

  Future<void> saveTarget() {
    Map<String, dynamic> target = {
      "area": _selectedAreaSubject.value,
      "month": DateTime.parse(DateTime.now().toIso8601String()).month,
      "year": DateTime.parse(DateTime.now().toIso8601String()).year,
      "target": int.parse(_targetValueSubject.value),
      "createdAt": DateTime.now().toIso8601String(),
    };
    return _repo.saveTargets(parseJsonToTarget(target));
  }

  Future<void> updateTarget(month, year, createdAt) {
    Map<String, dynamic> target = {
      "area": _selectedAreaSubject.value,
      "month": month,
      "year": year,
      "target": int.parse(_targetValueSubject.value),
      "createdAt": createdAt,
    };
    return _repo.updateTargets(target);
  }

  Future<void> deleteTarget(String createdAt) => _repo.deleteTargets(createdAt);

  getMonth() => DateTime.parse(DateTime.now().toIso8601String()).month;
  getYear() => DateTime.parse(DateTime.now().toIso8601String()).year;
  dispose() {
    _targetsSubject.close();
    _selectedAreaSubject.close();
    _targetValueSubject.close();
  }
}
