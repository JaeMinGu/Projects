window.onload = function () {
	init();
	eventRegist();
}

function init() {
	accountManager  = new AccountManager();
	
	accountManager.add(new Account('1111-2222', '김예금', 1111, 0));
	accountManager.add(new Account('2222-3333', '나예금', 2222, 100));
	accountManager.add(new Account('3333-4444', '다예금', 3333, 1000));
	accountManager.add(new Account('4444-5555', '라예금', 4444, 10000));
	accountManager.add(new Account('5555-6666', '마예금', 5555, 100000));
	accountManager.add(new Account('6666-7777', '마예금', 5555, 100000));

	accountManager.add(new MinusAccount('9999-1111', '가대출', 5555, 100000, 10000));
	accountManager.add(new MinusAccount('9999-2222', '나대출', 7777, 11111, 1000));
	accountManager.add(new MinusAccount('9999-2222', '나대출', 7777, 11111, 1000));
}

function eventRegist() {
	//입출금 계좌 대출금액 비활성화
	document.getElementsByClassName('accountType')[0].onclick = function(){
        if (document.getElementsByClassName('accountType')[0].selectedIndex == 1){
           document.getElementById('inputBorrowMoneyTF').disabled = true;
        }else{
           document.getElementById('inputBorrowMoneyTF').disabled = false;
        }
     }
	
	
	
	// 신규등록 버튼 클릭 시 
	var registB = document.getElementById("registB");
	registB.onclick = function() {

		resetLabel();
		if (document.getElementsByClassName('accountType')[0].selectedIndex == 0) {
			document.getElementById("accountTypeMessage").innerHTML = '계좌종류를 선택하세요';
			return;
		}
		

		var number = document.getElementById("inputNumberTF").value; //계좌번호
		if (number == "") {
			document.getElementById("searchByNumberMessage").innerHTML = '계좌번호를 입력해주세요';
			return;

		}

		var password = document.getElementById("inputPasswordTF").value; //비밀번호
		if (password == "") {
			document.getElementById("deleteAccountMessage").innerHTML = '비밀번호를 입력해주세요';
			return;
		}

		var owner = document.getElementById("inputOwnerTF").value; //예금주명
		if (owner == "") {
			document.getElementById("searchByOwnerMessage").innerHTML = '예금주명을 입력해주세요';
			return;
		}

		var depositMoney = document.getElementById("inputDepositMoneyTF").value; //입금금액
		if (depositMoney == "") {
			document.getElementById("depositMoneyMessage").innerHTML = '입금금액을 입력해주세요';
			return;
		}
		
	
		if (document.getElementsByClassName('accountType')[0].selectedIndex == 2) {
			var borrowMoney = document.getElementById("inputBorrowMoneyTF");
			var message = accountManager.add(new MinusAccount(number, owner, password, depositMoney, borrowMoney));
			document.getElementById("searchByNumberMessage").innerHTML = message; 
			return;
			
		}else if(document.getElementsByClassName('accountType')[0].selectedIndex == 1){
			
		var message = accountManager.add(new Account(number, owner, password,depositMoney));
		resetLabel();
		document.getElementById("searchByNumberMessage").innerHTML = ""; 
		document.getElementById("registMessage").innerHTML = message; 
		
		return;
		}
		

		}

		// 전체조회 버튼 클릭 시 
		var listAllB = document.getElementById("listAllB");
		listAllB.onclick = function() {
			resetLabel();
			var accountList = accountManager.listAll();
			// 입출금 계좌 클릭 시 
			if(document.getElementsByClassName('accountType')[0].selectedIndex == 1){
				var output = [];
				for (var i = 0; i < accountList.length; i++) {
					if(!(accountList[i] instanceof MinusAccount)){//입출금 계좌
						output.push(accountList[i]);
					}
				}
					printList(output);
					return;
			// 마이너스 계좌 클릭 시 
			}else{
				var output = [];
				for (var i = 0; i < accountList.length; i++) {
					if(accountList[i] instanceof MinusAccount){
						output.push(accountList[i]);
					}
				}
					printList(output);
					return;
	        }
			printList(accountList);

		}

		// 계좌조회 버튼 클릭 시 
		var searchByNumberB = document.getElementById("searchByNumberB");
		searchByNumberB.onclick = function() {
			resetLabel();
			searchByNumber();
		}

		// 계좌조회 엔터 시 
		var target = document.getElementById("inputNumberTF");
		target.onkeyup = function(e) {
			resetLabel();
			var event = e || window.event;
			if (e.keyCode == 13) {
				searchByNumber();
			}
		}

		// 계좌삭제 버튼 클릭 시 
		var deleteB = document.getElementById("deleteB");
		deleteB.onclick = function() {
			resetLabel();
			deleteAccount();
		}

		// 계좌삭제 엔터 시 
		var target = document.getElementById("inputPasswordTF");
		target.onkeyup = function(e) {
			resetLabel();
			var event = e || window.event;
			if (e.keyCode == 13) {
				deleteAccount();
			}
		}

		// 계좌검색 버튼 클릭 시 
		var searchByOwnerB = document.getElementById("searchByOwnerB");
		searchByOwnerB.onclick = function() {
			resetLabel();
			searchByOwner();
		}

		// 계좌검색 엔터 시 
		var target = document.getElementById("inputOwnerTF");
		target.onkeyup = function(e) {
			resetLabel();
			var event = e || window.event;
			if (e.keyCode == 13) {
				searchByOwner();
			}
		}

	}

	//message 지우기 
	function resetLabel() {
		document.getElementById("accountTypeMessage").innerHTML = "";
		document.getElementById("searchByNumberMessage").innerHTML = "";
		document.getElementById("deleteAccountMessage").innerHTML = "";
		document.getElementById("searchByOwnerMessage").innerHTML = "";
		document.getElementById("depositMoneyMessage").innerHTML = "";
		document.getElementById("borrowMoneyMessage").innerHTML = "";
	}

	//계좌조회 
	function searchByNumber() {

		document.getElementById("inputNumberTF").onkeyup = function() {
			searchByNumberMessage.innerHTML = '';
		}
		var number = document.getElementById("inputNumberTF").value;
		printList(accountManager.getAccount(number));

		var searchByNumberMessage = document
				.getElementById("searchByNumberMessage");
		if (accountManager.getAccount(number).length == 0) {
			searchByNumberMessage.innerHTML = '해당 계좌가 존재하지 않습니다.';
		}
	}

	//계좌삭제
	function deleteAccount() {
		resetLabel();
		var number = document.getElementById("inputNumberTF").value;
		var searchByNumberMessage = document.getElementById("searchByNumberMessage");
		if (accountManager.getAccount(number).length == 0) {
			searchByNumberMessage.innerHTML = '해당 계좌가 존재하지 않습니다.';
		}
		var password = document.getElementById("inputPasswordTF").value;
		document.getElementById("deleteAccountMessage").innerHTML = accountManager.remove(number, password);
	}

	//계좌검색 
	function searchByOwner() {
		resetLabel();
		var owner = document.getElementById("inputOwnerTF").value;

		if (accountManager.searchAccount(owner).length == 0) {
			searchByOwnerMessage.innerHTML = '해당 계좌가 존재하지 않습니다.';
		}
		printList(accountManager.searchAccount(owner));
	}

	// 리스트 보여주기
	function printList(list) {

		document.getElementById("tbody").innerHTML = '';

		for (var i = 0; i < list.length; i++) {
			var str = '';

			if (i % 2 == 0) {
				str += '<tr class = "even">';
			} else {
				str += '<tr class = "odd">';
			}

			if (list[i] instanceof MinusAccount) {
				str += '<td>' + '[마이너스계좌]' + '</td>';
			} else {
				str += '<td>' + '[입출금 계좌]' + '</td>';
			}
			str += '<td>' + list[i].getNumber() + '</td>';
			str += '<td>' + list[i].getOwner() + '</td>';
			str += '<td>' + list[i].getRestMoney() + '</td>';
			if (list[i] instanceof MinusAccount) {
				str += '<td>' + list[i].getBorrowMoney() + '</td>';
			} else {
				str += '<td></td>'
			}

			str += '</tr>';
			document.getElementById("tbody").innerHTML += str;

		}
	}
	
	// 숫자만 입력 
	function numberOnly(event){
	      var char = String.fromCharCode(event.which);
	      if(!(/[0-9]/.test(char))){
	         event.preventDefault();
	      }
	   }