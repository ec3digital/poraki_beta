

class ShoppingCartModel{

  final String name;
  final String picture;
  final double value;
  final String id;
  late int qty;
  final String categChave;
  final String? sellerId;
  final String? storeId;
  late double totalValue;

  ShoppingCartModel(this.name, this.picture, this.value, this.id, this.qty, this.categChave, this.sellerId, this.storeId, this.totalValue);


}