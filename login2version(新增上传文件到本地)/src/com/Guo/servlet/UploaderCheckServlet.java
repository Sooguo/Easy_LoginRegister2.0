package com.Guo.servlet;

import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UploaderCheckServlet extends HttpServlet {
	/**
	 * 
	 */
	// 上传文件存储目录
	private static final long serialVersionUID = 1L;
	/* private String serverPath = "F:/uploader"; */

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("mergeChunks".equals(action)) {
			System.out.println("开始合并文件...");
			// 合并文件
			String fileMd5 = request.getParameter("fileMd5");
			String fileName = request.getParameter("fileName");

			System.out.println("上传文件的名称是: " + fileName + "\n");

			// 处理获取到的上传文件的文件名的路径部分，只保留文件名部分
			String filename1 = fileName.substring(fileName.lastIndexOf("\\") + 1);

			// 得到上传文件的扩展名
			String fileExtName = filename1.substring(filename1.lastIndexOf(".") + 1);

			// 如果需要限制上传的文件类型，那么可以通过文件的扩展名来判断上传的文件类型是否合法
			System.out.println("上传的文件的扩展名是：" + fileExtName + '\n');

			String serverPath = getServletContext().getRealPath("") + "loader2";
			// 文件的存储目录
			String storage = getServletContext().getRealPath("") + "loader2\\" + filename1 + "\n";
			System.out.println("上传的文件的存储目录为：" + storage + '\n');
			// 读取目录里面的所有文件
			File f = new File(serverPath + "/" + fileMd5);
			File[] fileArray = f.listFiles(new FileFilter() {
				// 排除目录，只要文件
				public boolean accept(File pathname) {
					if (pathname.isDirectory()) {
						return false;
					}
					return true;
				}
			});

			// 转成集合，便于排序
			List<File> fileList = new ArrayList<File>(Arrays.asList(fileArray));

			// 从小到大排序
			Collections.sort(fileList, new Comparator<File>() {
				public int compare(File o1, File o2) {
					if (Integer.parseInt(o1.getName()) < Integer.parseInt(o2.getName())) {
						return -1;
					}
					return 1;
				}
			});

			// 将路径输出到默认路径的的文本文件中
			File file1 = new File(getServletContext().getRealPath("") + "loader2\\" + filename1 + ".Directory.txt");
			// 创建文件
			file1.createNewFile();
			FileWriter writer = new FileWriter(file1);
			// 向文件写入内容
			writer.write(storage);
			writer.flush();
			writer.close();

			File outputFile = new File(serverPath + "/" + fileName);
			// 创建文件
			outputFile.createNewFile();
			// 输出流
			@SuppressWarnings("resource")
			FileChannel outChannel = new FileOutputStream(outputFile).getChannel();
			// 合并
			FileChannel inChannel;
			for (File file : fileList) {
				inChannel = new FileInputStream(file).getChannel();
				inChannel.transferTo(0, inChannel.size(), outChannel);
				inChannel.close();
				// 删除分片
				file.delete();
			}
			// 清除文件夹
			File tempFile = new File(serverPath + "/" + fileMd5);
			if (tempFile.isDirectory() && tempFile.exists()) {
				tempFile.delete();
			}
			// 关闭流
			outChannel.close();
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().write("{\"msg\":\"上传成功\"}");
		} else if ("checkChunk".equals(action)) {
			System.out.println("检查分块...");
			String fileMd5 = request.getParameter("fileMd5");
			String chunk = request.getParameter("chunk");
			String chunkSize = request.getParameter("chunkSize");

			String serverPath = getServletContext().getRealPath("") + "loader2";
			File checkFile = new File(serverPath + "/" + fileMd5 + "/" + chunk);
			response.setContentType("text/html;charset=utf-8");
			// 检查文件是否存在，且大小是否一致
			if (checkFile.exists() && checkFile.length() == Integer.parseInt(chunkSize)) {
				response.getWriter().write("{\"ifExist\":1}");
			} else {
				response.getWriter().write("{\"ifExist\":0}");
			}

		}
	}

}
