<!-- 為00003333和四月交易明細，寫死的 -->
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="java.util.Collections" %>

<!DOCTYPE html>
<html>
	<sql:setDataSource
		driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
		url="jdbc:sqlserver://127.0.0.1:1433;databaseName=eBanktest;Encrypt=false;"
		user="kiki"
		password="kiki312090"
	/>
	
<%String loginAccount = "047182546793"; // 這邊示範先寫死%>
<!-- String loginAccount = (String) session.getAttribute("account"); -->

<%
String orderBy = request.getParameter("orderBy");
String orderByClause = "ORDER BY transTime DESC, transNum DESC";
if ("date2".equals(orderBy)) {
    orderByClause = "ORDER BY transTime ASC, transNum ASC";
}else{
	orderByClause = "ORDER BY transTime DESC, transNum DESC";
}
%>

<sql:query var="balanceview">
  SELECT 
       transOutNTRecord.transTime as transTime,
       FORMAT(transOutNTRecord.transNTBalance, 'N0') as Balance,
       transOutNTRecord.transNum as transNum
  FROM transOutNTRecord 
  JOIN transInNTRecord ON transOutNTRecord.transNum = transInNTRecord.transNum
  WHERE transOutNTRecord.NTAccount = '<%=loginAccount%>' 
 
  UNION ALL
  
  SELECT 
       transInNTRecord.transTime as transTime,
       FORMAT(transInNTRecord.transNTBalance, 'N0') as Balance,
       transInNTRecord.transNum as transNum
  FROM transOutNTRecord 
  JOIN transInNTRecord ON transOutNTRecord.transNum = transInNTRecord.transNum
  WHERE transInNTRecord.NTAccount = '<%=loginAccount%>'
  ORDER BY transTime DESC, transNum DESC
</sql:query>

<sql:query var="fivetr">
  SELECT 
       transOutNTRecord.transTime as transTime,
       '轉出' as summary,
       transOutNTRecord.NTAccount as ChangeBalanceAccount, 
       FORMAT(transOutNTRecord.transNTAmount, 'N0') as expenses,
       null as TransferIn, 
       FORMAT(transOutNTRecord.transNTBalance, 'N0') as Balance,
       transOutNTRecord.transNum as transNum,
       transInNTRecord.NTAccount as transInOutAcc,
       transOutNTRecord.other as other
  FROM transOutNTRecord 
  JOIN transInNTRecord ON transOutNTRecord.transNum = transInNTRecord.transNum
  WHERE transOutNTRecord.NTAccount = '<%=loginAccount%>' 
  AND transOutNTRecord.transTime BETWEEN '2023-05-01' AND '2023-05-31'
 
  UNION ALL
  
  SELECT 
       transInNTRecord.transTime as transTime,
       '轉入' as summary,
       transInNTRecord.NTAccount as ChangeBalanceAccount, 
       null as expenses, 
       FORMAT(transInNTRecord.transNTAmount, 'N0') as TransferIn,
       FORMAT(transInNTRecord.transNTBalance, 'N0') as Balance,
       transInNTRecord.transNum as transNum,
       transOutNTRecord.NTAccount as transInOutAcc,
       transInNTRecord.other as other
  FROM transOutNTRecord 
  JOIN transInNTRecord ON transOutNTRecord.transNum = transInNTRecord.transNum
  WHERE transInNTRecord.NTAccount = '<%=loginAccount%>'
  AND transInNTRecord.transTime BETWEEN '2023-05-01' AND '2023-05-31'
  
  <%= orderByClause %>
</sql:query>

<sql:query var="fourtr" >
  SELECT 
       transOutNTRecord.transTime as transTime,
       '轉出' as summary,
       transOutNTRecord.NTAccount as ChangeBalanceAccount, 
       FORMAT(transOutNTRecord.transNTAmount, 'N0') as expenses,
       null as TransferIn, 
       FORMAT(transOutNTRecord.transNTBalance, 'N0') as Balance,
       transOutNTRecord.transNum as transNum,
       transInNTRecord.NTAccount as transInOutAcc,
       transOutNTRecord.other as other
  FROM transOutNTRecord 
  JOIN transInNTRecord ON transOutNTRecord.transNum = transInNTRecord.transNum
  WHERE transOutNTRecord.NTAccount = '<% out.print(loginAccount); %>' 
  AND transOutNTRecord.transTime BETWEEN '2023-04-01' AND '2023-04-30'
 
  UNION ALL
  
  SELECT 
       transInNTRecord.transTime as transTime,
       '轉入' as summary,
       transInNTRecord.NTAccount as ChangeBalanceAccount, 
       null as expenses, 
       FORMAT(transInNTRecord.transNTAmount, 'N0') as TransferIn,
       FORMAT(transInNTRecord.transNTBalance, 'N0') as Balance,
       transInNTRecord.transNum as transNum,
       transOutNTRecord.NTAccount as transInOutAcc,
       transInNTRecord.other as other
  FROM transOutNTRecord 
  JOIN transInNTRecord ON transOutNTRecord.transNum = transInNTRecord.transNum
  WHERE transInNTRecord.NTAccount = '<% out.print(loginAccount); %>'
  AND transInNTRecord.transTime BETWEEN '2023-04-01' AND '2023-04-30'
    
  <%= orderByClause %>
</sql:query>


<head>
    <meta charset="UTF-8">

    <title>交易明細</title>
    <link href="./img/cloudyLogoMINI.png" rel="icon">
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/ebanknav.css"> <!-- nav的漢堡包等設計 -->
    <link rel="stylesheet" href="./css/bgColorfull.css"> <!-- nav的流動背景 -->
    <script src="./js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script> <!--有關頁籤籤換動畫，一定要有 -->
    <script src="./js/time.js" defer></script> <!-- 右上角時鐘 -->

    <!-- 我要nav跟body之間相隔100px -->
    <style>
        body {
            margin-top: 100px;
        }

        /* 頁籤碰到時，返的顏色 */
        .nav-tabs .trade.nav-link:hover {
            background-color: #efeff0;
            color: black;
        }

        .nav-tabs li {
            padding: 0 40px;
            
        }

        /* 頁籤的框框 */
        .trade.nav-link.active:hover,
        .trade.nav-link.active:focus,
        .trade.nav-link.active:active {
            border-color: #d26724 #dee2e6 #fff;
        }

        /* 調整select，帳號框框樣式 */
        #account-select {
            width: 200px;/*更改此值来调整select的宽度*/
            border-radius: 5px;/*更改此值来调整select的边框弧度*/
            /* border: none; */
            /*删除默认的select边框*/
            padding: 5px;/*添加填充以增加select的长度*/
        }

        #DateSelect {
            width: 200px;/*更改此值来调整select的宽度*/
            border-radius: 5px;
            margin-left: 14px;
            margin-top: 14px;
            margin-bottom: 14px;
            padding: 5px;/*添加填充以增加select的长度*/
        }

        #keyw{
            width: 300px;/*更改此值来调整select的宽度*/
            border-radius: 5px;
            margin-left: 14px;
            margin-bottom: 14px;
            padding: 3px;/*添加填充以增加select的长度*/
            border-width: 1px;/*框框不要那麼粗 */
        }
        #endDate,#startDate{
            width: 150px;
            border-radius: 5px;
            margin-left: 14px;
            margin-right: 14px;
            margin-bottom: 14px;
            padding: 3px;/*添加填充以增加select的长度*/
        }
        #AccountSelect {
            width: 400px;/*更改此值来调整select的宽度*/
            border-radius: 5px;/*更改此值来调整select的边框弧度*/
            padding: 3px;/*添加填充以增加select的长度*/
            margin-top: 10px;
        }

        /* 下面三個按鈕 */
        .buttona{
            background-color: #8b8ef9; 
            color: white; 
            border: none; 
            border-radius: 4px; 
            font-size: 14px;
            margin-right: 20px;
            padding: 5px 5px 5px 5px;
        }

        /* 搜尋的按紐 */
        .buttonSearch{
            background-color: #c4eaf3;
            border: 1px solid rgb(64, 8, 176);
            padding: 5px 5px 5px 5px; 
            border-radius: 4px; 
            font-size: 16px;
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

    <br>

    <main class="d-flex flex-nowrap" style="font-size: 18px;">
       <!-- padding -->
       <div class="container-fluid text-light mx-5" style="background-color: #b9b8b878; border-radius: 15px;margin-bottom: 30px;">
        <div class="row align-items-center justify-content-between d-flex">
            <div class="col-md p-5" style="color: black;">
                    <!-- 內容，放這邊，灰框框內 -->
                    <div class="container">
                        <div class="AccountInfo">
                            <label for="AccountSelect"><strong>帳號:</strong>
                                <select id="AccountSelect">
                                    <option value="account1">台幣-047182546793</option>
                                    <option value="account3">-</option>
                                </select>
                               
                            </label>
                        </div>

                        <br>
                        <p>
                            <%-- 取得 Balance 值 --%>
							<c:set var="balanceValue" value="${balanceview.rows[0].Balance}"/>
							<strong>帳戶餘額:</strong> <span id="accountBalance">${balanceValue}</span>
                        </p>
                        <br>
                        <!-- 其他內容 -->

                        <section>

                            <div class="card">

                                <select id="DateSelect">
								    <option value="date1">日期排序新到舊</option>
								    <option value="date2">日期排序舊到新</option>
								</select>
								<script>
								    // 取得當前選擇值
								    var currentOrderBy = localStorage.getItem('orderBy');
								
								    // 如果有選擇值，將其設置為選單預設值
								    if (currentOrderBy) {
								        document.getElementById('DateSelect').value = currentOrderBy;
								    }
								
								    // 監聽選單變化
								    document.getElementById('DateSelect').addEventListener('change', function() {
								        var orderBy = this.value;
								        window.location.href = window.location.pathname + '?orderBy=' + orderBy;
								
								        // 將當前選擇值存儲到 localStorage 中
								        localStorage.setItem('orderBy', orderBy);
								    });
								</script>

								
								
							
                                <div class="card-header" style="background-color: white;">
                                    <ul class="nav card-header-tabs nav-tabs">
                                        <li class="nav-item">
                                            <a class="nav-link active trade" href="#fivem">
                                                2023年5月
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link trade" href="#fourm">
                                                2023年4月
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link trade" href="#threem">
                                                2023年3月
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link trade" href="#search">
                                                搜尋
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                
                                
                                <!-- 五月 -->
                                <div class="card-body" id="fivem">
                                    <table class="transaction-table active table table-striped table-hover"
                                        data-month="2023-05">
                                        <tr>
									      <th>日期</th>
									      <th>摘要</th>
									      <th>支出</th>
									      <th>存入</th>
									      <th>結餘</th>
									      <th>轉出入帳號</th>
									      <th>備註</th>
									    </tr>
									    <c:forEach items="${fivetr.rows}" var="t">
									      <tr>
									        <td>${t.transTime}</td>
									        <td>${t.summary}</td>
									        <td>${t.expenses}</td>
									        <td>${t.TransferIn}</td>
									        <td>${t.Balance}</td>
									        <td>${t.transInOutAcc}</td>
									        <td>${t.other}</td>
									      </tr>
									    </c:forEach>
                                    </table>
                                </div>
                                

                                <!-- 四月 -->
                                <div class="card-body d-none" id="fourm">
                                     <table class="transaction-table active table table-striped table-hover"
                                        data-month="2023-04">
                                        <tr>
									      <th>日期</th>
									      <th>摘要</th>
									      <th>支出</th>
									      <th>存入</th>
									      <th>結餘</th>
									      <th>轉出入帳號</th>
									      <th>備註</th>
									    </tr>
									    <c:forEach items="${fourtr.rows}" var="f">
									      <tr>
									        <td>${f.transTime}</td>
									        <td>${f.summary}</td>
									        <td>${f.expenses}</td>
									        <td>${f.TransferIn}</td>
									        <td>${f.Balance}</td>
									        <td>${f.transInOutAcc}</td>
									        <td>${f.other}</td>
									      </tr>
									    </c:forEach>
                                    </table>
                                </div>

                                <!-- 三月 -->
                                <div class="card-body d-none" id="threem">
                                    <table class="transaction-table active table table-striped table-hover"
                                        data-month="2023-03">
                                        <tr>
									      <th>日期</th>
									      <th>摘要</th>
									      <th>支出</th>
									      <th>存入</th>
									      <th>結餘</th>
									      <th>轉出入帳號</th>
									      <th>備註</th>
									    </tr>
									    <tr>
									      <th>無</th>
									      <th></th>
									      <th></th>
									      <th></th>
									      <th></th>
									      <th></th>
									      <th></th>
									    </tr>
									    
                                    </table>
                                </div>

                                <!-- 搜尋 -->
                                <div class="card-body d-none" id="search">   
                                    <!-- 日期搜尋 -->
                                    <script>
										function searchTransactions() {
										
										  // 取得使用者選擇的日期區間
										  var startDate = document.getElementById("startDate").value;
										  var endDate = document.getElementById("endDate").value;
										
										  // 發送 AJAX 請求
										  var xhttp = new XMLHttpRequest();
										  xhttp.onreadystatechange = function() {
										    if (this.readyState == 4 && this.status == 200) {
										      // 將搜尋結果顯示在 div 中
										      document.getElementById("transactionTable").innerHTML = this.responseText;
										    }
										  };
										  xhttp.open("GET", "UserDateSearch.jsp?startDate=" + startDate + "&endDate=" + endDate, true);
										  xhttp.send();
										}
										
										
										// 防止預設提交行為 才可以直接顯示在下面
										document.querySelector('.buttonSearch').addEventListener('click', function(event) {
										    event.preventDefault();  // 防止預設提交行為
										    searchTransactions();
										});

										
									</script>
                                    <form>
	                                    <div style="display: flex; flex-direction: row;">
	                                        <label for="startDate">搜尋起日 ：</label>
	                                        <input type="date" class="form-control" id="startDate" name="startDate">
	                                        <label for="endDate">迄日 ：</label>
	                                        <input type="date" class="form-control" id="endDate" name="endDate">
	                                    </div>
	                                    <!-- 加了type="button"才可以防止預設提交行為 -->
	                                    <button type="button" class="buttonSearch" onclick="searchTransactions()">搜尋</button>
	                                   
	                                    <hr>
	
	                                    <div id="transactionTable"></div> <!-- 新增這個 div 用來顯示交易明細 -->
                                    </form>
                                    
                                   
								
								  
                                </div>

                            </div>

                        </section>

                        <br>
                        <div style="text-align: center; display: flex; justify-content: center;">
						    <button class="buttona transfer-btn" onclick="transfer()">我要轉帳</button>
						    <form action="pdftrade" method="GET">
						        <button class="buttona download-btn" type="submit">歷史明細下載</button>
						    </form>
						</div>
                        
                        
						
                        <script>
                            $(document).ready(function () {
                                $('a.nav-link').click(function (e) {
                                    e.preventDefault(); // 阻止默認跳轉行為
                                    var target = $(this).attr('href');
                                    $('.nav-link').removeClass('active'); // 移除所有 nav-link 元素的 active 類別
                                    $(this).addClass('active'); // 添加目標 nav-link 元素的 active 類別
                                    $('.card-body').addClass('d-none'); // 隱藏所有 card-body 元素
                                    $(target).removeClass('d-none'); // 顯示目標 card-body 元素
                                });
                            });
                        </script>

                    </div>



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


</body>

</html>

