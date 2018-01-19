package com.monkey.utils;




import org.apache.poi.hslf.usermodel.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class POIUtil {
	public static String[] get2007PPTContent(String filepath) {
	/*	String [] stringArray=new String[2];
		InputStream is = null;
		XMLSlideShow slide = null;
		String str="";
		try {
			is = new FileInputStream(filepath);
			slide = new XMLSlideShow(is);
			StringBuffer sb1=new StringBuffer();
			XSLFPowerPointExtractor extractor=new XSLFPowerPointExtractor(slide);
			str=extractor.getText();
			if(str.contains("\n")){
				str=str.replaceAll("\n", ";");
				int index=0;
				String[] array=str.split(";;");
				for (String string : array) {
					index++;
					sb1.append("di"+index+"tiao");
					sb1.append(string);
					sb1.append("/");
				}
				if(str.contains(";")){
					str=sb1.toString().replace(";", "");
					stringArray[0]=str;
				}
			}
			System.out.println(sb1.toString());
			extractor.close();


			StringBuffer sb2=new StringBuffer();
			int index=0;
*//*			List<XSLFSlide> xslf=slide.getSlides();
			for (XSLFSlide xslfSlide : xslf) {

				XSLFNotes note=xslfSlide.getNotes();
				List<List<XSLFTextParagraph>> xslfList=note.getTextParagraphs();
				for (List<XSLFTextParagraph> list : xslfList) {
					for (XSLFTextParagraph xslfTextParagraph : list) {
						index++;
						sb2.append("第"+index+"条:");
						sb2.append(xslfTextParagraph.getText());
						sb2.append("/");
					}
				}
			}*//*
			stringArray[1]=sb2.toString();
			System.out.println(sb2.toString());
		} catch (FileNotFoundException e) {
			System.out.println("没有找到指定路径");
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println("getTextFromPPT2007 IO错误");
			e.printStackTrace();
		}
		return stringArray;*/
		return null;
	}

	public static List<String> getPPTContent(String filePath) {
		String[] str = new String[2];
		List<String> list1=new ArrayList();
		try {
			File file = new File(filePath);
			FileInputStream fis = new FileInputStream(file);
			HSLFSlideShow ppt = new HSLFSlideShow(new HSLFSlideShowImpl(fis));
			/*List<HSLFSlide> slides = ppt.getSlides();*/
/*			StringBuffer sb1 = new StringBuffer();
			sb1.append("内容：");
			int index = 0;
			for (HSLFSlide hslfSlide : slides) {
				List<List<HSLFTextParagraph>> paragraph = hslfSlide.getTextParagraphs();
				for (List<HSLFTextParagraph> list : paragraph) {
					List<HSLFTextRun> run = list.get(0).getTextRuns();
					for (HSLFTextRun hslfTextRun : run) {
						String raw = hslfTextRun.getRawText();
						if (raw.length() > 0) {
							index++;
							sb1.append(index + "-");
							sb1.append(raw);
							sb1.append(";");
						}
					}
				}
			}
			str[0] = sb1.toString();
			System.out.println(sb1.toString());*/

			StringBuffer sb = new StringBuffer();


			sb.append("备注：");
			int index2 = 0;
			List<HSLFNotes> notes = ppt.getNotes();
			for (HSLFNotes hslfNotes : notes) {
				List<List<HSLFTextParagraph>> paragraph = hslfNotes.getTextParagraphs();
				for (List<HSLFTextParagraph> list : paragraph) {
					for (HSLFTextParagraph hslfTextParagraph : list) {
						List<HSLFTextRun> run = hslfTextParagraph.getTextRuns();
						for (HSLFTextRun hslfTextRun : run) {
						/*	index2++;*/
							String raw = hslfTextRun.getRawText();
				/*			sb.append(index2 + "-");
							sb.append(raw);
							sb.append("/");*/

							list1.add(raw);

						}
					}
				}
			}
			str[1] = sb.toString();
			System.out.println(list1.toString());
			// PowerPointExtractor ppt1=new PowerPointExtractor(fis);
			// System.out.println("notes:"+ppt1.getNotes());
			// System.out.println("text:"+ppt1.getText());

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list1;
		/*return list1;*/
	}
}
