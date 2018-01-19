package com.monkey.servlet;

public class PushMessage {
	private Time time;
	private MessageLevel msgLevel;
	private PPT ppt;
	private String pptContent;

	public Time getTime() {
		return time;
	}

	public void setTime(Time time) {
		this.time = time;
	}

	public MessageLevel getMsgLevel() {
		return msgLevel;
	}

	public void setMsgLevel(MessageLevel msgLevel) {
		this.msgLevel = msgLevel;
	}

	public PPT getPpt() {
		return ppt;
	}

	public void setPpt(PPT ppt) {
		this.ppt = ppt;
	}

	public String getPptContent() {
		return pptContent;
	}

	public void setPptContent(String pptContent) {
		this.pptContent = pptContent;
	}

}
