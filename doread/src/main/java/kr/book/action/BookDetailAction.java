package kr.book.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.book.dao.BookDAO;
import kr.book.vo.BookVO;
import kr.controller.Action;
import kr.util.StringUtil;

public class BookDetailAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int book_num = Integer.parseInt(request.getParameter("book_num"));
		BookDAO dao = BookDAO.getInstance();
		
		BookVO book = dao.getBookDetail(book_num);
		book.setBook_name(StringUtil.useNoHTML(book.getBook_name()));
		
		request.setAttribute("book", book);
		
		return "/WEB-INF/views/book/detail.jsp";
	}

}