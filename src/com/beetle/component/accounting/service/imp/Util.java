package com.beetle.component.accounting.service.imp;

import com.beetle.framework.AppProperties;
import com.beetle.framework.AppRuntimeException;
import com.beetle.framework.util.OtherUtil;

public class Util {
	/**
	 * 根据科目编码生成一个21位的账户号码<br>
	 * 格式：<br>
	 * 账户对应科目号（6位，不足补0）+机器码（3位，不足补0）+时间戳（13位）
	 * 
	 * @param subjectNo
	 * @return
	 */
	public static String generaterAccountNo(String subjectNo) {
		int l = subjectNo.length();
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < 6; i++) {
			if (i < l) {
				sb.append(subjectNo.charAt(i));
			} else {
				sb.append("0");
			}
		}
		String y = sb.toString();
		int c = AppProperties.getAsInt("resource_Application_Instance_No", 10000);
		if (c == 10000) {// 如果唯一instance的参数不配置，采取一个随机数，减少账户重复的概率，此时账户唯一性交给数据库系统来保证
			c = OtherUtil.randomInt(1, 1000);
		}
		if (c >= 1000) {
			c = 999;
		}
		String z = String.format("%03d", c);
		long x = System.currentTimeMillis();
		try {
			Thread.sleep(1);// 确保生成的时间戳唯一性
		} catch (InterruptedException e) {
			throw new AppRuntimeException(e);
		}
		return y + z + x;
	}

	// to test
	public static void main(String[] args) throws Throwable {
		for (int i = 0; i < 100; i++) {
			//System.out.println(OtherUtil.randomInt(1, 1000));
			 System.out.println(generaterAccountNo("224122"));
		}
	}
}
