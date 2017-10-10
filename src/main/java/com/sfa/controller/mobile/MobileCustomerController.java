package com.sfa.controller.mobile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.service.CustomerService;
import com.sfa.vo.CustomerVo;

@Controller
@RequestMapping("/m/customer")
public class MobileCustomerController {
	
	@Autowired
	CustomerService customerService;
	
	@ResponseBody
	@RequestMapping("/insert")
	public JSONResult insert(@ModelAttribute CustomerVo customerVo)
	{
		System.out.println("[Controller]"+customerVo);
		if(customerVo==null)
		{
			return JSONResult.error("정상적인 접근이 아닙니다.");
		}
		int no=customerService.insert(customerVo);
		if(no==1)
		{
			return JSONResult.success();
		}else
		{
			return JSONResult.fail("저장에 실패하였습니다.");
		}
	}
	
	@ResponseBody
	@RequestMapping("/select")
	public JSONResult select(@RequestParam(value="id", required=true, defaultValue="")String id)
	{
		if("".equals(id))
		{
			return JSONResult.error("아이디가 입력되지 않았습니다.");
		}else
		{
			List<CustomerVo> list = customerService.select(id);
			return JSONResult.success(list);
		}
	}
	
	@ResponseBody
	@RequestMapping("/update")
	public JSONResult update(@ModelAttribute CustomerVo customerVo)
	{
		if(customerVo==null)
		{
			return JSONResult.error("파라미터가 입력되지 않앗습니다.");
		}else
		{
			int no = customerService.update(customerVo);
			return JSONResult.success();
		}
	}
	@ResponseBody
	@RequestMapping("/delete")
	public JSONResult delete(@RequestParam(value="customer_code",required=true,defaultValue="")String customer_code)
	{
		if("".equals(customer_code))
		{
			return JSONResult.error("고객코드가 넘어오지 않았습니다.");
		}else
		{
			int no = customerService.delete(customer_code);
		}
		return null;
	}
	

}
