document.addEventListener('turbolinks:load', function(){
  // переменной присваиваем элемент DOM 
  var control = document.querySelector('.sort-by-title')

  if (control) {control.addEventListener('click', sortRowsByTitle)
  } 
})

function sortRowsByTitle() {
  var table = document.querySelector('table')

  // создаст коллекцию NodeList, не Array
  var rows = table.querySelectorAll('tr')

  // alert(rows.length)

  var sortedRows = []

  for(var i = 1; i < rows.length; i++) {
    sortedRows.push(rows[i])
  }

  if (this.querySelector('.octicon-arrow-up').classList.contains('hide')) {
    sortedRows.sort(compareRowsAsc)
    this.querySelector('.octicon-arrow-up').classList.remove('hide')
    this.querySelector('.octicon-arrow-down').classList.add('hide')   
  } else {
    sortedRows.sort(compareRowsDesc)
    this.querySelector('.octicon-arrow-up').classList.add('hide')
    this.querySelector('.octicon-arrow-down').classList.remove('hide')   
  }
  

  var sortedTable = document.createElement('table')
  sortedTable.classList.add('table')
  sortedTable.classList.add('table-striped')
  sortedTable.classList.add('mt-5')
  var thead = document.createElement('thead')
  sortedTable.appendChild(thead)
  thead.appendChild(rows[0])

  var tbody = document.createElement('tbody')
  sortedTable.appendChild(tbody)
  for(var i = 0; i < sortedRows.length; i++) {
    tbody.appendChild(sortedRows[i])
  }

  table.parentNode.replaceChild(sortedTable, table)
}

function compareRowsAsc(row1, row2){
  var testTitle1 = row1.querySelector('td').textContent.toLowerCase()
  var testTitle2 = row2.querySelector('td').textContent.toLowerCase()

  if (testTitle1 < testTitle2) { return -1 }
  if (testTitle1 > testTitle2) { return 1 }
  return 0
}

function compareRowsDesc(row1, row2){
  var testTitle1 = row1.querySelector('td').textContent.toLowerCase()
  var testTitle2 = row2.querySelector('td').textContent.toLowerCase()

  if (testTitle1 < testTitle2) { return 1 }
  if (testTitle1 > testTitle2) { return -1 }
  return 0
}