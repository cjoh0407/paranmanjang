package kr.or.oti.mapper;

import java.util.List;

import kr.or.oti.dto.BoardListAllDTO;
import kr.or.oti.dto.PageRequestDTO;

public interface BoardDAO {
	List<BoardListAllDTO> searchWithAll(PageRequestDTO pageRequestDTO);

	int getCount(PageRequestDTO pageRequestDTO);
}
