<%@page import="io.jsonwebtoken.Claims"%>
<%@page import="java.util.Date"%>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
<%@page import="tw.ebank.model.*"%>
<%@page import="tw.ebank.api.*"%>
<%@page import="javax.servlet.ServletContext" %>
<%@page import="javax.servlet.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%		
		
			String token = request.getParameter("token");
			Claims jwt =  JwtUtils.parseToken(token);
			Object email = jwt.get("email");
		
		
%>
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <title>忘記密碼</title>
    <link href="./img/cloudyLogoMINI.png" rel="icon">
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/ebanknav.css"> <!-- nav的漢堡包等設計 -->
    <link rel="stylesheet" href="./css/bgColorfull.css"> <!-- nav的流動背景 -->
    <script src="./js/bootstrap.min.js"></script>
    <script src="./js/time.js" defer></script> <!-- 右上角時鐘 -->    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script><!-- 以下是使用sweetalert -->
    
    

    <style>
        .loo{
            margin-top: 10%;
        }
    </style>

</head>
<body class="text-start"  style="font-family: Helvetica; font-size: 18px;background-image: url(./img/bkbk.jpg);background-size: cover;height:100%;display: flex;flex-direction: column;min-height: 80.2vh;">

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
                                <div id="clock" style="font-size: 16px;"></div>
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

        <nav class="navbar navbar-expand-lg navbar-light nav-tabs  " style="background-color: aliceblue;">
            <!-- 縮小時有漢堡包 -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
              <!-- 下面這行為漢堡包內容 -->
            <div class="collapse navbar-collapse" id="navbarNav">
                <!-- 開始ul -->
                <ul class="navbar-nav" style="font-size: 18px;padding-left: 100px;padding-right: 100px;">
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

    <section class="loo">
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-6 offset-md-3"> <!--調離左邊的位置 -->

                    <div class="card">

                        <div class="card-header" style="text-align: center;">
                            <h4  style="margin-top: 10px;">忘記密碼</h4>
                        </div>

                        <!-- 一般登入的內容 -->
                        <div class="card-body" id="general" style="background: #fcfcfc;
                        background: -moz-linear-gradient(left,  #fcfcfc 26%, #e8e2f7 95%);
                        background: -webkit-linear-gradient(left,  #fcfcfc 26%,#e8e2f7 90%);
                        background: linear-gradient(#fcfcfc 26%,#e8e2f7 95%);
                        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fcfcfc', endColorstr='#e8e2f7',GradientType=1 ); 
                        padding-top: 0.1rem;padding-bottom:0.1rem;">
                            <form
                            style="margin-bottom: 2%;  color:black; border-radius: 15px; margin: 10px;">
                            <!-- background-color: #d7d1e6 -->
            
                            <div class="mb-3">
                                <label class="form-label" for="passwordnew">
                                    <h4>新密碼</h4>
                                </label>
                                <input class="form-control" type="password" name="passwordnew" id="passwordnew">
                            </div>

                            <div class="mb-3">
                                <label class="form-label" for="passwordnew2">
                                    <h4>再次確認新密碼</h4>
                                </label>
                                <input class="form-control" type="password" name="passwordnew2" id="passwordnew2">
                            </div>

                        </form>
                        <!-- 按下修改後的彈出視窗 -->
                        <!-- 成功 -->
                        <script>
                            function okRevise() {
                                Swal.fire({
                                    position: 'center',
                                    icon: 'success',
                                    title: '更改密碼成功',
                                    showConfirmButton: false,
                                    timer: 1500
                                }).then(() => {
                                    window.location.href = "http://localhost:7070/MavenWeb/PlanA/UserLogin.html";
                                });
                            }
                        </script>

                        <!-- 失敗 -->
                        <script>
                        function noRevise() {
                            Swal.fire({
                            icon: 'error',
                            title: '更改失敗',
                            text: '再次確認密碼輸入錯誤，請再次輸入',
                            })
                        }
                        </script>
        
                        <!-- <input class="btn btn-primary d-block btn-user w-100" type="submit" onclick="Revise()" value="修改"> -->
                        <button class="btn btn-primary d-block btn-user w-100" onclick = "changePw()">修改</button>
                        
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>

    

<!-- 下面的結束圖標 -->
<br><br><br>
<footer class="text-center">
    <div class="container text-muted py-4 py-lg-5">
        <ul class="list-inline">
            <li class="list-inline-item me-3"><strong>關於e-Bank</strong></li>
            <li class="list-inline-item me-3">l</li>
            <li class="list-inline-item me-3"><strong>e-Bank APP</strong></li>
            <li class="list-inline-item me-3">l</li>
            <li class="list-inline-item me-3"><strong>聯繫客服</strong></li>
        </ul>
        <strong> &nbsp;©e-BANK國際商業銀行</strong>
    </div>
</footer>
</body>

</html>
<script>
	function changePw(){
		event.preventDefault();
		var pswd  = document.getElementById('passwordnew').value;
		var pswd2  = document.getElementById('passwordnew2').value;
		const xhr = new XMLHttpRequest();
		if(pswd != "" && pswd2 != "" && pswd==pswd2){
			xhr.onreadystatechange = function() {
				  if (xhr.readyState === 4 && xhr.status === 200) {
					  xhr.onload = function(){
						  const responseText = xhr.responseText.trim(); // 獲取JSP返回的數據
						    if(responseText == 'success'){
						    	okRevise();
						    }
						    else{
						    	noRevise();
						    }
						}
			}
			
		}
			xhr.open('POST', '/MavenWeb/jsp/changePw.jsp?');
			xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			var password = 'password=' + pswd + "&";
			var email ="email="+'<%=email%>';
			xhr.send(password+email);
	}else{
		noRevise();
	}
	}
</script>