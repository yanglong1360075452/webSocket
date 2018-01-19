package com.monkey.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.monkey.utils.GetIp;

/**
 * Servlet implementation class GetIPServlet
 */
@WebServlet("/GetIPServlet")
public class GetIPServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public GetIPServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		String address = null;
		try {
			address = GetIp.getLocalHostLANAddress().getHostAddress();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("��ȡip��ַʧ��");
		}
		if (address != null && address.length() > 0) {
			StringBuffer sb = new StringBuffer();
			sb.append("http://");
			sb.append(address);
			sb.append(":8080/webSocket/websocket");
			response.getWriter().write(sb.toString());
		} else {
			response.getWriter().write("ɨ��ʧ��,������");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
