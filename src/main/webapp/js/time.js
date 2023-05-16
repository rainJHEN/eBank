function updateDate() {
    var now = new Date();
    var year = now.getFullYear();
    var month = now.getMonth() + 1;
    var day = now.getDate();
    var hour = now.getHours();
    var minute = now.getMinutes();
    var second = now.getSeconds();

    month = month < 10 ? "0" + month : month;
    day = day < 10 ? "0" + day : day;
    hour = hour < 10 ? "0" + hour : hour;
    minute = minute < 10 ? "0" + minute : minute;
    second = second < 10 ? "0" + second : second;

    var dateString = year + "-" + month + "-" + day + " " +"&ensp;" + hour + ":" + minute + ":" + second;
    document.getElementById("clock").innerHTML = dateString;
  }
  updateDate();
  setInterval(updateDate, 1000);