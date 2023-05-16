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
	
%>
<!DOCTYPE html>
<!-- Ver0.8 -->
<html lang="en">
  <meta charset="utf-8" />
<head>
    <meta charset="utf-8">

    <title>台幣轉帳成功</title>
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
      margin: 3px;
    } 
    /* 滾動條結束 */
  </style>

</head>

<body class="text-start"  style="background-image: url(./img/lowPoly03.jpg);background-size: cover;font-family: Helvetica;font-size: 18px;">
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
                        <div class="col-md p-3" style="color: black;font-size: 18px;display: flex; justify-content: center; align-items: center;flex-direction: column;">
                            <p>
                              <h2 style="text-align: center">台幣轉帳成功</h2>
                            </p>
                            <P style="color: black;">
                                <h3>轉出帳號</h3>
                                <h5>0000000001</h5>
                              <h5>剩餘餘額:7,001,000元</h5>
                            </P>

                            <div class="container" style="display: flex; justify-content: center; align-items: center; flex-direction: column;">
                                <span style="margin-bottom: 10px; font-weight: bold;"><h3>收款人資訊</h3></span>
                                <h5>轉入帳號:0000000002</h5>
                                <h5>轉入金額:100,000</h5>
                                <h5>轉帳日期:<span id="dateMoney"></span></h5>
                                <br>
                                <h5>交易備註(選填)：</h5>
                                <h5 style="margin-top: 5px;">欠王小明的錢</h5>
                            </div>
                            <!-- 收款人的container-div結束 -->
                            <div class="container" style="display: flex; justify-content: center; align-items: center;">
                                <button class="custom-btn btn-2 btn-lg" style="width: 150px;height: 45px;">回首頁</button>
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

 





    <!-- 客服 -->
    <!-- <div class="container">
        <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
        <df-messenger intent="WELCOME" chat-title="KikiRobot" agent-id="470db5ea-968e-42aa-862e-9852b15f0a94"
            language-code="zh-tw"></df-messenger>
    </div>

        <script src="https://kit.fontawesome.com/23c2e3486c.js" crossorigin="anonymous"></script> -->
        <!-- icon -->

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
    

      <script src="./js/time.js"></script>
      <script src="./js/date.js"></script>
</body>
</html>

<!-- 1.框框內加上資料時間:現在時間 單位金額:新台幣 -->
<!-- 2.添加常用匯款帳號 -->
<!-- 3.克服擋到位置，要馬砍掉，要馬想辦法換位置 -->
<!-- 4.全部頁面的radius記得看有沒有統一 -->