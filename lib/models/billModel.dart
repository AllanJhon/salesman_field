import 'package:xml/xml.dart' as xml;

Map billMap = {
  'zvbeln': '销售凭证号',
  'zerdat': '创建日期',
  'zvdatu': '交货日期',
  'zkunnr': '售达方',
  'zname1': '客户名称',
  'zskwmeng': '剩余数量',
  'zflag': '交货状态',
  'zmatnr': '品种',
  'zdj': '单价',
  'zdkwmeng': '订单数量',
  'zjkwmeng': '交货数量',
  'zyfdj': '运费单价',
  'zzname1': '运输单位',
  'zvkgrp': '销售组',
  'zvkgrpms': '销售组描述',
  'zvkbur': '销售部门',
  'zvkburms': '销售组描述',
  'zthgc': '提货工厂描述',
  'zxwdq': '销往地区描述',
  'zzdyh': '终端用户',
  'zfxqd': '分销渠道',
  'zbstkd': 'EMES订单号',
  'zarktx':'品种描述',
  'zwerksms':'提货厂家',
  'zvtwegms':'卸货地'
};

class BillModel {
  String zvbeln; //销售和分销凭证号
  String zerdat; //记录的创建日期
  String zvdatu; //请求交货日期
  String zkunnr; //售达方
  String zname1; //客户名称
  String zskwmeng; //剩余数量
  String zflag; //交货状态
  String zmatnr; //物料编号
  String zdj; // 单价
  String zdkwmeng; //订单数量
  String zjkwmeng; //交货数量
  String zyfdj; //运费单价
  String zzname1; //运输单位
  String zvkgrp; //销售组
  String zvkgrpms; //销售组描述
  String zvkbur; //销售部门
  String zvkburms; //销售部门描述
  String zthgc; //提货工厂描述
  String zxwdq; //销往地区描述
  String zzdyh; //终端用户
  String zfxqd; //分销渠道
  String zbstkd; //EMES订单号
  String zarktx; //品种描述
  String zwerksms; //提货厂家
  String zvtwegms; //卸货地
  List billModelList;
  // BillClass({this.ZORDER,this.ZVBELN,this.ZERDAT,this.ZVDATU,this.ZKUNNR});
  BillModel(
      this.zvbeln,
      this.zerdat,
      this.zvdatu,
      this.zkunnr,
      this.zname1,
      this.zskwmeng,
      this.zflag,
      this.zmatnr,
      this.zdj,
      this.zdkwmeng,
      this.zjkwmeng,
      this.zyfdj,
      this.zzname1,
      this.zvkgrp,
      this.zvkgrpms,
      this.zvkbur,
      this.zvkburms,
      this.zthgc,
      this.zxwdq,
      this.zzdyh,
      this.zfxqd,
      this.zbstkd,
      this.zarktx,
      this.zwerksms,
      this.zvtwegms
      );

  BillModel.xml2List(outputxmlstr) {
    billModelList = xml
        .parse(outputxmlstr)
        .findAllElements('data')
        .map((node) => new BillModel(
              node.findElements('ZVBELN').single.text,
              node.findElements('ZERDAT').single.text,
              node.findElements('ZVDATU').single.text,
              node.findElements('ZKUNNR').single.text,
              node.findElements('ZNAME1').single.text,
              node.findElements('ZSKWMENG').single.text,
              node.findElements('ZFLAG').single.text,
              node.findElements('ZMATNR').single.text,
              node.findElements('ZDJ').single.text,
              node.findElements('ZDKWMENG').single.text,
              node.findElements('ZJKWMENG').single.text,
              node.findElements('ZYFDJ').single.text,
              node.findElements('ZZNAME1').single.text,
              node.findElements('ZVKGRP').single.text,
              node.findElements('ZVKGRPMS').single.text,
              node.findElements('ZVKBUR').single.text,
              node.findElements('ZVKBURMS').single.text,
              node.findElements('ZTHGC').single.text,
              node.findElements('ZXWDQ').single.text,
              node.findElements('ZZDYH').single.text,
              node.findElements('ZFXQD').single.text,
              node.findElements('ZBSTKD').single.text,
              node.findElements('ZARKTX').single.text,
              node.findElements('ZWERKSMS').single.text,
              node.findElements('ZVTWEGMS').single.text,
            ))
        .toList();
  }
}
