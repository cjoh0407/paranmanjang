package kr.or.oti.dto;

import java.time.LocalDate;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BoardListAllDTO {
	private Long bno;
	private String title;
	private String writer;
	private LocalDate regDate;
	private Long replyCount;

	private List<BoardImageDTO> boardImages;
}
