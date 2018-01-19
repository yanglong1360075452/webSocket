package com.monkey.utils;

import com.monkey.bean.Symbol;
import com.monkey.servlet.MessageLevel;
import com.monkey.servlet.PPT;
import com.monkey.servlet.PushMessage;
import com.monkey.servlet.Time;

public class SubStrUtil {
	public static PushMessage sub(String str) {
		if (str.length() <= 0) {
			return null;
		}
		if (str.contains("web")) {
			str = str.replace("web", "").trim();
		}
		int slashMark = str.indexOf(Symbol.SLASH_SYMBOL);
		int internetMark = str.indexOf(Symbol.INTERNET_SYMBOL);
		int andMark=str.indexOf(Symbol.AND_SYMBOL);
		int poundMark = str.indexOf(Symbol.POUND_SYMBOL);
		int asteriskMark = str.indexOf(Symbol.ASTERISK);
		int dollarMark = str.indexOf(Symbol.DOLLAR_SYMBOL);
		String one = str.substring(0, slashMark);

		String two = str.substring(slashMark + 1, internetMark);

		String three = str.substring(internetMark + 1, andMark);

		String four = str.substring(andMark + 1, poundMark);

		String five = str.substring(poundMark + 1, asteriskMark);

		String six = str.substring(asteriskMark + 1,dollarMark);
		
		String seven=str.substring(dollarMark+1,str.length());

		PushMessage msg = new PushMessage();
		Time time=new Time();
		time.setBeginTime(one);
		time.setEndTime(two);
		msg.setTime(time);
		MessageLevel level=new MessageLevel();
		level.setLevel(three);
		level.setMessage(four);
		msg.setMsgLevel(level);
		PPT ppt=new PPT();
		ppt.setTotalPage(Integer.valueOf(five));
		ppt.setCurrentPage(Integer.valueOf(six));
		msg.setPpt(ppt);
		msg.setPptContent(seven);
		return msg;
	}

//	public static void main(String[] args) {
//		PushMessage msg=sub();
//		System.out.println(msg.getTime().getBeginTime()+"/"+msg.getTime().getEndTime());
//		System.out.println(msg.getMsgLevel().getLevel()+"/"+msg.getMsgLevel().getMessage());
//		System.out.println(msg.getPpt().getCurrentPage()+"/"+msg.getPpt().getTotalPage());
		
//		PushMessage msg = new PushMessage();
//		Time time=new Time();
//		time.setBeginTime("00:00");
//		time.setEndTime("12:00");
//		msg.setTime(time);
//		
//		MessageLevel level=new MessageLevel();
//		level.setLevel("level");
//		level.setMessage("alert message");
//		msg.setMsgLevel(level);
//		
//		PPT ppt=new PPT();
//		ppt.setTotalPage(100);
//		ppt.setCurrentPage(20);
//		msg.setPpt(ppt);
//		
//		msg.setPptContent("content");
//		System.out.println(new Gson().toJson(msg));
//	}
}
