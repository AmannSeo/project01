package edu.spring.p01.service;

import java.util.List;

import edu.spring.p01.domain.CateVO;
import edu.spring.p01.domain.ProductVO;
import edu.spring.p01.pageutil.PageCriteria;

public interface ProductService {

	// 상품 검색
	List<ProductVO> getProductList(PageCriteria criteria);
		
	// 상품 총 갯수
	int productGetTotal(PageCriteria criteria);
	
	// 카테고리별 상품 리스트
	List<ProductVO> list(String cateCode);
	
}






