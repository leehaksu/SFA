package com.sfa.repository;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FileUploadDao {
	
	@Autowired
	private SqlSession sqlSession;

	public int insert(Long report_no, String url, String originalFileName) {
		// TODO Auto-generated method stub
		 HashMap<String,Object> map = new HashMap<String,Object>();
		 map.put("report_no", report_no);
		 map.put("url", url);
		 map.put("originalFileName", originalFileName);
		return sqlSession.insert("fileupload.insert",map);
	}

	public int delete(Long file_no) {
		// TODO Auto-generated method stub

		 HashMap<String,Object> map = new HashMap<String,Object>();
		 map.put("file_no", file_no);
		return sqlSession.delete("fileupload.delete",map);
	}

}
