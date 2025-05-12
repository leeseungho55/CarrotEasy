package kr.or.ddit.prod.type;

public enum ProdType {
    FOR_SALE("FOR_SALE", "판매중"),
    RESERVED("RESERVED", "예약중"),
    SOLD_OUT("SOLD_OUT", "판매완료");
    
    private String code;
    private String description;
    
    ProdType(String code, String description) {
        this.code = code;
        this.description = description;
    }
    
    public String getCode() {
        return code;
    }
    
    public String getDescription() {
        return description;
    }
    
    public static ProdType fromCode(String code) {
        for (ProdType type : ProdType.values()) {
            if (type.getCode() == code) {
                return type;
            }
        }
        return FOR_SALE;
    }
}
