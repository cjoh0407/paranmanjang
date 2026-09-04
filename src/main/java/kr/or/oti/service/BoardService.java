package kr.or.oti.service;

import kr.or.oti.dto.BoardListAllDTO;
import kr.or.oti.dto.PageRequestDTO;
import kr.or.oti.dto.PageResponseDTO;

public interface BoardService {

	PageResponseDTO<BoardListAllDTO> listWithAll(PageRequestDTO pageRequestDTO);
}
