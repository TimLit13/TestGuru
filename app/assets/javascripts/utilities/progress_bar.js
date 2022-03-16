document.addEventListener('turbolinks:load', function() {
  let progressBar = document.querySelector('#progress-bar');
  console.log('lalфывафывафвыафывафвыаala');

  if (progressBar) {
    displayProgressBar(progressBar);
  } 
})

function displayProgressBar(progressBar) {
  let progressValue = progressBar.dataset.progress;
  console.log(progressValue);
  console.log('lalala');

  progressBar.setAttribute('role', "progressbar");
  progressBar.setAttribute('aria-valuemin', '0 %');
  progressBar.setAttribute('aria-valuemin', '100 %');
  progressBar.setAttribute('aria-valuenow', progressValue);
  progressBar.style.width = progressValue + '%';
  progressBar.textContent = progressValue + '%';
}