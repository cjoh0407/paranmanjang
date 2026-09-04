package kr.or.oti.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BoardImageDTO {
	
	private String uuid;
	private String filename;
	private int ord;
	
	// S3 이미지 URL
    private String imageUrl;
	
	public String getFullName() {
		return this.uuid+"_"+this.filename;
	}
}
