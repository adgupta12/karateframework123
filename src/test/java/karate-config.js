function fn() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env)
  {
    env = 'cert';
  }

  
  var wait = function(pause){ java.lang.Thread.sleep(pause) }
    
  var dateFormat = function(){
	  var _now = new Date();
	  var yyyy = _now.getFullYear().toString();
	  var YY = yyyy.substr(2,2);
	  var MM = _now.getMonth() + 1;
	  MM = MM < 10 ? '0' + MM.toString() : MM.toString();
	  var DD = _now.getDate();
	  DD = DD < 10 ? '0' + DD.toString() : DD.toString();

	  var hh = _now.getUTCHours();
	  hh = hh < 10 ? '0' + hh.toString() : hh.toString();
	  var mm = _now.getUTCMinutes();
	  mm = mm < 10 ? '0' + mm.toString() : mm.toString();
	  var ss = _now.getUTCSeconds();
	  ss = ss < 10 ? '0' + ss.toString() : ss.toString();
	  var mis = _now.getUTCMilliseconds();
	  if(mis<10)
	  {
		  mis = '00' + mis.toString()
	  }
	  else if(mis<100)
	  {
		  mis = '0' + mis.toString()
	  }
	
	  return {
			  "a":yyyy + MM + DD + hh + mm + ss + mis,
			  "b":yyyy + "-" + MM + "-" + DD
	  		}
	  
  	}
	  
  var dateFormat1 = function(daysToAddOrSubtract){
	  var _now = new Date();
	  _now.setDate(_now.getDate() + daysToAddOrSubtract);
	  var yyyy = _now.getFullYear().toString();
	  var YY = yyyy.substr(2,2);
	  var MM = _now.getMonth() + 1;
	  MM = MM < 10 ? '0' + MM.toString() : MM.toString();
	  var DD = _now.getDate();
	  DD = DD < 10 ? '0' + DD.toString() : DD.toString();

	  var hh = _now.getUTCHours();
	  hh = hh < 10 ? '0' + hh.toString() : hh.toString();
	  var mm = _now.getUTCMinutes();
	  mm = mm < 10 ? '0' + mm.toString() : mm.toString();
	  var ss = _now.getUTCSeconds();
	  ss = ss < 10 ? '0' + ss.toString() : ss.toString();
	  var mis = _now.getUTCMilliseconds();
	  if(mis<10)
	  {
		  mis = '00' + mis.toString()
	  }
	  else if(mis<100)
	  {
		  mis = '0' + mis.toString()
	  }
	
	  return (yyyy + "-" + MM + "-" + DD);

  	}
  

  var subString = function(str,startIndex,endIndex) {
	  		var JavaFunction = Java.type('utilities.JavaFunctions');
    		var javaFunc = new JavaFunction();
    		var subStr = javaFunc.getSubString(str,startIndex,endIndex);
    		return subStr;
    } 
   
    
  var decodeBase64QRCode = function(base64QRCode) {
        	var JavaFunction = Java.type('utilities.JavaFunctions');
    		var javaFunc = new JavaFunction();
    		var decodedStr = javaFunc.decodeBase64QRCode(base64QRCode);
    		return decodedStr;
    } 
  
  var formatDate = function(dateToBeFormatted, fromFormat, toFormat) {
	      	var JavaFunction = Java.type('utilities.JavaFunctions');
	  		var javaFunc = new JavaFunction();
	  		var formattedDate = javaFunc.formatDate(dateToBeFormatted, fromFormat, toFormat);
	  		return formattedDate;
	  } 
	  
  var getParcelNumber =	function(storeNum, statusId, rowNum, updated_by) {
	      	var DBFunction = Java.type('utilities.DBUtilities');
	  		var dbFunc = new DBFunction();
	  		var parcelNumber = dbFunc.getParcelSpecificUserFromParcelLatestTransTable(storeNum, statusId, rowNum, updated_by);
	  		return parcelNumber;
	  } 
  
  var getOrderNumberFromParcelNumber =	function(parcelNumber) {
    	var DBFunction = Java.type('utilities.DBUtilities');
		var dbFunc = new DBFunction();
		var orderNumber = dbFunc.getOrderNumberFromParcelStateTable(parcelNumber);
		return orderNumber;
  	}
  
  var getB2CParcelNumber =	function(storeNum, statusId, rowNum, updated_by) {
    	var DBFunction = Java.type('utilities.DBUtilities');
		var dbFunc = new DBFunction();
		var parcelNumber = dbFunc.getB2CParcelSpecificUserFromParcelLatestTransTable(storeNum, statusId, rowNum, updated_by);
		return parcelNumber;
  } 
  
  var getB2CParcelNumberTNAS =	function(storeNum, statusId, rowNum, clientId) {
  	var DBFunction = Java.type('utilities.DBUtilities');
		var dbFunc = new DBFunction();
		var parcelNumber = dbFunc.getB2CParcelTNASFromParcelLatestTransTable(storeNum, statusId, rowNum, clientId);
		return parcelNumber;
}
  
  var getParcelNumberforDTE =	function(storeNum, updated_by) {
    	var DBFunction = Java.type('utilities.DBUtilities');
		var dbFunc = new DBFunction();
		var parcelNumber = dbFunc.getParcelForDTEFromParcelLatestTransTable(storeNum, updated_by);
		return parcelNumber;
}
  
  var getParcelDetailsFromCDM_QR_LINKTable = function(parcelNumber) {
	      	var DBFunction = Java.type('utilities.DBUtilities');
	  		var dbFunc = new DBFunction();
	  		var cdmQRLinkDetailsList = dbFunc.getParcelDetailsFromCDM_QR_LINKTable(parcelNumber);
	  		var uniqueCode = cdmQRLinkDetailsList[0];
	  		var orderNumber = cdmQRLinkDetailsList[1];
	  		var clientName = cdmQRLinkDetailsList[2];
			var location = cdmQRLinkDetailsList[3];
			var dwellTimeExpiryDate = cdmQRLinkDetailsList[4];
			var arr = [uniqueCode, orderNumber, clientName, location, dwellTimeExpiryDate];
	  		return arr;
	  } 
	  
  var getClientDetailsFromCdm_client_refTable = function(client_name) {
	  		var DBFunction = Java.type('utilities.DBUtilities');
	  		var dbFunc = new DBFunction();
	  		var cdmClientDetailsList = dbFunc.getClientDetailsFromCdm_client_refTable(client_name);
	  		var clientId = cdmClientDetailsList[0];
	  		return clientId;
	  } 
	   
  var decodeBase64Barcode = function(base64Barcode) {
	      	var JavaFunction = Java.type('utilities.JavaFunctions');
	  		var javaFunc = new JavaFunction();
	  		var decodedStr = javaFunc.decodeBase64Barcode(base64Barcode);
	  		return decodedStr;
	  } 
  
  var createRandomParcelNumber = function(cliendId) {
	      	var JavaFunction = Java.type('utilities.JavaFunctions');
	  		var javaFunc = new JavaFunction();
	  		var parcelNumber = javaFunc.createRandomParcelNumber(cliendId);
	  		return parcelNumber;
	  } 
	  
  var getSlotId = function(storeNum, parcelNumber) {
	      	var DBFunction = Java.type('utilities.DBUtilities');
	  		var dbFunc = new DBFunction();
	  		var list = dbFunc.validateLocPkgTransTable1(storeNum, parcelNumber);
	  		var slotId = list[0];
	  		return slotId;
	  } 
  
  var getParcelDetailsForNotReceivedContainers = function(storeNum) {
    	var DBFunction = Java.type('utilities.DBUtilities');
		var dbFunc = new DBFunction();
		var parcelDetailsList = dbFunc.getParcelDetailsForNotReceivedContainers(storeNum);
//		var parcelNumber = parcelDetailsList[0];
//  		var containerNumber = parcelDetailsList[1];
//  		var arr = [parcelNumber, containerNumber];
//  		return arr;
		return parcelDetailsList;
  } 
  
  var getCageNumber = function(containerNumber) {
    	var DBFunction = Java.type('utilities.DBUtilities');
		var dbFunc = new DBFunction();
		var cageNumber = dbFunc.getCageNumber(containerNumber);
		return cageNumber;
  }
	  
  
  var config = {
		  
    env: env,
    ws_url: 'https://connect-isc-cert.cert.hosting.asda.com:9080',
    ws_cdm_url: 'https://connect-cdm-cert.cert.hosting.asda.com:9100',
//    ws_toyou_url: 'http://10.247.199.128:8080',
    ws_toyou_url: 'https://toyou.stg.walmart.com',
//    ws_toyou_widget_url: 'http://10.118.89.61:8080', //old not working
//    ws_toyou_widget_url: 'http://10.118.78.109:8080', //not working
//    ws_toyou_widget_url: 'http://10.118.72.72:8080',	//not working
    ws_toyou_widget_url: 'http://10.118.68.254:8080',	//new working
//    ws_toyou_widget_url: 'http://10.118.67.59:8080',	//new working
//    ws_toyou_widget_url: 'http://10.36.151.161:8080',	//new working
//    ws_toyou_widget_url: 'http://10.36.136.18:8080',	//new working
       
    url_xi52: 'https://xi52-cert.cert.hosting.asda.com',
    url_xg45: 'https://apicert.toyou.co.uk',
    
	ssl: { keyStore: 'classpath:LUKNT10371UK2020.wal-mart.com.jks', keyStorePassword: 'Cert@LUKNT10371UK2020', keyStoreType: 'jks', trustStore: 'classpath:AutomationTruststore_CERT_SIT.jks', trustStorePassword: 'Cert@LUKNT10371UK2020', trustStoreType: 'jks'},	
	proxy: 'http://sysproxy.wal-mart.com:8080',
	proxy1: { uri: 'http://sysproxy.wal-mart.com:8080' , nonProxyHosts: ['161.163.89.59', 'georgebackend.oms.stg.walmart.com', 'http://xi52-toyou.sit.hosting.asda.com'] },
	
	//pass functions
	runDate: dateFormat()["b"],
	runDate1: dateFormat1(-2),
	currentDateTimeStamp: dateFormat()["a"],	
	wait: wait,
	subString: subString,
	formatDate: formatDate,
	decodeBase64QRCode: decodeBase64QRCode,
	decodeBase64Barcode: decodeBase64Barcode,
	createRandomParcelNumber: createRandomParcelNumber,
	getParcelNumber: getParcelNumber,
	getB2CParcelNumberTNAS: getB2CParcelNumberTNAS,
	getOrderNumberFromParcelNumber: getOrderNumberFromParcelNumber,
	getB2CParcelNumber: getB2CParcelNumber,
	getParcelNumberforDTE: getParcelNumberforDTE,
	getSlotId: getSlotId,
	getParcelDetailsForNotReceivedContainers: getParcelDetailsForNotReceivedContainers,
	getCageNumber: getCageNumber,
	getParcelDetailsFromCDM_QR_LINKTable: getParcelDetailsFromCDM_QR_LINKTable,
	getClientDetailsFromCdm_client_refTable: getClientDetailsFromCdm_client_refTable
			
  }
  
  //code to customize data for different environments
  if (env == 'sit')
  {
	  config.url = 'http://xi52.sit.hosting.asda.com';
	  config.url_xi52 = 'http://xi52.sit.hosting.asda.com';
	  config.url_xg45 = 'https://apisit.toyou.co.uk';
  } 
  
//don't waste time waiting for a connection or if servers don't respond within 5 seconds
  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 60000);
  karate.configure('logPrettyResponse', true);
  karate.configure('logPrettyRequest', true);
  
  return config;
}