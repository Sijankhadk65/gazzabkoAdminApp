import 'package:gazzabko_admin_app/model/sales.dart';
import 'package:rxdart/rxdart.dart';

import '../data/repository.dart';

class SalesBloc {
  final _repo = Repository();
  List<Sales> salesData = [];
  String _name = "";

  final _salesSubject = BehaviorSubject<List<Sales>>();
  Function(List<Sales>) get changeSales => _salesSubject.sink.add;
  Stream<List<Sales>> get sales => _salesSubject.stream;

  final _salesQuerySubject = BehaviorSubject<String>();
  Function(String) get changeSalesQuery => _salesQuerySubject.sink.add;
  Stream<String> get salesQuery => _salesQuerySubject.stream;

  SalesBloc() {
    changeSalesQuery("");

    salesQuery.listen((query) {
      if (query.isNotEmpty) {
        _repo.getSales(_name).listen((sales) {
          salesData = sales;
          changeSales(sales
              .where((sale) => sale.to.name.toLowerCase().contains(query))
              .toList());
        });
      } else {
        _repo.getSales(_name).listen((sales) {
          salesData = sales;
          changeSales(salesData);
        });
      }
    });
  }

  setName(String name) => _name = name;

  Future<void> deleteSalesData(String deliveryDate) =>
      _repo.deleteSalesData(deliveryDate);

  void dispose() {
    _salesSubject.close();
    _salesQuerySubject.close();
  }
}
