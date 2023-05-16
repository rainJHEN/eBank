window.onload = function() {
  const data = {
    labels: ['1月', '2月', '3月', '4月','5月','6月','7月', '8月', '9月', '10月','11月','12月'],
    datasets: [{
      label: '我的資產走勢',
      data: [20, 42, 25, 23],
      backgroundColor: 'steelblue',
      borderColor: 'steelblue',
      borderWidth: 1
    }]
  };
  
  const config = {
    type: 'bar',
    data: data,
    options: {
      scales: {
        x: {
          title: {
            display: true,
            text: '月份'
          }
        },
        y: {
          title: {
            display: true,
            text: '資產（單位：萬元）'
          },
          ticks: {
            beginAtZero: true
          }
        }
        
      }
    }
  };
  
  const ctx = document.getElementById('myChart').getContext('2d');
  const myChart = new Chart(ctx, config);
  
}