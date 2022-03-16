package edu.spring.p01.persistence;

import java.util.List;

import edu.spring.p01.domain.CateVO;
import edu.spring.p01.domain.ProductVO;
import edu.spring.p01.pageutil.PageCriteria;

public interface AdminDAO {
	
	// 상품 등록
	int insert(ProductVO product);
	
	// 상품 전체읽기
	List<ProductVO> readAll(PageCriteria criteria);
	
	// 상품 총 수량
	int getTotalNumsOfRecords(PageCriteria criteria);
	
	// 상품 리스트
	// 키워드 검색이 가능
	List<ProductVO> selectAll(PageCriteria criteria);
	
	// 상품 검색
	List<ProductVO> selectByTitleOrContent(String keyword);
	
	
	// 상품 보기
	ProductVO read(int productNo);
	
	// 상품 수정
	int update(ProductVO product);
	
	// 상품 삭제
	int delete(int productNo);
	
	// 카테고리 리스트
	List<CateVO> cateList();
	
	

}
