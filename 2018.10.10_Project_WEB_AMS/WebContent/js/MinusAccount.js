/**
 * 마이너스 계좌정보 추상화  
 */

function MinusAccount(number, owner, password, restMoney, borrowMoney) {
	// Account 상속 
	Account.call(this, number, owner, password, restMoney);
	this.borrowMoney = borrowMoney; 
}

MinusAccount.prototype = new Account('', '', 0, 0);


delete MinusAccount.prototype.number; 
delete MinusAccount.prototype.owner; 
delete MinusAccount.prototype.password; 
delete MinusAccount.prototype.restMoney; 

MinusAccount.prototype.constructor = MinusAccount; 

// getter, setter 기능 


MinusAccount.prototype.getBorrowMoney = function () {	
	return this.borrowMoney; 
}

MinusAccount.prototype.setBorrowMoney = function (borrowMoney) {	
	this.borrowMoney = borrowMoney; 
}

// 잔액조회 기능 (+ 대출금액 추가)
MinusAccount.prototype.getRestMoney = function () {
	return Account.prototype.getRestMoney.call(this) - this.getBorrowMoney();
}

// 결과표시 기능 (+ 대출금액 추가)
MinusAccount.prototype.toString = function () {
	Account.prototype.toString + "대출금액: " + this.getBorrowMoney();
	return ; 
}