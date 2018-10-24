/**
 * 효율적인 계좌관리를 위한 AccountManager
 */
function AccountManager() {
	this.accounts = [];
}


// 계좌번호 순서대로 오름차순
AccountManager.prototype.sort = function (account1, account2) {
	return account1.getNumber() - account2.getNumber(); 
}

// 계좌개설
AccountManager.prototype.add = function (account) {
	var message; 
	for ( var key in this.accounts) {
		if(this.accounts[key].getNumber() == account.getNumber()){
			message = '이미 존재하는 계좌입니다.';
			return message; 
		}
		
	}
	this.accounts.push(account);
	message = '계좌가 성공적으로 개설되었습니다.';
	return message; 
}

// 전체계좌 반환
AccountManager.prototype.listAll = function () {
	return this.accounts; 
}

// 계좌번호를 활용한 계좌조회
AccountManager.prototype.getAccount = function (number) {
	var accountList = [];
	for ( var key in this.accounts) {
		if (this.accounts[key].getNumber() == number) {
			accountList.push(this.accounts[key]);
			return accountList;
		}
	}
	return accountList;
}

// 예금주를 활용한 계좌조회
AccountManager.prototype.searchAccount = function (owner) {
	var accountResult = [];
	for ( var key in this.accounts) {
		if(this.accounts[key].getOwner() == owner ){
			accountResult.push(this.accounts[key]);
		} 
	}
	return accountResult;
	
}

// 계좌번호를 활용한 계좌삭제
AccountManager.prototype.remove = function (number, password) {
	var message; 
	for ( var key in this.accounts) {
		if (this.accounts[key].getNumber() == number && this.accounts[key].getPassword() == password) {
			this.accounts.splice(key, 1);
			message = '해당 계좌가 삭제 되었습니다.';
			return message; 
		}
	}
	message = '비밀번호를 확인해주세요.';
	return message; 
}






