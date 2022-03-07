document.addEventListener('turbolinks:load', function(){
  let password = document.querySelector('.password-field')
  let passwordConfirmation = document.querySelector('.password-confirmation-field');
  console.log(passwordConfirmation.value);
  
  if (password && passwordConfirmation) {
    passwordConfirmation.addEventListener('input', highligthPasswordConfirmation)
  }
})

function highligthPasswordConfirmation() {
  let password = document.querySelector('.password-field')
  let passwordConfirmation = document.querySelector('.password-confirmation-field');
  console.log(password.value);
  console.log(passwordConfirmation.value);
  
  if (passwordConfirmation.classList.contains('highlite-red')) {
      passwordConfirmation.classList.remove('highlite-red');
  }
  if (passwordConfirmation.classList.contains('highlite-green')) {
      passwordConfirmation.classList.remove('highlite-green');
  }

  if (passwordConfirmation.value === '') {
    hideIcons();
    return;
  } else if (password.value === passwordConfirmation.value) {
      passwordConfirmation.classList.add('highlite-green');
      showRightIcon();
  } else {
      passwordConfirmation.classList.add('highlite-red');
      showWrongIcon();
  }
}

function showRightIcon() {
  if (document.querySelector('.octicon-right').classList.contains('hide')) {
    document.querySelector('.octicon-right').classList.remove('hide');
    document.querySelector('.octicon-wrong').classList.add('hide');   
  }
} 

function showWrongIcon() {
  if (document.querySelector('.octicon-wrong').classList.contains('hide')) {
    document.querySelector('.octicon-wrong').classList.remove('hide');
    document.querySelector('.octicon-right').classList.add('hide');   
  }
} 

function hideIcons() {
  document.querySelector('.octicon-wrong').classList.add('hide');
  document.querySelector('.octicon-right').classList.add('hide');  
}
