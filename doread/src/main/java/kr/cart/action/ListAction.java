package kr.cart.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.cart.dao.CartDAO;
import kr.cart.vo.CartVO;
import kr.controller.Action;

public class ListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		CartDAO dao = CartDAO.getInstance();
		//회원번호별 총 구매액
		int all_total = dao.getTotalByMem_num(user_num);
		
		List<CartVO> list = null;
		if(all_total > 0){
			list = dao.getListCart(user_num);
		}
		
		request.setAttribute("all_total", all_total);
		request.setAttribute("list", list);
		
		return "/WEB-INF/views/cart/list.jsp";
	}

}
