document.addEventListener('turbolinks:load', function() {
  let timer = document.querySelector('.test-passage-timer');
  if (timer) {
    
    let testSeconds = timer.dataset.timer * 60;
    setInterval(function() {
      
      if (testSeconds === 0) {
        timer.textContent = "00:00"
        submitForm();
      }

      testSeconds--;

      let timeRemaining = new Date(0, 0, 0);
      timeRemaining.setSeconds(testSeconds);
      
      let m = timeRemaining.getMinutes();
      let s = timeRemaining.getSeconds();
      timer.textContent = displayMeasurement(m) + ':' + displayMeasurement(s);      
    }, 1*1000)
  }
})

function displayMeasurement(measurement) {
  if (measurement < 10) {
    return '0' + String(measurement);
  } else {
    return String(measurement);
  }
}

function submitForm() {
  document.querySelector('.test-passage-form').submit();
}