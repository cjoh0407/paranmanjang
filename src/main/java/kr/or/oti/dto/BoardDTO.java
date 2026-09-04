package kr.or.oti.dto;

import java.time.LocalDate;

import javax.validation.constraints.Future;
import javax.validation.constraints.NotEmpty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BoardDTO {
	private Long tid;
	
	@NotEmpty
	private String title;
	
	private boolean delFlag;
	
	@Future
	private LocalDate dueDate;
	private boolean finished;
	
	@NotEmpty
	private String writer;
	
	private LocalDate createDate;
	
	public String getFinishedStr() {
		return finished ? "done" : "not yet";
	}
	
}
