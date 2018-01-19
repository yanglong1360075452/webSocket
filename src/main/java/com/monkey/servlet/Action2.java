package com.monkey.servlet;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by HP on 2017/11/20.
 */
@ServerEndpoint(value = "/websocket2")
public class Action2 {
    private static List<SessionBean> sessionWebList = new ArrayList<SessionBean>();
    private static List<SessionBean> sessionGlassList = new ArrayList<SessionBean>();
    private Session session;

    @OnOpen
    public void open(Session session, EndpointConfig config) {
        this.session = session;
        System.out.println("open  --   当前session接入为：" + session.getId());
    }

    @OnMessage
    public void onMessage(String msg, Session session) {
        System.out.println("onMessage  --  当前session接入为：" + session.getId() + "\n接收到的消息为：" + msg);
        if (msg.contains("web")) {//如果web端接入的话 存入list里
            SessionBean bean = new SessionBean();
            bean.setId(session.getId());
            bean.setSess(session);
            sessionWebList.add(bean);
        } else if (msg.contains("mobile")) {//如果是moblie接入的话 存放入glasslist里面
            SessionBean bean2 = new SessionBean();
            bean2.setId(session.getId());
            bean2.setSess(session);
            sessionGlassList.add(bean2);
        }
        doTask(session);
    }

    //网络出错出发
    @OnError
    public void error(Throwable able) {
        System.out.println("error  --  错误为：" + able.getMessage());
    }

    //连接关闭出发
    @OnClose
    public void close(Session session) {
        System.out.println("close  --  当前关闭的session：" + session.getId());
        if (session != null) {
            String id = session.getId();
            if (sessionWebList.contains(id)) {//在session关闭的时候  remove存储的session实例
                for (int i = 0; i < sessionWebList.size(); i++) {
                    sessionWebList.remove(sessionWebList.get(i));
                }
            }
            if (sessionGlassList.contains(id)) {
                for (int i = 0; i < sessionGlassList.size(); i++) {
                    sessionGlassList.remove(sessionGlassList.get(i));
                }
            }
        }
    }

    private void doTask(Session session) {
        System.out.println("doTask  --  当前session：" + session.getId());
        /**
         * 因为设备端比web端后接入
         * 所以判断一下 就可以从list里面获取实例收发消息了
         */
        try {
            System.out.println("doTask  --  当前sessionGlassList size：" + sessionGlassList.size());
            System.out.println("doTask  --  当前sessionWebList size：" + sessionWebList.size());
            if (sessionGlassList != null && sessionGlassList.size() > 0) {
                for (int i = 0; i <sessionWebList.size() ; i++) {
                    sessionWebList.get(i).getSess().getBasicRemote().sendText("success");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
