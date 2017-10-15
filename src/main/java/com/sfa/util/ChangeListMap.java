package com.sfa.util;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.sfa.vo.ChartVo;

@Component
public class ChangeListMap {

	public HashMap<String, Long> defaultMap() {
		HashMap<String, Long> map = new HashMap<String, Long>();
		map.put("Jan", (long) 0);
		map.put("Feb", (long) 0);
		map.put("Mar", (long) 0);
		map.put("Apr", (long) 0);
		map.put("May", (long) 0);
		map.put("Jun", (long) 0);
		map.put("Jul", (long) 0);
		map.put("Aug", (long) 0);
		map.put("Sep", (long) 0);
		map.put("Oct", (long) 0);
		map.put("Nov", (long) 0);
		map.put("Dec", (long) 0);

		return map;
	}

	public HashMap<String, Long> change(List<ChartVo> list) {
		HashMap<String, Long> map = defaultMap();
		if (list == null || list.isEmpty()) {
			return map;
		} else {
			if (list.get(0).getEstimate_distance() != null) {
				map = changeEstimate_distance(list);
			} else if (list.get(0).getEstimate_sale() != null) {
				map = changeEstimate_sale(list);
			} else if (list.get(0).getTotal_mile() != null) {
				map = changeMile(list);
			} else if (list.get(0).getTotal_sale() != null) {
				System.out.println("여기 들어와??");
				map = changeSale(list);
			}		
		}
		return map;
	}
		public HashMap<String, Long> changeById(List<ChartVo> list) {
			HashMap<String, Long> map = defaultMap();
			if (list == null || list.isEmpty()) {
				return map;
			} else {
				if (list.get(0).getEstimate_distance() != null) {
					map = changeEstimate_distance(list);
				} else if (list.get(0).getEstimate_sale() != null) {
					map = changeEstimate_sale(list);
				} else if (list.get(0).getTotal_mile() != null) {
					map = changeMile(list);
				} else if (list.get(0).getTotal_sale() != null) {
					System.out.println("여기 들어와??");
					map = changeSale(list);
				}
				return map;
			}

	}

	public HashMap<String, Long> changeSale(List<ChartVo> list) {
		HashMap<String, Long> map = defaultMap();
		for (int i = 0; i < list.size(); i++) {
			switch (list.get(i).getMonth()) {
			case "1":
				map.put("Jan", list.get(i).getTotal_sale() / 10000);
				break;
			case "2":
				map.put("Feb", list.get(i).getTotal_sale() / 10000);
				break;
			case "3":
				map.put("Mar", list.get(i).getTotal_sale() / 10000);
				break;
			case "4":
				map.put("Apr", list.get(i).getTotal_sale() / 10000);
				break;
			case "5":
				map.put("May", list.get(i).getTotal_sale() / 10000);
				break;
			case "6":
				map.put("Jun", list.get(i).getTotal_sale() / 10000);
				break;
			case "7":
				map.put("Jul", list.get(i).getTotal_sale() / 10000);
				break;
			case "8":
				map.put("Aug", list.get(i).getTotal_sale() / 10000);
				break;
			case "9":
				map.put("Sep", list.get(i).getTotal_sale() / 10000);
				break;
			case "10":
				map.put("Oct", list.get(i).getTotal_sale() / 10000);
				break;
			case "11":
				map.put("Nov", list.get(i).getTotal_sale() / 10000);
				break;
			case "12":
				map.put("Dec", list.get(i).getTotal_sale() / 10000);
				break;
			}
		}
		return map;
	}

	public HashMap<String, Long> changeMile(List<ChartVo> list) {
		HashMap<String, Long> map = defaultMap();
		for (int i = 0; i < list.size(); i++) {
			switch (list.get(i).getMonth()) {
			case "1":
				map.put("Jan", list.get(i).getTotal_mile());
				break;
			case "2":
				map.put("Feb", list.get(i).getTotal_mile());
				break;
			case "3":
				map.put("Mar", list.get(i).getTotal_mile());
				break;
			case "4":
				map.put("Apr", list.get(i).getTotal_mile());
				break;
			case "5":
				map.put("May", list.get(i).getTotal_mile());
				break;
			case "6":
				map.put("Jun", list.get(i).getTotal_mile());
				break;
			case "7":
				map.put("Jul", list.get(i).getTotal_mile());
				break;
			case "8":
				map.put("Aug", list.get(i).getTotal_mile());
				break;
			case "9":
				map.put("Sep", list.get(i).getTotal_mile());
				break;
			case "10":
				map.put("Oct", list.get(i).getTotal_mile());
				break;
			case "11":
				map.put("Nov", list.get(i).getTotal_mile());
				break;
			case "12":
				map.put("Dec", list.get(i).getTotal_mile());
				break;
			}
		}
		return map;
	}

	public HashMap<String, Long> changeEstimate_sale(List<ChartVo> list) {
		HashMap<String, Long> map = defaultMap();
		for (int i = 0; i < list.size(); i++) {
			switch (list.get(i).getMonth()) {
			case "1":
				map.put("Jan", list.get(i).getEstimate_sale() / 10000);
				break;
			case "2":
				map.put("Feb", list.get(i).getEstimate_sale() / 10000);
				break;
			case "3":
				map.put("Mar", list.get(i).getEstimate_sale() / 10000);
				break;
			case "4":
				map.put("Apr", list.get(i).getEstimate_sale() / 10000);
				break;
			case "5":
				map.put("May", list.get(i).getEstimate_sale() / 10000);
				break;
			case "6":
				map.put("Jun", list.get(i).getEstimate_sale() / 10000);
				break;
			case "7":
				map.put("Jul", list.get(i).getEstimate_sale() / 10000);
				break;
			case "8":
				map.put("Aug", list.get(i).getEstimate_sale() / 10000);
				break;
			case "9":
				map.put("Sep", list.get(i).getEstimate_sale() / 10000);
				break;
			case "10":
				map.put("Oct", list.get(i).getEstimate_sale() / 10000);
				break;
			case "11":
				map.put("Nov", list.get(i).getEstimate_sale() / 10000);
				break;
			case "12":
				map.put("Dec", list.get(i).getEstimate_sale() / 10000);
				break;
			}
		}
		return map;
	}

	public HashMap<String, Long> changeEstimate_distance(List<ChartVo> list) {
		HashMap<String, Long> map = defaultMap();
		for (int i = 0; i < list.size(); i++) {
			switch (list.get(i).getMonth()) {
			case "1":
				map.put("Jan", list.get(i).getEstimate_distance());
				break;
			case "2":
				map.put("Feb", list.get(i).getEstimate_distance());
				break;
			case "3":
				map.put("Mar", list.get(i).getEstimate_distance());
				break;
			case "4":
				map.put("Apr", list.get(i).getEstimate_distance());
				break;
			case "5":
				map.put("May", list.get(i).getEstimate_distance());
				break;
			case "6":
				map.put("Jun", list.get(i).getEstimate_distance());
				break;
			case "7":
				map.put("Jul", list.get(i).getEstimate_distance());
				break;
			case "8":
				map.put("Aug", list.get(i).getEstimate_distance());
				break;
			case "9":
				map.put("Sep", list.get(i).getEstimate_distance());
				break;
			case "10":
				map.put("Oct", list.get(i).getEstimate_distance());
				break;
			case "11":
				map.put("Nov", list.get(i).getEstimate_distance());
				break;
			case "12":
				map.put("Dec", list.get(i).getEstimate_distance());
				break;
			}
		}
		return map;
	}
	
	public HashMap<String, HashMap<String,Long>> changeddcd(List<ChartVo> list) {
			if(list==null)
			{
				return null;
			}

	
	return null;
	}

}
