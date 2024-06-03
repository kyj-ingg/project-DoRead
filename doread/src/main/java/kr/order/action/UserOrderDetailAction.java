package kr.order.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.order.dao.OrdersDAO;
import kr.order.vo.OrderDetailVO;
import kr.order.vo.OrderVO;


public class UserOrderDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		int order_num = Integer.parseInt(request.getParameter("order_num"));
		
		OrdersDAO dao = OrdersDAO.getInstance();
		OrderVO order = dao.getOrder(order_num);
		
		if(order.getMem_num() != user_num) {
			return "/WEB-INF/views.common/notice.jsp";
		}
		
		List<OrderDetailVO> detailList = dao.getListOrderDetail(order_num);
		
		request.setAttribute("order", order);
		request.setAttribute("detailList", detailList);
		
		return "/WEB-INF/views/order/user_orderDetail.jsp";
	}

}