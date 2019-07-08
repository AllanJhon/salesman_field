class Company {
  String name;
  String code;
  List<Company> companes;

  Company({this.name, this.code});

  Company.fromJSON(Map data) {
    
    List<Company> customers = [];
    List list=data['rows'];
    list.forEach((item) {
      Company customer = Company.get(item);
      customers.add(customer);
    });
    this.companes = customers;
    print(customers.length);
  }

  Company.get(Map data){
    this.code = data['code'];
    this.name = data['title'];
  }

  void init(){
    Company company=new Company(name:'盾石信息',code:'TTX');
    companes.add(company);
    Company company1=new Company(name:'冀东水泥',code:'JIDD');
    companes.add(company1);
  }
}
