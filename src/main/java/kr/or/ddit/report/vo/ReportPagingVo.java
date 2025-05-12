package kr.or.ddit.report.vo;

public class ReportPagingVo {

	private int memNo; 
    private int page;           // 현재 페이지 번호
    private int pageSize;       // 페이지당 게시글 수
    private int totalCount;     // 전체 게시글 수
    private int startRow;       // 현재 페이지의 시작 행 번호 (for SQL)
    private int endRow;         // 현재 페이지의 끝 행 번호 (for SQL)

    // 기본 생성자
    public ReportPagingVo() {}

    public void setMemNo(int memNo) {
        this.memNo = memNo; 
    }

    public int getMemNo() {
    	return memNo;
    }
    
    // Getter / Setter
    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
        updateRows();
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
        updateRows();
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public int getStartRow() {
        return startRow;
    }

    public int getEndRow() {
        return endRow;
    }

    // 행 번호 계산 메서드
    private void updateRows() {
        if (page > 0 && pageSize > 0) {
            this.startRow = (page - 1) * pageSize + 1;
            this.endRow = page * pageSize;
        } else {
            this.startRow = 0;
            this.endRow = 0;
        }
    }

    @Override
    public String toString() {
        return "ReportPagingVo{" +
                "page=" + page +
                ", pageSize=" + pageSize +
                ", totalCount=" + totalCount +
                ", startRow=" + startRow +
                ", endRow=" + endRow +
                '}';
    }
}
