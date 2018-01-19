package com.monkey.servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.apache.commons.io.FilenameUtils;

import com.monkey.utils.POIUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import static java.awt.SystemColor.info;

/**
 * Servlet implementation class GetFilePathServlet
 */
@WebServlet("/GetFilePathServlet")
public class GetFilePathServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    File tmpDir = null;// 初始化上传文件的临时存放目录
    File saveDir = null;// 初始化上传文件后的保存目录

    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetFilePathServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // request.getRequestDispatcher("filepath.jsp").forward(request,
        // response);
        System.out.println(request);
        response.setContentType("text/html; charset=utf-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String[] str = null;
        List<String> lists = null;
        try {
            if (ServletFileUpload.isMultipartContent(request)) {
                DiskFileItemFactory dff = new DiskFileItemFactory();// 创建该对象
                dff.setRepository(tmpDir);// 指定上传文件的临时目录
                dff.setSizeThreshold(1024000);// 指定在内存中缓存数据大小,单位为byte
                ServletFileUpload sfu = new ServletFileUpload(dff);// 创建该对象
                sfu.setFileSizeMax(5000000);// 指定单个上传文件的最大尺寸
                sfu.setSizeMax(10000000);// 指定一次上传多个文件的总尺寸
                FileItemIterator fii = sfu.getItemIterator(request);// 解析request
                // 请求,并返回FileItemIterator集合
                while (fii.hasNext()) {
                    FileItemStream fis = fii.next();// 从集合中获得一个文件流
                    System.out.println("上传文件夹路径：" + fis.getName());
                    String file = fis.getName();
                    System.out.println(file.contains(".ppt"));
                    if (file.contains(".ppt") || !file.contains(".pptx")) {

                        if (!fis.isFormField() && fis.getName().length() > 0) {// 过滤掉表单中非文件域
                            String line = File.separator;
                            String fileName = "";
                            if (file.contains(line)) {
                                fileName = file.substring(file.lastIndexOf(File.separator), file.length());
                            } else {
                                fileName = line + file.substring(0, file.length());
                            }
                            BufferedInputStream in = new BufferedInputStream(fis.openStream());// 获得文件输入流
                            BufferedOutputStream out = new BufferedOutputStream(
                                    new FileOutputStream(new File(saveDir + fileName)));// 获得文件输出流
                            Streams.copy(in, out, true);// 开始把文件写到你指定的上传文件夹
                        /*	response.getWriter().println("文件上传成功");*/
                            String rootPath = saveDir + fileName;
                            System.out.println("存入磁盘路径：" + saveDir + fileName);
                            if (file.endsWith(".ppt")) {
							/*	 str = POIUtil.getPPTContent(rootPath);*/
                                lists = POIUtil.getPPTContent(rootPath);

                            } else if (file.endsWith(".pptx")) {
                                System.out.println("当前是pptx格式的");
                                str = POIUtil.get2007PPTContent(rootPath);
                                response.getWriter().println(str);

                            }

                        }
                    } else {
                        response.getWriter().println("请上传ppt或pptx格式的文档！");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
       /* response.getWriter().println(lists.toString());*/
       Gson gson=new Gson();
        response.getWriter().println(gson.toJson(lists).toString().getBytes("UTF-8"));
        System.out.print(gson.toJson(lists).toString());

        request.setAttribute("data",lists);

/*		request.getRequestDispatcher("/newIndex.jsp").forward(request, response);
		System.out.print("我是URI"+request.getRequestURI());
        System.out.print("我是URL"+request.getRequestURL());*/
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);

    }

    @Override
    public void init() throws ServletException {
        // TODO Auto-generated method stub
        super.init();

        String savePath = "\\pptsave";

        // tmpDir = new File(tmpPath);
        saveDir = new File(savePath);
        String path = saveDir.getAbsolutePath();
        saveDir = new File(path);

        // if (!tmpDir.isDirectory())
        // tmpDir.mkdir();
        if (!saveDir.isDirectory()) {
            saveDir.mkdir();
        }

    }
}
