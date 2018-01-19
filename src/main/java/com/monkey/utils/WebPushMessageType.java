package com.monkey.utils;

import com.google.gson.Gson;
import com.monkey.servlet.*;

public class WebPushMessageType {
	private static final String MARK_WEB = "web";
	private static final String MARK_TIME = "time";
	private static final String MARK_PPT = "ppt";
	private static final String MARK_CONTENT = "content";
	private static final String MARK_MESSAGE = "message";
	private static final String MARK_ALL = "all";

	/**
	 * @param msg
	 * @return
	 */
	public static String getMessage(String msg) {
		if (msg == null && msg.length() <= 0) {
			return null;
		}
		String mark = msg.substring(0, msg.indexOf(":"));
		System.out.println(mark);
		if (mark.equals(MARK_WEB)) {
			Gson gson = new Gson();
			String msgType = msg.substring(msg.indexOf(":") + 1, msg.indexOf("+"));
			if (msgType.equals(MARK_TIME)) {
				String[] str = msg.substring(msg.indexOf("+") + 1, msg.length()).split("/");
				Time time = new Time();
				time.setBeginTime(str[0]);
				time.setEndTime(str[1]);
				return "time:" + gson.toJson(time);
			} else if (msgType.equals(MARK_PPT)) {
				String[] str = msg.substring(msg.indexOf("+") + 1, msg.length()).split("/");
				PPT ppt = new PPT();
				ppt.setTotalPage(Integer.valueOf(str[0]));
				ppt.setCurrentPage(Integer.valueOf(str[1]));
				return "ppt:" + gson.toJson(ppt);
			} else if (msgType.equals(MARK_CONTENT)) {
				String str = msg.substring(msg.indexOf("+") + 1, msg.length());
				Content content = new Content();
				content.setContent(str);
				return "content:" + gson.toJson(content);
			} else if (msgType.equals(MARK_MESSAGE)) {
				String[] str = msg.substring(msg.indexOf("+") + 1, msg.length()).split("/");
				MessageLevel level = new MessageLevel();
				level.setLevel(str[0]);
				level.setMessage(str[1]);
				return "messageLevel:" + gson.toJson(level);
			} else if (msgType.equals(MARK_ALL)) {
				String str = msg.substring(msg.indexOf("+") + 1, msg.length());
				PushMessage pushMessage = SubStrUtil.sub(str);
				return "all:" + gson.toJson(pushMessage);
			}
		}
		return msg;
	}

	public static Object getMessageDetails(String msg) {
		String messageType = msg.substring(0, msg.indexOf(":{"));
		String json = msg.substring(msg.indexOf(":") + 1, msg.length());
		Gson gson = new Gson();
		if (messageType.equals(MARK_TIME)) {
			return gson.fromJson(json, Time.class);
		} else if (messageType.equals(MARK_PPT)) {
			return gson.fromJson(json, PPT.class);
		} else if (messageType.equals(MARK_CONTENT)) {
			return gson.fromJson(json, Content.class);
		} else if (messageType.equals(MARK_MESSAGE)) {
			return gson.fromJson(json, MessageLevel.class);
		} else if (messageType.equals(MARK_ALL)) {
			return gson.fromJson(json, PushMessage.class);
		}
		return null;
	}

	public static Object getClass(Object o) {
			if (o == null) {
				return null;
			}
			String className = o.getClass().getSimpleName();
			if (className.equals(PPT.class.getSimpleName())) {
				return PPT.class;
			} else if (className.equals(Time.class.getSimpleName())) {
				return Time.class;
			} else if (className.equals(Content.class.getSimpleName())) {
				return Content.class;
			} else if (className.equals(MessageLevel.class.getSimpleName())) {
				return MessageLevel.class;
			} else if (className.equals(PushMessage.class.getSimpleName())) {
				return PushMessage.class;
			}
		return null;
	}

	public static void main(String[] args) {
		Object o = getMessageDetails("ppt:{\"totalPage\":23,\"currentPage\":10}");
		System.out.println(o.getClass().getSimpleName());
	}
}