var sapURL =
    'http://dstbj.jdsn.com.cn:8081/sap/bc/srt/rfc/sap/zif_wq_in_ws/102/service/binding';
var sapHeader = {
  "SOAPAction":
      "urn:sap-com:document:sap:rfc:functions:Zif_WQ_IN_WS:ZIF_WQ_IN_WSRequest",
  "Content-Type": "text/xml;charset=UTF-8",
  'Authorization': 'Basic VFJGQzAxOjEyMzQ1Ng=='
};

getSAPURL(String funcName) {
  funcName = funcName.toUpperCase();
  return "http://dstbj.jdsn.com.cn:8081/sap/bc/srt/rfc/sap/$funcName/102/service/binding";
}

getSAPHeader(String funcName) {
  funcName = funcName.toUpperCase();
  return {
    "SOAPAction": "urn:sap-com:document:sap:rfc:functions:$funcName:$funcName" +
        "Request",
    "Content-Type": "text/xml;charset=UTF-8",
    'Authorization': 'Basic VFJGQzAxOjEyMzQ1Ng=='
  };
}

getSelfURL() {
  return "http://60.2.191.108:8287";
}

getOAURL() {
  return "http://10.0.65.16/services/";
}

setSelfURL(String url, int port) {}

setSAPURL(String url, int port) {}
