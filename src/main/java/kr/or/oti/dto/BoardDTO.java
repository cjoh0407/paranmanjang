package kr.or.oti.dto;

import java.time.LocalDateTime;
import java.util.List;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BoardDTO {
	private Long bno;

	@NotEmpty
	@Size(min = 3, max = 100)
	private String title;

	@NotEmpty
	private String content;

	@NotEmpty
	private String writer;

	private LocalDateTime regDate;
	private LocalDateTime modDate;

	// 첨부파일 이름
	private List<String> fileNames;

	// 화면 출력용 S3 URL
	private List<String> imageUrls;

}
