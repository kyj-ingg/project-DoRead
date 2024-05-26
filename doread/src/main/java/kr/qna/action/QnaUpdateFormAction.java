package kr.qna.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.qna.dao.QnaDAO;
import kr.qna.vo.QnaVO;
import kr.util.StringUtil;

public class QnaUpdateFormAction implements Action{

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
		if(user_num!=qna.getMem_num()) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//큰 따옴표 처리
		//수정폼의 input 태그에서 큰 따옴표 오류 보정
		qna.setQ_title(StringUtil.parseQuot(qna.getQ_title()));
		
		//로그인이 되어있고 로그인한 회원번호와 작성자 회원 번호 일치
		request.setAttribute("qna", qna);
		
		return "/WEB-INF/views/qna/qnaUpdateForm.jsp";
	}
	
}