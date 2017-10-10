package com.sfa.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.StringTokenizer;

import org.springframework.stereotype.Component;

import com.sfa.vo.WeekVo;
//날짜 변경
@Component
public class ChangeDate {
	
	//주간 계획 번호 알아오는 메소드
	public String getWeekNo(ArrayList<Integer> date) {
		int week_no;//주간계획 번호
		String temp_week_no;//임시 주간계획 번호
		// 그 달의 1일 날짜는 임시 저장
		String temp_date = String.valueOf(date.get(0)) + "0" + String.valueOf(date.get(1)) + "01";
		//1일 날짜의 요일 을 체크
		String one_day = calDay(checkDay(temp_date));
		
		//1일의 요일이 목,금,토,일 일 경우에는 week_no가 0부터 시작
		if ("목".equals(one_day) || "금".equals(one_day) || "토".equals(one_day) || "일".equals(one_day)) {
			week_no = getWeek(date) - 1;
		} else {
			//1일의 요일이 월,화,수일 경우에는 week_no가 1부터 시작
			week_no = getWeek(date);
		}
		//week_no가 0일경우에는 그 전달의 5주차로 변경
		if (week_no == 0) {
			week_no = 5;
			date.set(1, date.get(1) - 1);

		}
		//week_no를 int->String으로 변환
		if (date.get(1) > 9) {
			 //월이 10월 이상일 경우에는 일에만 0을 붙여준다.
			temp_week_no = String.valueOf(date.get(0)) + String.valueOf(date.get(1) + "0" + week_no);
		} else {
			//월이 10월 이하일 경우에는 월,일에 0을 붙여준다.
			temp_week_no = String.valueOf(date.get(0)) + String.valueOf("0" + date.get(1) + "0" + week_no);
		}
	
		return temp_week_no;
	}
	//월,화,수,목,금 날짜를 구한다.
	public static String[] five_date(String date) {
		String[] array_list = new String[5];
		Calendar cal = Calendar.getInstance();
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date nDate = null;
		try {
			nDate = dateFormat.parse(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		cal.setTime(nDate);
		System.out.println("들어왔다");
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		cal.add(Calendar.DATE, -1);
		for (int i = 0; i < 5; i++) {
			cal.add(Calendar.DATE, +1);
			String str = formatter.format(cal.getTime());
			System.out.println(str);
			array_list[i] = str;
		}

		return array_list;
	}
	//날짜를 기반으로 요일을 확인한다.
	public static Calendar checkDay(String date) {

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		Date nDate = null;
		try {
			nDate = dateFormat.parse(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Calendar cal = Calendar.getInstance();
		cal.setTime(nDate);
		return cal;
	}

	public String calDay(Calendar cal) {
		String day = "";
		System.out.println("cal" + cal.get(Calendar.DAY_OF_WEEK));
		int dayNum = cal.get(Calendar.DAY_OF_WEEK);
		System.out.println("[dayNum]" + dayNum);
		switch (dayNum) {
		case 1:
			day = "일";
			break;
		case 2:
			day = "월";
			break;
		case 3:
			day = "화";
			break;
		case 4:
			day = "수";
			break;
		case 5:
			day = "목";
			break;
		case 6:
			day = "금";
			break;
		case 7:
			day = "토";
			break;
		}
		return day;
	}

	public int getWeek(ArrayList<Integer> date) {

		Calendar c = Calendar.getInstance();
		c.set(date.get(0), date.get(1) - 1, date.get(2));

		int week = Integer.parseInt(String.valueOf(c.get(Calendar.WEEK_OF_MONTH)));

		return week;

	}

	public ArrayList<Integer> parserDate(String week_date) {
		ArrayList<Integer> datelist = new ArrayList<Integer>();

		StringTokenizer tokens = new StringTokenizer(week_date);

		String temp_year = tokens.nextToken("-");
		String temp_month = tokens.nextToken("-");
		String temp_date = tokens.nextToken("-");

		int year = Integer.parseInt(temp_year);
		int month = Integer.parseInt(temp_month);
		int date = Integer.parseInt(temp_date);

		datelist.add(year);
		datelist.add(month);
		datelist.add(date);

		return datelist;
	}

	public static ArrayList<Integer> CheckDate(WeekVo weekVo) {
		ChangeDate Changedate = new ChangeDate();
		ArrayList<Integer> date = Changedate.parserDate(weekVo.getFirst_date());

		weekVo.setWeek_no(Changedate.getWeekNo(date));

		return date;
	}

	public static String today() {
		Calendar cal = Calendar.getInstance();

		int year = cal.get(cal.YEAR);
		int month = cal.get(cal.MONTH) + 1;
		int date = cal.get(cal.DATE);
		String today = null;
		if (month < 10 && date < 10) {
			today = String.valueOf(year) + "-0" + String.valueOf(month) + "-0" + String.valueOf(date);
		} else if (month < 10 && date > 10) {
			today = String.valueOf(year) + "-0" + String.valueOf(month) + "-" + String.valueOf(date);
		} else if (month > 10 && date < 10) {
			today = String.valueOf(year) + "-" + String.valueOf(month) + "-0" + String.valueOf(date);
		} else {
			today = String.valueOf(year) + "-" + String.valueOf(month) + "-" + String.valueOf(date);
		}
		return today;
	}
}
