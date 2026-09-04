package kr.or.oti.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BoardVO {
	private Long tid;
	private String title;
	private LocalDate dueDate;
	private boolean finished;
	private String writer;
	private boolean delFlag;
	
}
