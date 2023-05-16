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
	
	


<head>
    <meta charset="utf-8" >

    <title>員工端交易明細查詢</title>
    <link href="./img/cloudyLogoMINI.png" rel="icon">
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/bgColorfull.css"> <!-- nav的流動背景 -->
    <link rel="stylesheet" href="./css/ebanknav.css"> <!-- nav的漢堡包等設計 -->
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

        /* 設定頁籤內文字左右間距為 50 像素 */
        .trade.nav-tabs li {
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
        #EndDate,#StartDate{
            width: 150px;
            border-radius: 5px;
            margin-left: 14px;
            margin-right: 14px;
            margin-bottom: 14px;
            padding: 3px;/*添加填充以增加select的长度*/
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
        /* 調整li */
        li {
            list-style: none;
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
         filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#130041', endColorstr='#e7e5ec',GradientType=1 );">
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
                                    <a class="nav-link active d-flex justify-content-end" aria-current="page" href="#" style="margin-right: 0px;color: white;margin-right: 80px;"><strong>登出</strong></a>
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
        <ul class="nav nav-tabs" style="background-color: aliceblue; font-size: 18px;">
            <li class="nav-item">
                <a class="nav-link" aria-current="page" href="#">首頁</a>
                <!-- <a class="nav-link active" aria-current="page" href="#">首頁</a> -->
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                    aria-expanded="false">個人資料</a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="./StaffChangePw.html">密碼修改</a></li>
                    <li><a class="dropdown-item" href="#">假單填寫</a></li>
                    <li><a class="dropdown-item" href="#">打卡紀錄</a></li>
                    <li><a class="dropdown-item" href="#">出缺勤紀錄</a></li>
                </ul>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                    aria-expanded="false">客戶服務</a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#">客服中心</a></li>
                    <li><a class="dropdown-item" href="#">查詢交易明細</a></li>
                    <li><a class="dropdown-item" href="#">開戶專區</a></li>
                </ul>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">公告</a>
            </li>
        </ul>
    </nav>

    <br>

    <div class="row">
        <!-- 員工輸入使用者帳號 -->
        <div class="col-md-2" style="margin-left: 20px;"> 
          <label for="username">會員帳號：</label>
        </div>
        <div class="col-md-3">
          <input type="text" id="username" class="form-control">
        </div>
        <!-- 當員工輸入完帳號後，點擊按鈕執行 showContent() 函式 -->
        <div class="col-md-3">
          <button type="button" class="btn btn-primary" onclick="showContent(); sendUsername();">查詢</button>
        </div>
    </div>
    
    
    <script>
	    function sendUsername() {
	        var username = document.getElementById("username").value;
	        var xhr = new XMLHttpRequest();
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState == XMLHttpRequest.DONE) {
	                // 這裡處理後端回傳的資料
	                console.log(xhr.responseText);
	            }
	        }
	        xhr.open("GET", "YourServletName?username=" + username, true);
	        xhr.send();
	    }
	</script>

    
    <%-- 取得前端輸入框中的值 --%>
	${param.username}
	<%-- 賦值給 loginAccount 變數 --%>
	<% String loginAccount = request.getParameter("username"); %>
	<%String loginAccount2 = "00003333"; // 這邊示範先寫死%>
	
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
	       transOutNTRecord.transNTBalance as Balance, 
	       transOutNTRecord.transNum as transNum
	  FROM transOutNTRecord 
	  JOIN transInNTRecord ON transOutNTRecord.transNum = transInNTRecord.transNum
	  WHERE transOutNTRecord.NTAccount = '<%= loginAccount%>' 
	 
	  UNION ALL
	  
	  SELECT 
	       transInNTRecord.transTime as transTime,
	       transInNTRecord.transNTBalance as Balance, 
	       transInNTRecord.transNum as transNum
	  FROM transOutNTRecord 
	  JOIN transInNTRecord ON transOutNTRecord.transNum = transInNTRecord.transNum
	  WHERE transInNTRecord.NTAccount = '<%= loginAccount%>'
	  ORDER BY transTime DESC, transNum DESC
	</sql:query>
	
	<sql:query var="fivetr">
	  SELECT 
	       transOutNTRecord.transTime as transTime,
	       '轉出' as summary,
	       transOutNTRecord.NTAccount as ChangeBalanceAccount, 
	       transOutNTRecord.transNTAmount as expenses, 
	       null as TransferIn, 
	       transOutNTRecord.transNTBalance as Balance, 
	       transOutNTRecord.transNum as transNum,
	       transInNTRecord.NTAccount as transInOutAcc,
	       transOutNTRecord.other as other
	  FROM transOutNTRecord 
	  JOIN transInNTRecord ON transOutNTRecord.transNum = transInNTRecord.transNum
	  WHERE transOutNTRecord.NTAccount = '<%= loginAccount %>' 
	  AND transOutNTRecord.transTime BETWEEN '2023-05-01' AND '2023-05-31'
	 
	  UNION ALL
	  
	  SELECT 
	       transInNTRecord.transTime as transTime,
	       '轉入' as summary,
	       transInNTRecord.NTAccount as ChangeBalanceAccount, 
	       null as expenses, 
	       transInNTRecord.transNTAmount as TransferIn, 
	       transInNTRecord.transNTBalance as Balance, 
	       transInNTRecord.transNum as transNum,
	       transOutNTRecord.NTAccount as transInOutAcc,
	       transInNTRecord.other as other
	  FROM transOutNTRecord 
	  JOIN transInNTRecord ON transOutNTRecord.transNum = transInNTRecord.transNum
	  WHERE transInNTRecord.NTAccount = '<%=loginAccount%>'
	  AND transInNTRecord.transTime BETWEEN '2023-05-01' AND '2023-05-31'
	  
	  <%= orderByClause %>
	</sql:query>
    


    <main class="d-flex flex-nowrap">
    
        <!-- padding -->
        <!-- id="content" style="display:none;" 當輸入帳號後查詢 -->
        <div class="container-fluid text-light mx-5"  id="content" style="display:none;" style="background-color: #b9b8b878; border-radius: 15px;margin-bottom: 30px;">
            <div class="row align-items-center justify-content-between d-flex">
                <div class="col-md p-5" style="color: black;">
                    <!-- 內容，放這邊，灰框框內 -->
                    <div class="container">
                        
                        <!-- 客戶資料修改 -->
                        <p>使用者資料 :</p>
                        <form>
                            <div class="row"  style="justify-content: center;">
                                <div class="col-md-3">
                                    <!--左侧内容-->
                                    <ul style="font-size: 18px;">
                                        <li>身分證字號</li>
                                        <li>密碼</li>
                                        <li>姓名</li>
                                        <li>英文姓名</li>
                                        <li>暱稱</li>
                                        <li>e-mail</li>
                                        <li>生日</li>
                                        <li>開戶存入金額</li>
                                        <li>申請國內帳戶</li>
                                        <li>申請外幣帳戶</li>
                                        <li>註記</li>
                                    </ul>
                                </div>
                                <div class="col-md-3">
                                    <!--右侧内容-->
                                    <ul style="font-size: 18px;">
                                        <li>A123456789</li>
                                        <li>******</li>
                                        <li>許小姐</li>
                                        <li>JHEN</li>
                                        <li>小白</li>
                                        <li>user@gmail.com</li>
                                        <li>88/01/01</li>
                                        <li>$1,000</li>
                                        <li>是</li>
                                        <li>否</li>
                                        <li></li>
                                    </ul>
                                </div>
                            </div>
                        </form>
                        <br>

                        <div style="text-align: center;">
                            <button class="buttona">修改使用者個資</button>
                        </div>

                        <!-- 查詢交易明細 -->
                        <hr>
                        <br>
                        <p>帳戶餘額: <span id="AccountBalance">123,456</span></p>
                        
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
									    <c:forEach items="${threer.rows}" var="t">
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

                            </div>

                        </section>

                        <br>

                        <div style="text-align: center;">
                            <button class="buttona">我要轉帳</button>
                            <button class="buttona">歷史明細下載</button>
                            <button class="buttona">匯出明細</button>
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

    <!-- 當輸入帳號後查詢 -->
    <script>
        function showContent() {
            // 獲取使用者輸入的帳號
            var username = document.getElementById("username").value;
            
            // 檢查帳號是否為空
            if (username === "") {
                alert("請輸入會員帳號");
                return;
            }
            
            // 顯示要顯示的內容
            var content = document.getElementById("content");
            content.style.display = "block";
        }
    </script>

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