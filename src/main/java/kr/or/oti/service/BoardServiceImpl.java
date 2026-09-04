package kr.or.oti.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.oti.dto.BoardListAllDTO;
import kr.or.oti.dto.PageRequestDTO;
import kr.or.oti.dto.PageResponseDTO;
import kr.or.oti.mapper.BoardDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService {
	private final BoardDAO boardDAO;

	@Override
	public PageResponseDTO<BoardListAllDTO> listWithAll(
	        PageRequestDTO pageRequestDTO) {
		List<BoardListAllDTO> dtoList =
	            boardDAO.searchWithAll(pageRequestDTO);

	    int total =
	            boardDAO.getCount(pageRequestDTO);

	    return new PageResponseDTO<>(
	            pageRequestDTO,
	            dtoList,
	            total
	    );
	}
}
