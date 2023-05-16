function updateDate() {
    var now = new Date();
    var year = now.getFullYear();
    var month = now.getMonth() + 1;
    var day = now.getDate();


    month = month < 10 ? "0" + month : month;
    day = day < 10 ? "0" + day : day;


    var dateString = year + "/" + month + "/" + day;
    document.getElementById("dateMoney").innerHTML = dateString;
  }
  updateDate();
  setInterval(updateDate, 10000);