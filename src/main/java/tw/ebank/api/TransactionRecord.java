//Java Bean 範例

package tw.ebank.api;

public class TransactionRecord {
    private String transTime;
    private String summary;
    private String changeBalanceAccount;
    private Double expenses;
    private Double transferIn;
    private Double balance;
    private String transNum;
    private String transInOutAcc;
    private String other;
    
    public String getTransTime() {
        return transTime;
    }
    
    public void setTransTime(String transTime) {
        this.transTime = transTime;
    }
    
    public String getSummary() {
        return summary;
    }
    
    public void setSummary(String summary) {
        this.summary = summary;
    }
    
    public String getChangeBalanceAccount() {
        return changeBalanceAccount;
    }
    
    public void setChangeBalanceAccount(String changeBalanceAccount) {
        this.changeBalanceAccount = changeBalanceAccount;
    }
    
    public Double getExpenses() {
        return expenses;
    }
    
    public void setExpenses(Double expenses) {
        this.expenses = expenses;
    }
    
    public Double getTransferIn() {
        return transferIn;
    }
    
    public void setTransferIn(Double transferIn) {
        this.transferIn = transferIn;
    }
    
    public Double getBalance() {
        return balance;
    }
    
    public void setBalance(Double balance) {
        this.balance = balance;
    }
    
    public String getTransNum() {
        return transNum;
    }
    
    public void setTransNum(String transNum) {
        this.transNum = transNum;
    }
    
    public String getTransInOutAcc() {
        return transInOutAcc;
    }
    
    public void setTransInOutAcc(String transInOutAcc) {
        this.transInOutAcc = transInOutAcc;
    }
    
    public String getOther() {
        return other;
    }
    
    public void setOther(String other) {
        this.other = other;
    }
}
