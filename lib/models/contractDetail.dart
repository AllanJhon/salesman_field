class ContractDetail{
    String cementType;//水泥品种
    String count;//数量
    String deliveryEnterprise;//发货企业
    String groups ;//客户组
    String saleRegion;//销往地区
    String loanRate;//贷款价格
    String freightPrice;//运费价格
    List<ContractDetail> contractDetails;

    ContractDetail({this.cementType,this.count,this.deliveryEnterprise,this.
    groups,this.saleRegion,this.freightPrice,this.loanRate});

    ContractDetail.fromJSON(Map data) { 
      List<ContractDetail> customers = [];
      List list=data['rows'];
      list.forEach((item) {
        ContractDetail customer = ContractDetail.get(item);
        customers.add(customer);
      });
      this.contractDetails = customers;
    }

    ContractDetail.get(Map data):
     cementType=data['cementType'],
     count=data['count'],
     deliveryEnterprise=data['deliveryEnterprise'],
     groups=data['groups'],
     saleRegion=data['saleRegion'],
     loanRate=data['loanRate'],
     freightPrice=data['freightPrice'];

}