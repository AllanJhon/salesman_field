class Contract {
  String name;
  String code;
  List<Contract> contracts;

  Contract({this.name, this.code});

  Contract.fromJSON(Map data) {
    
    List<Contract> customers = [];
    List list=data['rows'];
    list.forEach((item) {
      Contract contract = Contract.get(item);
      contracts.add(contract);
    });
    this.contracts = customers;
  }

  Contract.get(Map data){
    this.code = data['code'];
    this.name = data['title'];
  }

  void init(){
    Contract contract=new Contract(name:'盾石信息',code:'TTX');
    contracts.add(contract);
    Contract contract1=new Contract(name:'冀东水泥',code:'JIDD');
    contracts.add(contract1);
  }
}
