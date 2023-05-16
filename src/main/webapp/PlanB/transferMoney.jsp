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
	JSONArray jsArray = new JSONArray();
	jsobj1.put("account", "0000000001");
	jsobj1.put("balance", "7101000");
	jsArray.put(jsobj1);
	//jsobj2.put("account", "0000000002");
	//jsobj2.put("balance", "9658411.3");
	//jsArray.put(jsobj2);
	//jsobj3.put("account", "0000000003");
	//jsobj3.put("balance", "15487236.0");
	//jsArray.put(jsobj3);
	String model = jsArray.toString();
%>
<!DOCTYPE html>
<!-- Ver0.8 -->
<html lang="en">
<head>
    <meta charset="utf-8">

    <title>台幣轉帳</title>
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
               <div class="col-md p-3" style="color: black;font-size: 18px;">
                   <p>
                     <h2 style="text-align: center">台幣轉帳</h2>
                   </p>
                   <div style="color: black;display: flex; justify-content: center; align-items: center;">
                       轉出帳號：
                       <select name="account" style="height: 30px;width: 250px;" id="account">
                         <option>選擇轉出帳號</option>
                     </select>
                     </div>
                     <div style="color: black;display: flex; justify-content: center; align-items: center;">
                        &emsp;&emsp;&emsp;&emsp;&ensp;&nbsp;&nbsp;<span style="font-size: 14px;width: 250px;margin-bottom: 10px;" id="balance"></span>
                      </div>
                    <p style="display: flex; justify-content: center; align-items: center;">
                            轉出金額：<input type="text" required style="height: 30px;width: 250px;" id = "amount">
                    </p>
                   
                    <p>
                        <h4 class="my-4" style="display: flex; justify-content: center; align-items: center;">選擇轉入帳號</h4>
                    </p>
                    <p style="display: flex; justify-content: center; align-items: center;">
                        轉入帳號：<input type="text" required style="height: 30px;width: 250px;" id="inAcc">
                    </p>
                    <p style="display: flex; justify-content: center; align-items: center;">
                        備&emsp;&emsp;註：<input type="text" required style="height: 30px;width: 250px;" id="other">
                    </p>
                    

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
					<br>
					<span></span>
                   <!-- <div class="d-grid col-2 mx-auto">
                   <button type="button" class="btn btn-secondary btn-lg" style="margin-top: 20px;">下一步</button> -->
            
                   <!-- 先放著 看能不能改 -->
                 </div>

                 <div class="px-5">
                    <P>
                        <h3>注意事項：</h3>
                        1.使用指紋/臉部特徵驗證非約定交易之限額為單筆2萬元、單日5萬元、單月10萬元，若超過交易限額則會自動改回OTP密碼驗證方式。<br>
                        2.提醒您，預約交易之轉出帳戶，需於您所設定之交易生效日前一營業日，存入足夠的金額。<br>
                        <strong style="color: red;">3.財富管理客戶所享有【櫃檯服務(含自動化轉帳)手續費優惠】，可適用於立即與預約跨行轉帳/繳費時進行折抵。當該轉出帳號另享有其它(如：撥薪戶)跨行轉帳手續費減免優惠時，將優先使用該項跨行轉帳/繳費手續費減免優惠次數進行折抵，該優惠次數用完後再使用【櫃檯服務(含自動化轉帳)手續費優惠】折抵。預約跨行轉帳交易手續費之折抵，係自實際轉帳交易發生當下享有手續費優惠次數進行扣減，若優惠次數均已用完，則無法進行折抵，本行並將依實際數額收取手續費。</strong> <br>
                        4.自2019/4/1起，本行帳戶每日第1筆轉帳金額為500元(含)以下之跨行轉帳免手續費，轉帳金額為第2筆500元以下及501~1,000元之跨行轉帳手續費每筆收取10元，其餘同現行跨行轉帳手續費15元。<br>
                        5.轉帳額度為同一日每一帳戶，使用網路/行動銀行、ATM、Web ATM及電話銀行等自動化通路合併計算。<br>
                        6.目前本行預設網路/行動銀行約定轉帳每日轉帳限額為新臺幣200萬元(如您的帳戶於2012/8/1(含)以後開立者，預設限額為300萬元)，若申請人另外有約定者從其約定，如欲調整，請本人攜帶身分證明文件至全省各分行辦理。<br>
                        7.若遇執行轉帳交易發生網路傳輸異常時：
                        立即交易者，請至「存款明細查詢」確認交易是否成功。<br>
                        預約交易者，請至「預約轉帳查詢/取消」確認預約交易是否設定成功。<br>
                        8.申請人申請此項服務，本行自接受申請人申請之次日生效，不因存款帳戶印鑑遺失或變更等情事而失其效力，其機關或法人因組織、負責人等變更者亦同。<br>
                        <strong style="color: red;">9.預約或即時轉帳服務不適用於貸款結清交易，如為繳交貸款最後一期金額時，需至各分行辦理或洽本行客服中心確認結清手續。</strong><br>
                        10.申請人申請轉出或轉入之帳戶，如遇轉出或轉入帳戶其中之一結清即視為終止此項約定，本行無通知義務；或因申請人轉出帳戶餘額不足，致本行無法執行此約定時，因而造成申請人損失概由申請人自行負責。<br>
                        11.申請人設定定期定額轉帳服務時，本行將於申請人設定之生效日，逕自申請人指定之轉出帳戶進行扣款，若無相對日則自動順延至次日扣款（無相對日：係如預約固定每月31日轉帳，因11月份並無31日，故會在次日12月1日才進行扣款）。<br>
                        12.若遇電腦系統故障時或其他不可抗力事故，故未能於指定日期進行處理時，申請人同意順延至障礙事由排除後貴行始進行處理。<br>
                        13.申請人若欲取消預約轉帳交易，最遲應於預約轉帳交易日之前一日辦理。<br>
                        14.網路銀行轉帳功能不能解除或更改付款設定，這是歹徒詐騙手法，請撥打165查證。<br>
                        15.本交易款項經確認後，將自您的帳戶中轉出。<br>
                        16.提醒您，『註記』欄位所填寫的資料，於自行轉帳時，會同步顯示於轉/出入帳戶之交易明細，若為跨行轉帳，則將依轉入行之交易明細邏輯顯示；為避免資料外洩，請勿於『註記』欄位輸入個人資料或私密資料。

                    </P>
                 </div>

                </div>
       </div>

    </main>

    <!-- 下面的結束圖標 -->

    <footer class="text-center text-white" style="color: white;font-size: 18px;">
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
	const mySelect = document.getElementById('account');
	const span = document.getElementById('balance');
	const accounts =JSON.parse('<%=model%>');
	for(var i = 0 ; i < accounts.length ; i++){
		const option = document.createElement("option");
		option.text = accounts[i].account;
		option.value = (i);
		mySelect.add(option);
	}
	mySelect.addEventListener('change', function() {
		  const num = parseInt(mySelect.value);
		  const balance = parseFloat(accounts[num].balance).toLocaleString();
		  span.textContent = "餘額 : " + balance;
	});
	function nextStep(event){
		const num = parseInt(mySelect.value);
		if(num < 0 ){
			
		}else{
			const outAcc = accounts[num].account;
			const amount = document.getElementById('amount').value
			const inAcc = document.getElementById('inAcc').value
			const other = encodeURIComponent(document.getElementById('other').value)	
			const sendString = "outAcc=" + outAcc +"&" + "inAcc=" + inAcc + "&" + "amount=" + amount + "&" + "other=" + other
			window.location.href = "/MavenWeb/PlanB/transferMoneydoubleCk.html?"+sendString
		}
	}	
</script>