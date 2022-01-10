
class Account{
  final int id;
  final String name;
  double balance;

  Account(this.id,this.name,this.balance);

  @override
  String toString(){
    return 'Account {Id: $id, name: $name, balance: $balance';
  }
}