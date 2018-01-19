package com.monkey.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.monkey.utils.SubStrUtil;
import com.monkey.utils.WebPushMessageType;

@ServerEndpoint(value = "/websocket")
public class Action {
	private Session session;
	private static boolean isClientRequestFirst = true;
	private static boolean isWebRequestFirst = true;
	private static Session serverSession;
	private static List<SessionBean> clientList = new ArrayList();

	@OnOpen
	public void open(Session session, EndpointConfig config) {
		this.session = session;
		System.out.println("open" + session.getId());
	}

	@OnMessage
	public void onMessage(Session session, String msg) {
		System.out.println("inMessage--" + msg);
		doTask(session, msg);
	}

	@OnError
	public void error(Throwable able) {
		System.out.println("end" + session.getId() + "/error:" + able.getMessage());
		for (int i = 0; i < clientList.size(); i++) {
			if (clientList.get(i).getId().equals(session.getId())) {
				clientList.remove(i);
			}
		}
	}

	@OnClose
	public void close() {
		System.out.println("close" + session.getId());
		for (int i = 0; i < clientList.size(); i++) {
			if (clientList.get(i).getId().equals(session.getId())) {
				clientList.remove(i);
			}
		}
		if (clientList != null) {
			System.out.println("close/当前设备：" + clientList.size());
		}
	}

	private void doTask(Session session, String msg) {
		try {
			if (msg.contains("web")) {
				System.out.println("web==isWebRequestFirst/" + isWebRequestFirst + "/isClientRequestFirst/" + isClientRequestFirst);
				if (isWebRequestFirst) {
					isWebRequestFirst = false;
					serverSession = session;
					if (!isClientRequestFirst) {
						if (clientList != null && clientList.size() > 0) {
							for (int i = 0; i < clientList.size(); i++) {
								if (session.isOpen()) {
									session.getBasicRemote().sendText("这是Android端的某个设备的接入SessionID/"
											+ clientList.get(i).getId() + "/你必须再推送的时候把sessionID带过来");
								}
							}
						}
					} else {
						if (session.isOpen()) {
							session.getBasicRemote().sendText("当前没有移动设备接入,请继续等待待命");
						}
					}
				} else {
					if (!isClientRequestFirst) {
						if (clientList != null && clientList.size() > 0) {
							for (int i = 0; i < clientList.size(); i++) {
								Session ss = clientList.get(i).getSess();
								String backMessage = WebPushMessageType.getMessage(msg);
								System.out.println("返回客户端的json数据:"+backMessage);
								ss.getBasicRemote().sendText(backMessage);
							}
						} else {
							System.out.println("客户端接入的集合是空的" + clientList);
						}
					} else {
						if (session.isOpen()) {
							session.getBasicRemote().sendText("当前没有移动设备接入,请继续等待待命");
						}
					}
				}
			} else if (msg.contains("mobile")) {
				System.out.println("mobile==isWebRequestFirst/" + isWebRequestFirst + "/isClientRequestFirst/" + isClientRequestFirst + "/" + clientList.size());
				if (clientList != null && clientList.size() <= 0) {
					SessionBean bean = new SessionBean();
					bean.setId(session.getId());
					bean.setSess(session);
					clientList.add(bean);
				}
				if (isClientRequestFirst) {
					isClientRequestFirst = false;
					if (session.isOpen()) {
						session.getBasicRemote().sendText("移动设备已注册/" + session.getId());
					}
					serverSession.getBasicRemote().sendText("success");
				} else {
					if (!isWebRequestFirst) {
						System.out.println("serverSession--" + serverSession);
						serverSession.getBasicRemote().sendText("这是来自移动设备的推送/" + msg);
					}else{
						System.out.println("web现在没有接入");
					}
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}