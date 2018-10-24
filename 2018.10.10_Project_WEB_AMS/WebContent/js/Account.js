/**
 * 계좌정보 추상화
 */

/* 사용자 정의 객체(생성자) */
function Account(number, owner, password, restMoney) {
	this.number = number; 
	this.owner = owner; 
	this.password = password; 
	this.restMoney = restMoney; 
}

Account.bankName = 'KOSTA 은행';


/*프로토타입에 메소드 저장해 공유*/
// getter, setter 기능
Account.prototype.getNumber = function () {
	return this.number;
}

Account.prototype.setNumber = function (number) {
	this.number = number;
}

Account.prototype.getOwner = function () {
	return this.owner;
}

Account.prototype.setOwner = function (owner) {
	this.owner = owner;
}

Account.prototype.getPassword = function () {
	return this.password;
}

Account.prototype.setPassword = function (password) {
	this.password = password;
}

Account.prototype.setRestMoney = function (restMoney) {
	this.restMoney = restMoney;
}

// 예금 기능 
Account.prototype.deposit = function (money) {
	if(money <= 0){
		window.alert('0보다 적은 금액은 입금할 수 없습니다.');
	}
	return this.restMoney += money;
}

// 출금 기능 
Account.prototype.withdraw = function (money) {
	if(money <= 0){
		window.alert('0보다 적은 금액은 출금할 수 없습니다.');
	}
	if(money > this.getrestMoney()){
		window.alert('잔액이 부족합니다.');
	}
	return this.restMoney -= money;
}

// 잔액조회 기능
Account.prototype.getRestMoney = function () {
	return this.restMoney;
}

// 비밀번호확인 기능 
Account.prototype.checkPassword = function (password) {
	return (this.password == password);
}

// 결과표시 기능 
Account.prototype.toString = function () {
	return "계좌번호: " + this.number + ", 예금주: " + this.owner + ", 비밀번호: " + this.password + ",잔액: " + this.restMoney;
}