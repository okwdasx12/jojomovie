package com.example.controller;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.MemberVo;
import com.example.domain.MovieVo;
import com.example.domain.PayVo;
import com.example.domain.ReserveDto;
import com.example.domain.ReserveVo;
import com.example.domain.SangyounggwanVo;
import com.example.domain.TheaterVo;
import com.example.domain.TimeVo;
import com.example.service.ReservationService;
import com.example.service.SangyoungTimeService;
import com.google.gson.Gson;

import lombok.extern.java.Log;

@Controller
@RequestMapping("/reservation/*")
@Log
public class ReservationController {

	@Autowired
	private ReservationService reservationService;

	@Autowired
	private SangyoungTimeService sangyoungTimeService;

	@GetMapping("")
	public String reservation(Model model, MovieVo movieVo) {
		List<MovieVo> movieList = reservationService.movieRel();
		List<TheaterVo> theaterList = reservationService.theaterRel();

		LocalDate ld = LocalDate.now();
		Map<Integer, String> map = new HashMap<>();

		for (int i = 0; i <= 30; i++) {
			String str = reservationService.dateAdd(ld, i);

			map.put(i, str);
		}

		model.addAttribute("movieList", movieList);
		model.addAttribute("theaterList", theaterList);
		model.addAttribute("dateMap", map);
		model.addAttribute("MovieVo", movieVo);

		return "/reservation/reservation";
	}

	@ResponseBody
	@GetMapping("/ajaxGetSangyoungTime")
	public Map<String, List> getSangyoungTime(int movieId, String theater, String date) {
		LocalDate ldt = LocalDate.parse(date, DateTimeFormatter.ISO_DATE);
		List<ReserveDto> list = reservationService.getSangyoungTime(movieId, theater, ldt);

		List<String> sangyoungTimeList = new ArrayList<>();
		List<Integer> seatsNumList = new ArrayList<>();
		List<Integer> remainSeatsList = new ArrayList<>();
		List<String> sygIdList = new ArrayList<>();
		List<Integer> timeNumList = new ArrayList<>();

		Map<String, List> map = new HashMap<>();
		for (ReserveDto dto : list) {
			LocalDateTime time = dto.getSangyoungTime();
			int seatsNum = dto.getSeatsNum();
			String sygId = dto.getSygId();
			String reserveSeats = dto.getReserveSeats();
			int timeNum = dto.getTimeNum();

			int reserveCount;
			String strTime;

			if (reserveSeats != null) {
				reserveCount = (reserveSeats.length() + 1) / 3;
			} else {
				reserveCount = 0;
			}

			int index = sygId.lastIndexOf(" ") + 1;
			sygId = sygId.substring(index);

			strTime = time.format(DateTimeFormatter.ofPattern("HH:mm"));
			int remainSeats = seatsNum - reserveCount;

			sangyoungTimeList.add(strTime);
			seatsNumList.add(seatsNum);
			remainSeatsList.add(remainSeats);
			sygIdList.add(sygId);
			timeNumList.add(timeNum);
		}

		map.put("sangyoungTimeList", sangyoungTimeList);
		map.put("seatsNumList", seatsNumList);
		map.put("remainSeatsList", remainSeatsList);
		map.put("sygIdList", sygIdList);
		map.put("timeNumList", timeNumList);

		return map;
	}

	@GetMapping("/seat")
	public String reservationSeat(int timeNum, Model model) {
		TimeVo timeVo = sangyoungTimeService.getTimeNumByNum(timeNum);
		SangyounggwanVo rowcul = reservationService.getRowCul(timeVo.getSygId());
		String strSeats = reservationService.getReserveSeatsByTimeNum(timeNum);
		if (strSeats != null) {
			String seats[] = strSeats.split(",");
			int index = seats.length;
			ArrayList<String> seatsList = new ArrayList<>();

			for (int i = 0; i < index; i++) {
				seatsList.add(seats[i]);
			}

			Gson gson = new Gson();
			String strJson = gson.toJson(seatsList);

			model.addAttribute("seatsList", strJson);
			model.addAttribute("index", index);
		} else {
			String seats[] = { "" };

			int index = seats.length;
			ArrayList<String> seatsList = new ArrayList<>();
			
			for (int i = 0; i < index; i++) {
				seatsList.add(seats[i]);
			}
			Gson gson = new Gson();
			String strJson = gson.toJson(seatsList);

			model.addAttribute("seatsList", strJson);
			model.addAttribute("index", 0);
		}

		model.addAttribute("timeVo", timeVo);
		model.addAttribute("rowcul", rowcul);

		return "/reservation/reservation_seat";
	}

	@PostMapping("/doreserve")
	public String insertPayandReservation(ReserveVo reserveVo, int timeNum, int usepoint, int point, PayVo payVo,
			HttpSession session) {

		String strSeats = reservationService.getReserveSeatsByTimeNum(timeNum);

		LocalDateTime ldt = LocalDateTime.now();
		String userId = (String) session.getAttribute("userId");
		MemberVo memberVo = reservationService.findUserPoint(userId);
		int pointUser = memberVo.getPoint();

		usepoint = pointUser - usepoint + point;

		reservationService.updateUserPoint(usepoint, userId, point);

		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		String subNum = "";
		String p = "P";

		for (int i = 1; i <= 6; i++) {
			subNum += (int) (Math.random() * 10);
		}

		String payId = p + ymd + "_" + subNum;
		String ticketId = p + ymd + "_" + subNum;
		payVo.setPayId(payId);
		payVo.setTicketId(ticketId);
		payVo.setUserId(userId);
		payVo.setPayDate(ldt);
		reserveVo.setPayId(payId);
		reserveVo.setTicketId(ticketId);
		reserveVo.setReserveDate(ldt);
		reserveVo.setUserId(userId);
		String seats = reserveVo.getSeat();
		
		if (strSeats == null || strSeats.length() < 2) {
			strSeats = seats;
		} else {
			strSeats += "," + seats;
		}
		reservationService.updateReserveSeats(timeNum, strSeats);
		reservationService.insertReservation(reserveVo);
		reservationService.insertPay(payVo);

		return "redirect:/mypage/";

	}

	@GetMapping(value = "/search/{userId}")
	@ResponseBody
	public int findUserPoint(@PathVariable("userId") String userId) {
		MemberVo memberVo = reservationService.findUserPoint(userId);
		int point = memberVo.getPoint();

		return point;
	}

	@GetMapping("/usePoint")
	public @ResponseBody Map<String, Object> showMaxPoint(String useP, String userId) {
		if (useP == null || useP.length() == 0) {
			return null;
		}

		boolean whymax = reservationService.maxPoint(userId, useP);

		Map<String, Object> map = new HashMap<>();
		map.put("whymax", whymax);

		return map;
	}
}
