package edu.spring.p01;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.spring.p01.domain.ProductVO;
import edu.spring.p01.pageutil.PageCriteria;
import edu.spring.p01.pageutil.PageMaker;
import edu.spring.p01.service.AdminService;
import edu.spring.p01.service.ProductService;

@Controller
@RequestMapping(value="/product")
public class ProductController {
	private static final Logger logger =
			LoggerFactory.getLogger(ProductController.class);
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/index")
	public void indexGET(Model model, Integer page, Integer numsPerPage, String keyword) throws Exception {
		logger.info("productListGET() Call");
		logger.info("page = " + page + ", numsPerPage = " + numsPerPage);
		logger.info("keyword : " + keyword);
		// Paging
		PageCriteria criteria = new PageCriteria();
		if(page != null) {
			criteria.setPage(page);
		}
		
		if(numsPerPage != null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		
		if(keyword != null) {
			criteria.setKeyword(keyword);
		}
		
		
		List<ProductVO> product = adminService.selectAll(criteria);
		if(!product.isEmpty()) {
			model.addAttribute("product", product); // 상품 존재
		} else {
			model.addAttribute("listCheck", "empty"); // 상품 존재 안 할 경우
			return;
		}
		
		
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(adminService.getTotalNumsOfRecords(criteria));
		pageMaker.setPageData();
		logger.info("getTotalNumsOfRecords : " + adminService.getTotalNumsOfRecords(criteria));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@GetMapping("/detail")
	public void detailGET(Model model, Integer productNo, Integer page) throws Exception {
		logger.info("detailGET() Call : productNo : " + productNo);
		ProductVO product = adminService.read(productNo);
		
		// 상품 정보
		model.addAttribute("product", product);
		
		// 상품 정보 페이지
		model.addAttribute("page", page);
	}
	
	// 회원 구매내역
	@GetMapping("/order")
	public void orderGET() {
		logger.info("orderGET() Call");
	}

}
