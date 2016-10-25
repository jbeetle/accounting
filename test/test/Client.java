package test;

import com.beetle.component.accounting.dto.Account;
import com.beetle.component.accounting.dto.Subject;
import com.beetle.component.accounting.dto.TallyRequest;
import com.beetle.component.accounting.dto.TallyResponse;
import com.beetle.component.accounting.dto.enums.AccountType;
import com.beetle.component.accounting.dto.enums.DirectFlag;
import com.beetle.component.accounting.dto.enums.PasswordCheck;
import com.beetle.component.accounting.dto.enums.SubjectType;
import com.beetle.component.accounting.service.AccountService;
import com.beetle.component.accounting.service.AccountingServiceException;
import com.beetle.component.accounting.service.SubjectService;
import com.beetle.framework.resource.dic.DIContainer;

public class Client {
	public static void main(String[] args) {
		mainCongZhi(args);
	}

	public static void mainCongZhi(String[] args) {
		AccountService as = DIContainer.getInstance().retrieve(AccountService.class);
		TallyRequest req = new TallyRequest();
		req.setAmount(5000l);
		req.setOrderNo("ORDER8000000345");
		req.setDrPasswordCheck(false);
		req.setDrAccountNo("0C6F1C26BF6343F9A9A26C9CA860C89D");
		req.setCrAccountNo("8B4FB8803BF34AFE852192970ED8E6C3");
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

	public static void main3(String[] args) throws AccountingServiceException {
		AccountService as = DIContainer.getInstance().retrieve(AccountService.class);
		Account account = new Account();
		account.setAccountName("平台清算银行存款账户");
		account.setAccountType(AccountType.SUB_ACC.toInteger());
		account.setMemberNo("90000000000000009");
		account.setPassword("");
		account.setPasswordCheck(PasswordCheck.NOT_NEED.toInteger());
		account.setSubjectNo("1002");
		account.setSubjectDirect(DirectFlag.DR.toString());
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

	public static void main1(String[] args) {
		SubjectService ss = DIContainer.getInstance().retrieve(SubjectService.class);
		Subject subject = new Subject();
		subject.setSubjectType(SubjectType.LIABILITY.toInteger());
		subject.setSubjectDirect(DirectFlag.CR.toString());
		subject.setSubjectName("个人会员资金");
		subject.setSubjectNo("201202");
		subject.setRemark("会员账号-个人会员资金-人民币");
		try {
			ss.createSubject(subject);
		} catch (AccountingServiceException e) {
			e.printStackTrace();
		}
	}

}
