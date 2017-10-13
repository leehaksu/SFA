package com.sfa.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.sfa.repository.DateReportDao;
import com.sfa.repository.PlanWeekDao;
import com.sfa.util.ChangeDate;
import com.sfa.vo.DayVo;
import com.sfa.vo.WeekVo;

@Service
public class WeekPlanService {

	@Autowired
	private PlanWeekDao weekplanDao;

	@Autowired
	private ChangeDate changeDate;

	@Autowired
	private PlatformTransactionManager transactionManager;
	DefaultTransactionDefinition def = null;
	TransactionStatus status = null;

	public boolean insertWeek(WeekVo weekVo, DayVo dayVo) {
		// TODO Auto-generated method stub
		try {
			def = new DefaultTransactionDefinition();
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
			status = transactionManager.getTransaction(def);

			System.out.println("[InsertWeek]" + weekVo);
			// 주간계획이 입력이 되어 있는지 확인.
			WeekVo temp_weekVo = checkWeek(weekVo);

			if (temp_weekVo != null) {
				// 주간계획이 있을경우에는 false값을 전달
				System.out.println(temp_weekVo);
				return false;
			} else {
				// 주간 계획이 없을 경우에는 insert 작업을 진행
				int week_no = weekplanDao.insertWeek(weekVo);
				// 주간 계획이 정상적으로 입력되지 않을 경우
				dayVo.setId(weekVo.getId());
				if (week_no == 0) {

					return false;
				}
			}
			// 주간계획의 상세 내용을 day_plan에 입력하느 작업 진행
			dayVo.setWeek_no(weekVo.getWeek_no());
			String[] day = new String[] { "월", "화", "수", "목", "금" };
			String[] content = new String[] { weekVo.getMonday(), weekVo.getTuesday(), weekVo.getWednesday(),
					weekVo.getThursday(), weekVo.getFriday() };
			Long[] Day_sale = new Long[] { weekVo.getMonday_money(), weekVo.getTuesday_money(),
					weekVo.getWednesday_money(), weekVo.getThursday_money(), weekVo.getFriday_money() };
			// 요일 날짜를 월요일부터 금요일까지 계산해서 list에 저장
			String[] list = ChangeDate.five_date(weekVo.getFirst_date());

			// 주간계획에 따른 요일 계획을 저장
			for (int i = 0; i < 5; i++) {
				dayVo.setDate(list[i]);
				dayVo.setDay(day[i]);
				dayVo.setContent(content[i]);
				dayVo.setDay_sale(Day_sale[i]);
				System.out.println("[insertDay]" + dayVo);
				weekplanDao.insertDay(dayVo);
			}
			transactionManager.commit(status);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			transactionManager.rollback(status);
			return false;
		}
	}

	public boolean deleteWeek(WeekVo weekVo) {
		// TODO Auto-generated method stub

		ChangeDate.CheckDate(weekVo);

		int check = 0;
		if (weekplanDao.deletetotalDay(weekVo) == 5 || weekplanDao.deletetotalDay(weekVo) == 4
				|| weekplanDao.deletetotalDay(weekVo) == 3 || weekplanDao.deletetotalDay(weekVo) == 2
				|| weekplanDao.deletetotalDay(weekVo) == 1) {
			if (weekplanDao.deleteWeek(weekVo) == 1) {
				System.out.println("service check 확인 : " + check);
				return true;
			} else {
				return false;
			}
		}
		return false;
	}

	public int updateDay(WeekVo weekVo, int no) {
		// TODO Auto-generated method stub
		System.out.println("너 여기로는 들어오니????");
		DayVo dayVo = new DayVo();
		dayVo.setId(weekVo.getId());
		dayVo.setWeek_no(weekVo.getWeek_no());
		switch (no) {
		case 2:
			dayVo.setDay("월");
			dayVo.setDay_sale((weekVo.getMonday_money()));
			dayVo.setContent(weekVo.getMonday());
			System.out.println("월" + dayVo);
			no = weekplanDao.update(dayVo);
			break;
		case 3:
			dayVo.setDay("화");
			dayVo.setDay_sale(weekVo.getTuesday_money());
			dayVo.setContent(weekVo.getTuesday());
			System.out.println("화" + dayVo);
			no = weekplanDao.update(dayVo);
			break;
		case 4:
			dayVo.setDay("수");
			dayVo.setDay_sale(weekVo.getWednesday_money());
			dayVo.setContent(weekVo.getWednesday());
			System.out.println("수" + dayVo);
			no = weekplanDao.update(dayVo);
			break;
		case 5:
			dayVo.setDay("목");
			dayVo.setDay_sale(weekVo.getThursday_money());
			dayVo.setContent(weekVo.getThursday());
			System.out.println("목" + dayVo);
			no = weekplanDao.update(dayVo);
			break;
		case 6:
			dayVo.setDay("금");
			dayVo.setDay_sale(weekVo.getFriday_money());
			dayVo.setContent(weekVo.getFriday());
			System.out.println("금" + dayVo);
			no = weekplanDao.update(dayVo);
			break;
		}
		return no;
	}

	public WeekVo selectWeek(WeekVo weekVo) {
		System.out.println("[service] 들어옴");

		String date = weekVo.getFirst_date();

		System.out.println(date);

		System.out.println(weekVo);

		ChangeDate.CheckDate(weekVo);

		weekVo = weekplanDao.selectWeek(weekVo);

		System.out.println("[weekVo}" + weekVo);

		if (weekVo == null) {
			WeekVo weekVo2 = new WeekVo();
			String[] list = ChangeDate.five_date(date);

			weekVo2.setMonday_date(list[0]);
			weekVo2.setTuesday_date(list[1]);
			weekVo2.setWednesday_date(list[2]);
			weekVo2.setThursday_date(list[3]);
			weekVo2.setFriday_date(list[4]);
			System.out.println(weekVo2);
			return weekVo2;
		}
		List<DayVo> list = weekplanDao.selectDay(weekVo);

		for (int i = 0; i < list.size(); i++) {
			switch (list.get(i).getDay()) {
			case "월":
				weekVo.setMonday((list.get(i)).getContent());
				weekVo.setMonday_money((list.get(i)).getDay_sale());
				weekVo.setMonday_date(list.get(i).getDate());
				break;
			case "화":
				weekVo.setTuesday((list.get(i)).getContent());
				weekVo.setTuesday_money((list.get(i)).getDay_sale());
				weekVo.setTuesday_date(list.get(i).getDate());
				break;
			case "수":
				weekVo.setWednesday((list.get(i)).getContent());
				weekVo.setWednesday_money((list.get(i)).getDay_sale());
				weekVo.setWednesday_date(list.get(i).getDate());
				break;
			case "목":
				weekVo.setThursday((list.get(i)).getContent());
				weekVo.setThursday_money((list.get(i)).getDay_sale());
				weekVo.setThursday_date(list.get(i).getDate());
				break;
			case "금":
				weekVo.setFriday((list.get(i)).getContent());
				weekVo.setFriday_money((list.get(i)).getDay_sale());
				weekVo.setFriday_date(list.get(i).getDate());
				break;
			}
		}
		System.out.println("[Service] 후 :" + weekVo);
		return weekVo;
	}

	public WeekVo checkWeek(WeekVo weekVo) {
		// TODO Auto-generated method stub

		ChangeDate Changedate = new ChangeDate();
		ArrayList<Integer> date = Changedate.parserDate(weekVo.getFirst_date());
		System.out.println();
		weekVo.setWeek_no(Changedate.getWeekNo(date));

		weekVo = weekplanDao.selectWeek(weekVo);
		return weekVo;
	}

	public int update(WeekVo weekVo) {
		System.out.println("서비스 부분" + weekVo);
		// TODO Auto-generated method stub
		ChangeDate.CheckDate(weekVo);
		// 주간 계획이 입력되었는지 확인
		WeekVo temp_weekVo = checkWeek(weekVo);
		int no = 0;
		try {
			def = new DefaultTransactionDefinition();
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
			status = transactionManager.getTransaction(def);

			if (temp_weekVo == null) {
				// 주간계획이 입력이 되지 않을경우
				no = 1;
			} else if (temp_weekVo != null) {
				// 주간계획이 입력되어 정상적으로 update 진행
				no = weekplanDao.update(weekVo);
				for (int i = 2; i < 7; i++) {
					no += updateDay(weekVo, i);
				}
			}
			transactionManager.commit(status);
		} catch (Exception e) {
			transactionManager.rollback(status);
			no = 0;
			return no;
		}

		return no;
	}

	public List<DayVo> selectMonth(DayVo dayVo) {
		// TODO Auto-generated method stub
		ArrayList<Integer> date = changeDate.parserDate(dayVo.getFirst_date());
		String name = changeDate.getWeekNo(date);
		name = name.substring(0, 6);
		int Date = Integer.parseUnsignedInt(name);
		System.out.println("date" + Date);
		String Date1 = "%" + String.valueOf(Date - 1) + "%";
		String Date2 = "%" + String.valueOf(Date) + "%";
		String Date3 = "%" + String.valueOf(Date + 1) + "%";
		String id = dayVo.getId();
		List<DayVo> list = weekplanDao.selectMonth(id, Date1, Date2, Date3);
		return list;
	}



	public List<WeekVo> selectTotalWeek(String id, String date) {
		// TODO Auto-generated method stub
		ArrayList<Integer> date2 = changeDate.parserDate(date);
		String week_no = changeDate.getWeekNo(date2);
		List<WeekVo> week_list = weekplanDao.selectTotalWeek(id, week_no);
		List<DayVo> day_list = weekplanDao.selectTotalDay(id, week_no);
		System.out.println(day_list);
		for (int i = 0; i < week_list.size(); i++) {
			for (int j = 0; j < day_list.size(); j++) {
				if ((week_list.get(i).getWeek_no()).equals(day_list.get(i).getWeek_no())
						&& (week_list.get(i).getId()).equals(day_list.get(j).getId())) {

					switch (day_list.get(j).getDay()) {
					case "월":
						week_list.get(i).setMonday((day_list.get(j)).getContent());
						week_list.get(i).setMonday_money((day_list.get(j)).getDay_sale());
						week_list.get(i).setMonday_date(day_list.get(j).getDate());
						break;
					case "화":
						week_list.get(i).setTuesday((day_list.get(j)).getContent());
						week_list.get(i).setTuesday_money((day_list.get(j)).getDay_sale());
						week_list.get(i).setTuesday_date(day_list.get(j).getDate());
						break;
					case "수":
						week_list.get(i).setWednesday((day_list.get(j)).getContent());
						week_list.get(i).setWednesday_money((day_list.get(j)).getDay_sale());
						week_list.get(i).setWednesday_date(day_list.get(j).getDate());
						break;
					case "목":
						week_list.get(i).setThursday((day_list.get(j)).getContent());
						week_list.get(i).setThursday_money((day_list.get(j)).getDay_sale());
						week_list.get(i).setThursday_date(day_list.get(j).getDate());
						break;
					case "금":
						week_list.get(i).setFriday((day_list.get(j)).getContent());
						week_list.get(i).setFriday_money((day_list.get(j)).getDay_sale());
						week_list.get(i).setFriday_date(day_list.get(j).getDate());
						break;
					default:
						System.out.println(day_list.get(j).getDay());
						break;
					}
				}
			}
		}
		return week_list;
	}
	public Long selectGoal_sale(String date, String id) {
		// TODO Auto-generated method stub
		return weekplanDao.selectGoal_sale(date,id);
	}
}