package com.monkey.servlet;

import javax.websocket.Session;
import java.io.Serializable;

public class SessionBean implements Serializable{
	private String id;
	private Session sess;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Session getSess() {
		return sess;
	}
	public void setSess(Session sess) {
		this.sess = sess;
	}
	
}
