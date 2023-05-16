// 设置倒计时时间
var countDownDate = new Date().getTime() + 180000; // 3分钟，单位是毫秒

// 更新倒计时计时器的函数
function updateCountdown() {
  // 获取当前时间
  var now = new Date().getTime();

  // 计算剩余时间
  var distance = countDownDate - now;

  // 计算剩余分钟数和秒数
  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000);

  // 将分钟数和秒数格式化为 2 位数
  minutes = (minutes < 10 ? "0" : "") + minutes;
  seconds = (seconds < 10 ? "0" : "") + seconds;

  // 更新页面上的倒计时计时器
  document.getElementById("countdown").innerHTML = minutes + ":" + seconds;

  // 如果倒计时结束，则显示“已结束”
  if (distance < 0) {
    clearInterval(x);
    document.getElementById("countdown").innerHTML = "00:00";
  }
}

// 每秒钟更新一次倒计时计时器
var x = setInterval(updateCountdown, 1000);
