class Customer {
  String name;
  String code;
  String avatar =
      'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&s=200';
  String registerAddress;
  String tradePartner;
  String phone;
  String publicRelationsType;
  String taxNo;
  String legalUserName;
  String businessContacts;
  List<Customer> customers;

  Customer({this.name, this.code,this.avatar});

  Customer.fromJSON(Map data) {
    
    List<Customer> customers = [];
    List list=data['rows'];
    list.forEach((item) {
      Customer customer = Customer.get(item);
      customers.add(customer);
    });
    this.customers = customers;
    print(customers.length);
  }

  Customer.get(Map data){
    this.code = data['code'];
    this.name = data['title'];
    this.registerAddress = data['registerAddress'];
    this.tradePartner= data['tradePartner'];
    this.phone=data['phone'];
    this.publicRelationsType=data['publicRelationsType'];
    this.taxNo=data['tax_no'];
    this.legalUserName=data['legalUserName'];
    this.businessContacts=data['business_contacts'];
  }
}
