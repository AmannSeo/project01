package edu.spring.p01;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;

import edu.spring.p01.domain.CateVO;
import edu.spring.p01.domain.MemberVO;
import edu.spring.p01.domain.ProductVO;
import edu.spring.p01.pageutil.PageCriteria;
import edu.spring.p01.pageutil.PageMaker;
import edu.spring.p01.service.AdminService;
import edu.spring.p01.service.MemberService;
import edu.spring.p01.util.UploadFileUtils;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
	private static final Logger logger =
			LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private MemberService memberService;
	
	@Resource (name="uploadPath")
	   private String uploadPath;
	
	// 관리자 페이지 이동
	@RequestMapping(value="/index", method = RequestMethod.GET)
	public void adminPageGET() {
		logger.info("adminPageGET() Call");
	}
	
	// 상품 등록 페이지 이동
	@GetMapping(value="/productReg")
	public void productRegGET(Model model) throws Exception {
		logger.info("productRegGET() Call");
		
		// ObjectMapper 클래스를 인스턴스화 하여 사용
		// 인스턴스화 : 클래스 내의 객체에 대한 특정한 변형을 정의하고
		// 이름을 붙인 다음, 그것을 물리적인 어떤 장소에 위치시키는 등의
		// 작업을 통해 인스턴스를 하는 것을 의미
		ObjectMapper objm = new ObjectMapper();
		
		// 카테고리 리스트 데이터를 담고 있는 객체 'list'
		// 해당 객체를 JSON형식의 String 데이터로 변환
		List<CateVO> list = adminService.cateList();
		
		// writeValueAsString : Java 객체를 String 타입의 JSON형식 데이터로 변환해 줌
		String cateList = objm.writeValueAsString(list);
		
		// 뷰(view)로 데이터를 넘겨주기 위해서 url매핑 메서드의 파라미터에
		// Model를 부텨해준 후 addAttribute()를 사용하여
		// "cateList" 속성에 Stirng타입의 'cateList' 변수의 값을 저장시킴
		model.addAttribute("cateList", cateList);
		
		logger.info("변경 전 >> " + list);
		logger.info("변경 후 >> " + cateList);
	}
	
	// 상품 등록
	@PostMapping(value="/productReg")
	public String productRegPOST(ProductVO product,RedirectAttributes reAttr, MultipartFile file) throws Exception{
		// RedirectAttributes
	    // - 재경로 위치에 속성값을 전송하는 객체
		logger.info("productRegPOST() Call");
		logger.info("product : " + product.toString());
		
		//파일 업로드 관련 start
	    String imgUploadPath = uploadPath + File.separator + "imgUpload";
	    String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
	    String fileName = null;
	    logger.info("imgUploadPath() Call");
	    if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
	        fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
	       } else {
	        fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
	       }
	    product.setProductImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
	    //파일 업로드 관련 end
	    
		int result = adminService.insert(product);
		
		logger.info(result + "상품 등록");
		if(result == 1) {
			logger.info("상품 등록 성공");
			reAttr.addFlashAttribute("insert_result",product.getProductName());
			return "redirect:/admin/productList";
		} else {
			logger.info("상품 등록 실패");
			reAttr.addFlashAttribute("insert_result",product.getProductName());
			return "redirect:/admin/productReg";
		}
	}
	
	// 상품 목록 페이지 이동
	// 검색 키워드를 보내주고 받아와야 함. jsp에서 보내준 데이터를 못 받으며 검색이 되지 않음
	@GetMapping(value="/productList")
	public void productListGET(Model model, Integer page, Integer numsPerPage, String keyword) throws Exception {
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
			model.addAttribute("list", product); // 상품 존재
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
	
	
	// 상품 상세 페이지 이동
	@GetMapping("/productDetail")
	public void productDetail(Model model, Integer productNo, Integer page) {
		logger.info("productDetail() Call : productNo : " + productNo);
		ProductVO product = adminService.read(productNo);
		
		// 상품 정보
		model.addAttribute("product", product);
		
		// 상품 정보 페이지
		model.addAttribute("page", page);
	}
	
	// 상품 정보 수정 GET
	@GetMapping("/productUpdate")
	public void productUpdateGET(Model model, Integer productNo) {
		logger.info("productUpdateGET() Call");
		logger.info("(Get)product No : " + productNo);
		ProductVO product = adminService.read(productNo);
		model.addAttribute("product", product);
	}
	
	// 상품 정보 수정 POST
	@PostMapping("/productUpdate")
	public String productUpdatePOST(ProductVO product, Integer page, MultipartFile file, HttpServletRequest req) throws Exception {
		logger.info("productUpdatePOST() Call");
		logger.info("(Post)product No : " + product);
		
		// 새로운 파일이 등록되었는지 확인
	    if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
	    // 기존 파일을 삭제
	    new File(uploadPath + req.getParameter("productImg")).delete();
	    
	    // 새로 첨부한 파일을 등록
	    String imgUploadPath = uploadPath + File.separator + "imgUpload";
	    String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
	    String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
	    
	    product.setProductImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
	    
	   } else {  // 새로운 파일이 등록되지 않았다면
	    // 기존 이미지를 그대로 사용
	    product.setProductImg(req.getParameter("productImg"));
	    
	   }
		
		int result = adminService.update(product);
		if(result == 1) {
			logger.info("product update success");
			return "redirect:/admin/productDetail?productNo=" + product.getProductNo();
		} else {
			logger.info("product update fail");
			return "redirect:/admin/productUpdate?productNo=" + product.getProductNo();
		}
		
	}
	
	// 상품 삭제
	@GetMapping("/productDelete")
	public String productDeleteGET(Integer productNo) {
		logger.info("delete() Call");
		logger.info("delete product No : " + productNo);
		int result = adminService.delete(productNo);
		if(result == 1) {
			logger.info("delete Success");
			return "redirect:/admin/productList";
		} else {
			logger.info("delete Fail");
			return "redirect:/admin/productDetail?productNo=" + productNo;
		}
	}
	
	
	// 회원 관리 페이지 이동
	@GetMapping("/memberManage")
	public void memberManageGET(Model model, Integer page, Integer numsPerPage) {
		logger.info("memberManageGET() Call");
		logger.info("page = " + page + ", numsPerPage = " + numsPerPage);
		// Paging
		PageCriteria cri = new PageCriteria();
		if(page != null) {
			cri.setPage(page);
		}
		
		if(numsPerPage != null) {
			cri.setNumsPerPage(numsPerPage);
		}
		
		
		List<MemberVO> vo = memberService.selectAll(cri);
		if(!vo.isEmpty()) {
			model.addAttribute("vo", vo); // 회원 존재
		} else {
			model.addAttribute("listCheck", "empty"); // 회원 존재 안 할 경우
		}
		
		
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(cri);
		pageMaker.setTotalCount(memberService.getTotalNumsOfRecords(cri));
		pageMaker.setPageData();
		logger.info("getTotalNumsOfRecords : " + memberService.getTotalNumsOfRecords(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	// 회원 정보 이동
	@GetMapping("/memberInfo")
	public void memberInfo(Model model, int memberNo, Integer page) {
		logger.info("memberInfo() Call : memberNo : " + memberNo);
		MemberVO vo = memberService.select(memberNo);
		
		// 회원 정보
		model.addAttribute("vo", vo);
		
		
		// 회원 정보 페이지
		model.addAttribute("page", page);
	}
	
	// 상품 문의 페이지 이동
	@RequestMapping(value="/productFaq", method = RequestMethod.GET)
	public void productFaqGET() {
		logger.info("productFaqGET() Call");
	}
	
	// 상품평 페이지 이동
	@RequestMapping(value="/productComment", method = RequestMethod.GET)
	public void productCommentGET() {
		logger.info("productCommentGET() Call");
	}
	
	
	
	
}





















