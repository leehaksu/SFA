package com.sfa.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sfa.repository.FileUploadDao;

@Service
public class FileUploadService {

	@Autowired
	private FileUploadDao fileUploadDao;

	private static final String SAVE_PATH = "/uploads/";
	private static final String PREFIX_URL = "/uploads/";

	public String restore(MultipartFile multipartFile,String id) {

		String url = null;

		try {
			if (multipartFile.isEmpty() == true) {
				return url;
			}
			File desti = new File(SAVE_PATH);
			
			if (!desti.exists()) {

				desti.mkdirs();

			}

			String originalFileName = multipartFile.getOriginalFilename();
			String extName = originalFileName.substring(originalFileName.lastIndexOf('.'), originalFileName.length());
			// Long fileSize = multipartFile.getSize();
			
			String saveFileName = genSaveFileName(extName,id);
			System.out.println();

			writeFile(multipartFile, saveFileName);

			url = PREFIX_URL + saveFileName;

		} catch (IOException e) {
			throw new RuntimeException(e);
		}

		return url;
	}

	private void writeFile(MultipartFile multipartFile, String saveFileName) throws IOException {

		byte[] fileData = multipartFile.getBytes();

		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);

		fos.write(fileData);
		fos.close();
	}

	private String genSaveFileName(String extName,String id) {
		String fileName = "";

		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += (calendar.get(Calendar.MONTH)+1);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName +="_"+id;
		fileName += extName;

		return fileName;
	}
	
	public String deleteFile(String fileName)
	{
		File file = new File(fileName);
		if(file.exists())
		{
			System.out.println("파일 있음");
		}else
		{
			System.out.println("파일없음");
		}
			
		return null;
	}
	

	public int insert(Long report_no, String url, String originalFileName) {
		// TODO Auto-generated method stub

		return fileUploadDao.insert(report_no, url, originalFileName);
	}

	public int delete(Long file_no) {
		// TODO Auto-generated method stub
		return fileUploadDao.delete(file_no);
	}

}
