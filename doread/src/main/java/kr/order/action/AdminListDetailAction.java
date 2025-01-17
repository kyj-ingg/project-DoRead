package kr.order.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderDetailVO;
import kr.order.vo.OrderVO;


public class AdminListDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = 
				(Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
 		
		Integer user_auth = 
				(Integer)session.getAttribute("user_auth");
		if(user_auth != 9) {//관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}

		OrderDAO order = OrderDAO.getInstance();
		int order_num = Integer.parseInt(request.getParameter("order_num"));
		
		List<OrderDetailVO> list = order.getListOrder_Detail(order_num);
		request.setAttribute("list", list);
		OrderVO orderVO = order.getBookOrdervo(order_num);
		request.setAttribute("order", orderVO);
		return "/WEB-INF/views/adminster/adminSelListDetail.jsp";
	}

}
