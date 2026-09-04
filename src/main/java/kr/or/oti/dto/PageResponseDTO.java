package kr.or.oti.dto;

import java.util.List;

import lombok.Getter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Getter
@ToString
@Slf4j
public class PageResponseDTO<E> {
	private int page;   //페이지 번호 
	private int size;   //한 페이지출력하는 항목수  
	private int total;  //전체 건수 
	
	private int start;// 시작페이지 번호
	private int end;// 끝 페이지 번호

	private boolean prev;// 이전 페이지 출력여부 
	private boolean next;// 다음 페이지 출력여부 

	List<E>  dtoList;  //페이지 목록을 위해서 출력할 배열
	
	//@Builder(builderMethodName = "withAll")
	public PageResponseDTO(PageRequestDTO pageRequestDTO, List<E>  dtoList, int total) {
		this.page = pageRequestDTO.getPage();
		this.size = pageRequestDTO.getSize();
		this.total = total;
		this.dtoList = dtoList;
		
		end = (int)(Math.ceil(page/10.0) * 10);// 끝 페이지 번호
		start = end - 9;// 시작페이지 번호
		log.info("start = " + start);
		//마지막 페이지 번호 
		final int last = (int) Math.ceil(total /(double)size);
		//last : 5
		//end : 10
		end = end > last ? last : end; 
		
		prev = start > 1;// 이전 페이지 출력여부 
		next = total > end * size;// 다음 페이지 출력여부 
	}
}