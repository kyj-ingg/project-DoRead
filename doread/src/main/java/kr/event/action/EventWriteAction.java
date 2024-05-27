package kr.event.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.event.dao.EventDAO;
import kr.event.vo.EventVO;
import kr.util.FileUtil;

public class EventWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
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
	
		String e_title =request.getParameter("e_title");
		String e_content =request.getParameter("e_content");
		String e_deadline =request.getParameter("e_deadline");
		String e_item =request.getParameter("e_item");
		
		EventDAO dao = EventDAO.getInstance();
		EventVO event = new EventVO();
		
		event.setMem_num(user_num);
		event.setE_content(e_content);
		event.setE_image(FileUtil.createFile(request, "e_image"));
		event.setE_title(e_title);
		event.setE_deadline(e_deadline);
		event.setE_item(e_item);
		dao.eventWrite(event);
		
		return "redirect:/event/eventmain.do";
	}

}