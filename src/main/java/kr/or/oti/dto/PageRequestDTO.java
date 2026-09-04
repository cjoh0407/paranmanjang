package kr.or.oti.dto;

import java.time.LocalDate;
import java.util.Arrays;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Positive;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PageRequestDTO {
	@Builder.Default
	@Min(value = 1)
	@Positive
	private int page = 1;
	
	@Builder.Default
	@Min(value = 10)
	@Max(value = 100)
	@Positive
	private int size = 10;
		
	private String link;
	
	private String [] types;
	private String keyword;
	private boolean finished;
	private LocalDate from;
	private LocalDate to;
	
	
	public int getSkip() {
		return (page - 1) * size;
	}
	
	public String getLink() {
		if (link == null) {
			StringBuilder builder = new StringBuilder();
			
			builder.append("page=").append(page)
				.append("&size=").append(size);
			
			if (types != null) {
				for (String type : types) {
					builder.append("&types=").append(type);		
				}
			}
			
			if (keyword != null && keyword.length() > 0) {
				builder.append("&keyword=").append(keyword);	
			}
			
			if (finished) {
				builder.append("&finished=on");	
			}
			
			if (from != null) {
				builder.append("&from=").append(from);	
			}
			
			if (to != null) {
				builder.append("&to=").append(to);	
			}
			
			link = builder.toString();
		}
		return link;
	}
	
	public boolean isCheckType(String type) {
		if (types != null) {
//			for (String item : types) {
//				if (item.equals(type)) return true;	
//			}
			return Arrays.stream(types).anyMatch(type::equals);
		}
		return false;
	}
}