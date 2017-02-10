package test;

import com.beetle.component.accounting.dto.Account;
import com.beetle.component.accounting.dto.Subject;
import com.beetle.component.accounting.dto.TallyRequest;
import com.beetle.component.accounting.dto.TallyResponse;
import com.beetle.component.accounting.dto.enums.DirectFlag;
import com.beetle.component.accounting.dto.enums.PasswordCheck;
import com.beetle.component.accounting.dto.enums.SubjectType;
import com.beetle.component.accounting.service.AccountService;
import com.beetle.component.accounting.service.AccountingServiceException;
import com.beetle.component.accounting.service.SubjectService;
import com.beetle.framework.resource.dic.DIContainer;

public class Client {
	public static void main(String[] args) throws Throwable {
		congZhi();
		//openPlatformAccount();
		//openPersonAccount1();
		// openPersonAccount2();
	}

	public static void congZhi() {
		AccountService as = DIContainer.getInstance().retrieve(AccountService.class);
		TallyRequest req = new TallyRequest();
		req.setAmount(20000l);
		req.setOrderNo("ORDER000000000001");//业务系统的订单号
		req.setDrPasswordCheck(false);
		req.setDrAccountNo("1001011421486701113573");
		req.setCrAccountNo("2241009981486700756248");
		TallyResponse res;
		try {
			res = as.tally(req);
			System.out.println(res);
		} catch (AccountingServiceException e) {
			System.out.println("code:" + e.getErrCode());
			System.out.println("msg:" + e.getMessage());
			e.printStackTrace();
		}
	}

	public static void mainPersonTransfer(String[] args) {
		AccountService as = DIContainer.getInstance().retrieve(AccountService.class);
		TallyRequest req = new TallyRequest();
		req.setAmount(501l);
		req.setOrderNo("ORDER8000000103");
		req.setCrAccountNo("8B4FB8803BF34AFE852192970ED8E6C3");
		req.setDrPasswordCheck(true);
		req.setDrAccountPassword("888888");
		req.setDrAccountNo("2B71ED871756400EAE6E51D2C8941F89");
		TallyResponse res;
		try {
			res = as.tally(req);
			System.out.println(res);
		} catch (AccountingServiceException e) {
			System.out.println("code:" + e.getErrCode());
			System.out.println("msg:" + e.getMessage());
			e.printStackTrace();
		}

	}

	// 开一个平台公共存款账户
	public static void openPlatformAccount() throws AccountingServiceException {
		AccountService as = DIContainer.getInstance().retrieve(AccountService.class);
		Account account = new Account();
		account.setAccountName("平台资金");
		account.setMemberNo("99999999999999");
		account.setPassword("");
		account.setPasswordCheck(PasswordCheck.NOT_NEED.toInteger());
		account.setSubjectNo("100101");
		account.setSubjectDirect(DirectFlag.DR.toString());
		as.openAccount(account);
	}

	// 开一个普通个人资金账户
	public static void openPersonAccount1() throws AccountingServiceException {
		AccountService as = DIContainer.getInstance().retrieve(AccountService.class);
		Account account = new Account();
		account.setAccountName("个人会员投资账户");
		account.setMemberNo("100000000001");
		account.setPassword("888888");
		account.setPasswordCheck(PasswordCheck.NEED.toInteger());
		account.setSubjectNo("2241");
		account.setSubjectDirect(DirectFlag.CR.toString());
		as.openAccount(account);
	}

	public static void openPersonAccount2() throws AccountingServiceException {
		AccountService as = DIContainer.getInstance().retrieve(AccountService.class);
		Account account = new Account();
		account.setAccountName("个人会员投资账户");
		account.setMemberNo("100000000002");
		account.setPassword("999999");
		account.setPasswordCheck(PasswordCheck.NEED.toInteger());
		account.setSubjectNo("201202");
		account.setSubjectDirect(DirectFlag.CR.toString());
		as.openAccount(account);
	}

	public static void main2(String[] args) {
		SubjectService ss = DIContainer.getInstance().retrieve(SubjectService.class);
		Subject subject = new Subject();
		subject.setSubjectType(SubjectType.ASSETS.toInteger());
		subject.setSubjectDirect(DirectFlag.DR.toString());
		subject.setSubjectName("清算银行存款");
		subject.setSubjectNo("1002");
		try {
			ss.createSubject(subject);
		} catch (AccountingServiceException e) {
			e.printStackTrace();
		}
	}

	public static void main1111(String[] args) {
		SubjectService ss = DIContainer.getInstance().retrieve(SubjectService.class);
		Subject subject = new Subject();
		subject.setSubjectType(SubjectType.ASSETS.toInteger());
		subject.setSubjectDirect(DirectFlag.DR.toString());
		subject.setSubjectName("平台资金");
		subject.setSubjectNo("100101");
		subject.setRemark("平台资金-客户");
		try {
			ss.createSubject(subject);
		} catch (AccountingServiceException e) {
			e.printStackTrace();
		}
	}

}
