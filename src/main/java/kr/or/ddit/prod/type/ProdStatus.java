package kr.or.ddit.prod.type;

public enum ProdStatus {
    NEW("NEW", "새상품"),
    ALMOST_NEW("ALMOST_NEW", "거의 새것"),
    SLIGHTLY_USED("SLIGHTLY_USED", "사용감 있음"),
    USED("USED", "중고");
    
    private String code;
    private String description;
    
    ProdStatus(String code, String description) {
        this.code = code;
        this.description = description;
    }
    
    public String getCode() {
        return code;
    }
    
    public String getDescription() {
        return description;
    }
    
    // code값으로 enum 찾기
    public static ProdStatus fromCode(String code) {
        for (ProdStatus status : ProdStatus.values()) {
            if (status.getCode() == code) {
                return status;
            }
        }
        return null;
    }
}