class Customer {
  String name;
  String code;
  String avatar =
      'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&s=200';
  String register_address;
  String trade_partner;
  String phone;
  String public_relations_type;
  String tax_no;
  String legal_user_name;
  String business_contacts;
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
    this.register_address = data['register_address'];
    this.trade_partner= data['trade_partner'];
    this.phone=data['phone'];
    this.public_relations_type=data['public_relations_type'];
    this.tax_no=data['tax_no'];
    this.legal_user_name=data['legal_user_name'];
    this.business_contacts=data['business_contacts'];
  }
}
