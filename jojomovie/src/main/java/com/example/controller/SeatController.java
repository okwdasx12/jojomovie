package com.example.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.java.Log;

/////////////// 안쓰는중
@Controller
@Log
public class SeatController {
	@GetMapping("/ajaxSeat")
	@ResponseBody
	public String makeSeat(int row, int cul) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		String str = "";
		int cnt = 1;
		char hang = 'A';
		Object seat = "";
		
		for (int i = 1; i <= row; i++) {
			for (int j = 1; j <= cul; j++) {
				str += "<button id='btn" + cnt + "'>" + hang + j + "</button>";
				seat = hang + "" + j;
				map.put(cnt, seat);

				cnt++;
			}
			str += "<br>";
			hang++;
		}
		
		map.put("cnt_num", cnt - 1);
		
		return str;
	}
}
