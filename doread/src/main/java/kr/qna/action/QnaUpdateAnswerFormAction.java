package kr.qna.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.qna.dao.QnaDAO;
import kr.qna.vo.QnaVO;

public class QnaUpdateAnswerFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		int q_num = Integer.parseInt(request.getParameter("q_num"));
		
		QnaDAO dao = QnaDAO.getInstance();
		QnaVO qna= dao.getQna(q_num);		
		
		request.setAttribute("qna", qna);
		
		return "/WEB-INF/views/qna/qnaUpdateAnswerForm.jsp";
	}
	
}
