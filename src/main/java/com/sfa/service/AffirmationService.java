package com.sfa.service;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfa.repository.AffirmationDao;
import com.sfa.vo.AffirmationVo;

@Service
public class AffirmationService {

	@Autowired
	AffirmationDao affirmationDao;

	public String select() {
		Random random = new Random();
		List<AffirmationVo> list = affirmationDao.select();
		System.out.println(list.size());
		
		int number = 0;
		do {
			number = random.nextInt(list.size());
			System.out.println(number);
		}while(number==0);
				
		System.out.println("Affirmation number="+number);
		String affirmationContent = list.get(number).getContent();
		
		return affirmationContent;

	}

}
