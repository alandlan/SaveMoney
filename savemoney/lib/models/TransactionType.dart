class TransactionType{
  final int id;
  final String name;
  final int credit;

  TransactionType(this.id,this.name,this.credit); 

  @override
  String toString(){
    return 'TransactionType{id: $id, name: $name, credit: $credit}';
  }
}