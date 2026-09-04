package kr.or.oti.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.oti.dto.PageRequestDTO;
import kr.or.oti.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
@Slf4j
public class BoardController {
	private final BoardService boardService;

	//board list 조회
	 @RequestMapping("/list")
	    public void list(PageRequestDTO pageRequestDTO, Model model) {
	        log.info("board list: {}", pageRequestDTO);
	        
	        // 일반 listWithReplyCount 대신 이미지까지 모두 가져오는 listWithAll 사용
	        model.addAttribute("pageResponseDTO", boardService.listWithAll(pageRequestDTO));
	  }
	
}
