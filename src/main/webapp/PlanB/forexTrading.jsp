<%@page import="org.json.*"%>
<%@page import="java.util.LinkedList"%>
<%@page import="tw.ebank.model.*"%>
<%@page import="tw.ebank.api.*"%>
<%@page import="javax.servlet.ServletContext" %>
<%@page import="javax.servlet.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//NTTrade_model model = session.getAttribute('NTtrade_model');
	JSONObject jsobj1 = new JSONObject();
	JSONObject jsobj2 = new JSONObject();
	JSONObject jsobj3 = new JSONObject();
	JSONObject jsobj4 = new JSONObject();
	JSONArray jsArray = new JSONArray();
	jsobj1.put("currency","NT");
	jsobj1.put("account", "0000000001");
	jsobj1.put("balance", "7852100");
	jsArray.put(jsobj1);
	jsobj2.put("currency","JPY");
	jsobj2.put("account", "0000000002");
	jsobj2.put("balance", "854962.13");
	jsArray.put(jsobj2);
	jsobj3.put("currency","EUR");
	jsobj3.put("account", "0000000002");
	jsobj3.put("balance", "54856.21");
	jsArray.put(jsobj3);
	jsobj4.put("currency","USD");
	jsobj4.put("account", "0000000002");
	jsobj4.put("balance", "79654.23");
	jsArray.put(jsobj4);
	String model = jsArray.toString();
	
	JSONObject Exchanges = new JSONObject();
	JSONObject NTEx = new JSONObject();
	NTEx.put("NT","1");
	NTEx.put("USD","0.033");
	NTEx.put("JPY","4.38");
	NTEx.put("EUR","0.029");
	Exchanges.put("NT",NTEx);
	JSONObject USDEx = new JSONObject();
	USDEx.put("NT","30.64");
	USDEx.put("USD","1");
	USDEx.put("JPY","134.17");
	USDEx.put("EUR","0.9");
	Exchanges.put("USD",USDEx);
	JSONObject JPYEx = new JSONObject();
	JPYEx.put("NT","0.23");
	JPYEx.put("USD","0.0075");
	JPYEx.put("JPY","1");
	JPYEx.put("EUR","0.0067");
	Exchanges.put("JPY",JPYEx);
	JSONObject EUREx = new JSONObject();
	EUREx.put("NT","34");
	EUREx.put("USD","1.11");
	EUREx.put("JPY","148.89");
	EUREx.put("EUR","1");
	Exchanges.put("EUR",EUREx);
	
	String exchanges = Exchanges.toString();
%>
<!DOCTYPE html>
<!-- Ver0.8 -->
<html lang="en">
<head>
    <meta charset="utf-8">

    <title>外幣換匯</title>
    <link rel="stylesheet" href="./bootstrap5/css/bootstrap.min.css">
    <script src="./js/bootstrap.min.js"></script>
    <link href="./img/cloudyLogoMINI.png" rel="icon">
    <link rel="stylesheet" href="./css/butybutton.css">
    <!-- nav的流動背景 -->
    <link rel="stylesheet" href="./css/bgColorfull.css">
     <!-- nav的漢堡包等設計 -->
    <link rel="stylesheet" href="./css/ebanknav.css">

    <!-- 我要nav跟body之間相隔100px -->
    <style>
        body {
            margin-top: 100px;
        }

        /* 頁籤碰到時，返的顏色 */
        .nav-tabs .nav-link:hover {
            background-color: #e9ecef;
        }

        .nav-tabs li {
            padding: 0 40px;
            /* 設定頁籤內文字左右間距為 50 像素 */

        }
    </style>

<style>
    /* 滾動條樣式修正開始 */
    ::-webkit-scrollbar {
  width: 10px;
  height: 10px;
  }
  
  ::-webkit-scrollbar-thumb {
  background-color: rgba(0, 0, 0, 0.4);
  border-radius: 8px;
  }
  
  ::-webkit-scrollbar-track {
  background-color: transparent;
  }
  /* 在顶部和底部各添加10像素的间隔 */
  ::-webkit-scrollbar-track-piece{
      background: transparent;
      margin: 5px;
    } 
    /* 滾動條結束 */
  </style>

</head>

<body class="text-start"  style="background-image: url(./img/lowPoly03.jpg);background-size: cover;height:100%;display: flex;flex-direction: column;min-height: 80.2vh;font-family: Helvetica;font-size: 18px;">
    <!-- footer的style都是為了讓他在最底部 -->

    <nav class="fixed-top"> <!--此是為了這裡面置頂 -->

        <!-- 上面的navbr --> <!-- py-1更改navbar上下寬度 -->
        <nav class="navbar navbar-expand-lg navbar-light" style="background: #130041;
        background: -moz-linear-gradient(left, #130041 0%, #130041 22%, #8d81a5 67%);
        background: -webkit-linear-gradient(left, #130041 0%,#130041 22%,#8d81a5 67%);
        background: linear-gradient(to right, #130041  0%,#130041 22%,#8d81a5 67%);
         filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#130041', endColorstr='#e7e5ec',GradientType=1 );
        padding-top: 0.1rem;padding-bottom:0.1rem;">
            <div class="container-fluid">
                <img src="./img/cloudyLogo.png" alt="" style="width:130px;margin-right:20px;margin-left: 30px;">
                <a href="#" class="navbar-brand" style="color: white;"></a>
                
                <nav class="navbar navbar-expand-lg navbar-light">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <!-- align-items-center 是為了讓回首頁跟時間對齊 -->
                            <!-- 回首頁 -->
                            <div class="col-lg-4">
                                <ul class="navbar-nav ms-auto mb-2 mb-lg-0" style="white-space:nowrap;">
                                <li class="nav-item d-lg-block d-none">
                                    <a class="nav-link active d-flex justify-content-end" aria-current="page" href="#" style="margin-right: 0px;color: white"><strong>回首頁</strong></a>
                                </li>
                                <li class="nav-item ">
                                    <a class="nav-link active d-flex justify-content-end" aria-current="page" href="#" style="margin-right: 0px;color: white;margin-right: 50px;"><strong>登出</strong></a>
                                </li>
                                </ul>
                            </div>
                            <!-- 右邊時間 -->
                            <div class="col-lg-4 d-lg-block d-none" style=" white-space:nowrap;display: flex;align-items: center;">
                                <div id="clock" style="font-size: 16px;font-family:Arial;"></div>
                            </div>
                        </div>
                    <!-- </div> -->
                    </div>
                </nav>      
            </div>
        </nav>
    
        
         <!-- 頁籤 -->
         <!-- navbar-toggler 類別的元素是漢堡包按鈕。
         當按下這個按鈕，navbar-collapse 類別的元素會展開。
         dropdown-menu 類別的元素是下拉式選單。 -->
    
            <nav class="navbar navbar-expand-lg navbar-light nav-tabs" style="background-color: aliceblue;">
                <!-- 縮小時有漢堡包 -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                  <!-- 下面這行為漢堡包內容 -->
                <div class="collapse navbar-collapse" id="navbarNav">
                    <!-- 開始ul -->
                    <ul class="navbar-nav" style="font-size: 18px;padding-left: 20px;padding-right: 20px;">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                                aria-expanded="false">台幣存款</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">台幣轉帳</a></li>
                                <li><a class="dropdown-item" href="#">換匯</a></li>
                                <li><a class="dropdown-item" href="#">台幣交易明細</a></li>
                                <!-- dropdown-item表示按鈕 -->
                            </ul>
                        </li>
    
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                                aria-expanded="false">定期存款</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">查利率</a></li>
                                <li><a class="dropdown-item" href="#">轉定存</a></li>
                                <li><a class="dropdown-item" href="#">定存明細</a></li>
                            </ul>
                        </li>
    
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                                aria-expanded="false">外幣存款</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">查匯率</a></li>
                                <li><a class="dropdown-item" href="#">換匯</a></li>
                                <li><a class="dropdown-item" href="#">外幣帳戶</a></li>
                            </ul>
                        </li>
    
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                                aria-expanded="false">信用卡</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">帳單資訊</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
    
    </nav>

    <br>
    <main class="d-flex flex-nowrap">

        <!-- 內容 -->

            
       <!-- padding -->
       <div class="container-fluid text-light mx-5" style="background-color: #b7b7b766; border-radius: 15px;margin-bottom: 30px;">
           <div class="row align-items-center justify-content-between d-flex">
               <!-- justify-content 属性（水平）对齐弹性容器的项目，当项目不占用主轴上所有可用空间时。 -->
                   <!-- .img-fluid 設定為響應式圖片。運用 max-width: 100%; 和 height: auto;，讓圖片可依父元素進行縮放 -->
               <div class="col-md p-3" style="color: black;font-size:18px">
                   <p>
                     <h2 style="text-align: center">外幣換匯</h2>
                   </p>
                   <p> 
                   <div style="color: black;display: flex; justify-content: center; align-items: center;">
                    轉出幣別：
                    <select name="account" style="height: 30px;width: 250px;" id="outCurrency">
                      <option value="xx">選擇轉出幣別</option>
                      <option value="NT">新台幣</option>
                      <option value="USD">美金</option>
                      <option value="JPY">日幣</option>
                      <option value="EUR">歐元</option>
                  </select>
                  </div>
                </p>
                   <div style="color: black;display: flex; justify-content: center; align-items: center;">
                       轉出帳號：
                       <select name="account" style="height: 30px;width: 250px;" id="outAcc">
                         <option>選擇轉出帳號</option>
                     </select>
                     </div>
                     <div style="color: black;display: flex; justify-content: center; align-items: center;">
                        &emsp;&emsp;&emsp;&emsp;&ensp;&nbsp;&nbsp;<span style="font-size: 14px;width: 250px;margin-bottom: 10px;" id="balance"></span>
                      </div>
                    <p style="display: flex; justify-content: center; align-items: center;">
                        <label>
                            轉出金額：<input type="text" required style="height: 30px;width: 250px;" id="amount">
                        </label>
                    </p>
                   
                    <p><h4 class="my-4" style="display: flex; justify-content: center; align-items: center;">選擇轉入帳號</h4></p>
                        <div style="color: black;display: flex; justify-content: center; align-items: center;">
                            轉入幣別：
                            <select name="account" style="height: 30px;width: 250px;" id="inCurrency">
                              <option value="xx">選擇轉入幣別</option>
                              <option value="NT">新台幣</option>
                              <option value="USD">美金</option>
                              <option value="JPY">日幣</option>
                              <option value="EUR">歐元</option>
                          </select>
                          </div>
                     <div style="color: black;display: flex; justify-content: center; align-items: center;">
                        &emsp;&emsp;&emsp;&emsp;&ensp;&nbsp;&nbsp;<span style="font-size: 14px;width: 250px;margin-bottom: 10px;" id="exchange"></span>
                      </div>
                      <p style="display: flex; justify-content: center; align-items: center;"><label>轉入帳號：
                        <select  style="height: 30px;width: 250px;" id="inAcc">
                          <option>選擇轉入帳號</option>
                      </select></label>

                      <!-- <p style="display: flex; justify-content: center; align-items: center;"><label>交易性質：
                        <select style="height: 30px;width: 250px;">
                          <option>請選擇</option>
                          <option >結構外匯僅做外匯存款不再匯出</option>
                          <option >股本投資等投資款</option>
                          <option >國外存款等投資款</option>
                          <option >對外融資</option>
                          <option >債還國外融資</option>
                      </select></label></p> -->
                      <!-- 交易性質目前刪除 -->

                    <!-- <p style="display: flex; justify-content: center; align-items: center;"><label>備&emsp;&emsp;註： <input type="text" required placeholder="請輸入" style="height: 30px;width: 250px;"></label></p> -->
                    <!-- 備註目前刪除 -->
                    <div class="row">
                        <!-- 列元素 -->
                        <div class="col-lg-12" style="text-align:center;">
                            <button class="custom-btn btn-2 btn-lg" style="width: 150px;height: 45px;">取消</button>
                            <button class="custom-btn btn-2 btn-lg" style="width: 150px;height: 45px;" onclick="nextStep(event)">下一步</button>
                        </div>

                   <!-- <div class="d-grid col-2 mx-auto">
                   <button type="button" class="btn btn-secondary btn-lg" style="margin-top: 20px;">下一步</button> -->
            
                   <!-- 先放著 看能不能改 -->
                 </div>
               </div>
       </div>

    </main>

    <div style="height: 40px;"></div>
    <!-- 解決萬一有些螢幕太小造成底部fixed-bottom的footer會蓋住中間資訊，所以弄空白行與footer隔開一點 -->

    <!-- 下面的結束圖標 -->

    <footer class="text-center text-white fixed-bottom" style="color: white;font-size: 18px;">
        <!-- Grid container -->
        <div class="d-flex bd-highlight yeee"
            style="color: white;font-size: 18px;display: flex;text-align: center;">
  
            <div class="p-2 flex-fill bd-highlight  d-lg-block d-none">e-BANK國際商業銀行 Copyright e-Bank International Bank. All Rights
                Reserved.</div>
  
            <div class="p-2 flex-fill bd-highlight">
                <img src="./img/cloudyLogoMINI.png" style="width:5%;"><strong> &nbsp;©e-BANK國際商業銀行</strong>
            </div>
        </div>
        <!-- Grid container -->
    </footer>





    <!-- 客服 -->
    <!-- <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
    <df-messenger intent="WELCOME" chat-title="KikiRobot" agent-id="470db5ea-968e-42aa-862e-9852b15f0a94"
        language-code="zh-tw"></df-messenger>

        <script src="https://kit.fontawesome.com/23c2e3486c.js" crossorigin="anonymous"></script> -->
        <!-- icon -->

        <script src="./js/time.js"></script>
</body>
</html>
<script>
	const outCurrency = document.getElementById('outCurrency');
	const outAcc = document.getElementById('outAcc');
	const inCurrency = document.getElementById('inCurrency');
	const inAcc = document.getElementById('inAcc');
	const span = document.getElementById('balance');
	const accounts =JSON.parse('<%=model%>');
	const exchanges =JSON.parse('<%=exchanges%>');
	const exSpan=document.getElementById('exchange');
	outCurrency.addEventListener('change', function(){
		const inCurr_str = inCurrency.value;
		const outCurr_str = outCurrency.value;
		for(var i = 0 ; i < inCurrency.options.length;i++){
			inCurrency.options[i].style.display = "block";
		}
		const index = outCurrency.selectedIndex;
		inCurrency.options[index].style.display = "none";
		inCurrency.options[index].selected = false;
		if(outCurr_str == inCurr_str && outCurr_str != 'xx'){
			
			inCurrency.options[index].style.display = "none";
			inCurrency.options[index].selected = "false";
			}else if(outCurr_str != 'xx'){
				inCurrency.options[index].style.display = "none";
			}
		
		if(inCurr_str !== 'xx' && outCurr_str !== 'xx'){
			exSpan.textContent = "當前匯率為 : " + exchanges[outCurr_str][inCurr_str] ;
		}
		while (outAcc.firstChild) {
			outAcc.removeChild(outAcc.firstChild);
		}
		const option = document.createElement("option");
		option.text = '選擇轉出帳號';
		option.value = 'xx';
		outAcc.add(option);
		span.textContent="";
		for(var i = 0 ; i < accounts.length ; i++){
			if(accounts[i].currency === outCurrency.value){
				const option = document.createElement("option");
				option.text = accounts[i].account;
				option.value = i;
				outAcc.add(option);
			}
		}
	});
	inCurrency.addEventListener('change', function(){
		const inCurr_str = inCurrency.value;
		const outCurr_str = outCurrency.value;
		if(inCurr_str !== 'xx' && outCurr_str !== 'xx'){
			exSpan.textContent = "當前匯率為 : " + exchanges[outCurr_str][inCurr_str] ;
		}
		while (inAcc.firstChild) {
			inAcc.removeChild(inAcc.firstChild);
		}
		const option = document.createElement("option");
		option.text = '選擇轉入帳號';
		option.value = 'xx';
		inAcc.add(option);
		for(var i = 0 ; i < accounts.length ; i++){
			if(accounts[i].currency === inCurrency.value){
				const option = document.createElement("option");
				option.text = accounts[i].account;
				option.value = i;
				inAcc.add(option);
			}
		}
	});
	outAcc.addEventListener('change', function() {
		  const num = parseInt(outAcc.value);
		  const balance = parseFloat(accounts[num].balance).toLocaleString();
		  span.textContent = "餘額 : " + balance;
	});
	function nextStep(event){
		const out_num = parseInt(outAcc.value)
		const in_num = parseInt(inAcc.value);
		if(out_num == '' && in_num == ''){
			
		}else{
			const outAcc_str = accounts[out_num].account;
			const outCurr_str = outCurrency.value;
			const inCurr_str = inCurrency.value;
			const amount = document.getElementById('amount').value;
			const inAcc_str = accounts[in_num].account;
			const exchange = exchanges[outCurr_str][inCurr_str];
			const sendString = "outAcc=" + outAcc_str +"&" + "inAcc=" + inAcc_str + "&" + "amount=" + amount + "&" + "outCurr=" + outCurr_str + "&" + "inCurr=" + inCurr_str + "&" + "exchange=" + exchange;
			window.location.href = "/MavenWeb/PlanB/forexTradingdoubleCk.html?"+sendString
		}
	}	
</script>