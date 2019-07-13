import 'package:xml/xml.dart' as xml;

class Customer {
  String name;
  String code;
  String address;
  // String avatar =
  //     'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&s=200';
  // String registerAddress;
  // String tradePartner;
  // String phone;
  // String publicRelationsType;
  // String taxNo;
  // String legalUserName;
  // String businessContacts;
  List<Customer> customers;

  Customer({this.name, this.code,this.address});

  Customer.fromJSON(Map data) {
    
    List<Customer> customers = [];
    List list=data['rows'];
    list.forEach((item) {
      Customer customer = Customer.get(item);
      customers.add(customer);
    });
    this.customers = customers;
  }

  Customer.xml2List(outputxmlstr) {
    List list = xml
        .parse(outputxmlstr)
        .findAllElements('response')
        .map((node) => node.findElements('success').single.text)
        .toList();
        
    if (list.length > 0) {
      if (list[0] == "true") {
        customers = xml
            .parse(outputxmlstr)
            .findAllElements('customer')
            .map((node) => new Customer(name:
                  node.findElements('title').single.text,code:
                  node.findElements('code').single.text,address: 
                  node.getAttribute("address")==null?node.findElements('code').single.text:''
                ))
            .toList();
      } else {
        customers = xml
            .parse(outputxmlstr)
            .findAllElements('response')
            .map((node) => new Customer(name:
                  'error',code:
                  'error',address:
                  node.findElements('error').single.text
                ))
            .toList();
      }
      // currentUser = loginUserList[0];
    }
  }

  Customer.get(Map data){
    this.code = data['code'];
    this.name = data['title'];
    // this.registerAddress = data['registerAddress'];
    // this.tradePartner= data['tradePartner'];
    // this.phone=data['phone'];
    // this.publicRelationsType=data['publicRelationsType'];
    // this.taxNo=data['tax_no'];
    // this.legalUserName=data['legalUserName'];
    // this.businessContacts=data['business_contacts'];
  }
}
