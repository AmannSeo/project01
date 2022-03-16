package edu.spring.p01.domain;

import java.util.Arrays;
import java.util.Date;

public class ProductVO {
	
	private int productNo; // 상품 번호
	private String productName; // 상품명
	private int productPrice; // 상품 가격
	private int productAmount; // 상품 수량
	private String productIntro; // 상품 소개
	private Date productRegDate; // 상품 등록 날짜
	
	private String cateCode; // 카테고리 코드
	private String cateName; // 카테고리 이름
	
	
	private String productImg; // 상품 이미지
	
	
	public ProductVO() {
		super();
	}


	public ProductVO(int productNo, String productName, int productPrice, int productAmount, String productIntro,
			Date productRegDate, String cateCode, String cateName, String productImg) {
		super();
		this.productNo = productNo;
		this.productName = productName;
		this.productPrice = productPrice;
		this.productAmount = productAmount;
		this.productIntro = productIntro;
		this.productRegDate = productRegDate;
		this.cateCode = cateCode;
		this.cateName = cateName;
		this.productImg = productImg;
	}


	public int getProductNo() {
		return productNo;
	}


	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}


	public String getProductName() {
		return productName;
	}


	public void setProductName(String productName) {
		this.productName = productName;
	}


	public int getProductPrice() {
		return productPrice;
	}


	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}


	public int getProductAmount() {
		return productAmount;
	}


	public void setProductAmount(int productAmount) {
		this.productAmount = productAmount;
	}


	public String getProductIntro() {
		return productIntro;
	}


	public void setProductIntro(String productIntro) {
		this.productIntro = productIntro;
	}


	public Date getProductRegDate() {
		return productRegDate;
	}


	public void setProductRegDate(Date productRegDate) {
		this.productRegDate = productRegDate;
	}


	public String getCateCode() {
		return cateCode;
	}


	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
	}


	public String getCateName() {
		return cateName;
	}


	public void setCateName(String cateName) {
		this.cateName = cateName;
	}


	public String getProductImg() {
		return productImg;
	}


	public void setProductImg(String productImg) {
		this.productImg = productImg;
	}


	@Override
	public String toString() {
		return "ProductVO [productNo=" + productNo + ", productName=" + productName + ", productPrice=" + productPrice
				+ ", productAmount=" + productAmount + ", productIntro=" + productIntro + ", productRegDate="
				+ productRegDate + ", cateCode=" + cateCode + ", cateName=" + cateName + ", productImg=" + productImg
				+ "]";
	}

	
	

	


	






	


	
	
	
	
}
