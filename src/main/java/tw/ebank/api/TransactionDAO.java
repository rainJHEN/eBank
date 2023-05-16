package tw.ebank.api;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {

    private Connection conn;

    public TransactionDAO(Connection conn) {
        this.conn = conn;
    }

    public List<TransactionRecord> getTransactionsByAccountAndDate(String account, Date startDate, Date endDate) throws SQLException {
        List<TransactionRecord> transactions = new ArrayList<>();
        String sql = "SELECT \r\n"
        		+ "        transOutNTRecord.transTime as transTime,\r\n"
        		+ "        '轉出' as summary,\r\n"
        		+ "        transOutNTRecord.NTAccount as ChangeBalanceAccount, \r\n"
        		+ "        transOutNTRecord.transNTAmount as expenses, \r\n"
        		+ "        null as TransferIn, \r\n"
        		+ "        transOutNTRecord.transNTBalance as Balance, \r\n"
        		+ "        transOutNTRecord.transNum as transNum,\r\n"
        		+ "        transInNTRecord.NTAccount as transInOutAcc,\r\n"
        		+ "        transOutNTRecord.other as other\r\n"
        		+ "   FROM transOutNTRecord \r\n"
        		+ "   WHERE transOutNTRecord.NTAccount = ?\r\n"
        		+ "   AND transOutNTRecord.transTime BETWEEN ? AND ?";
        

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, account);
            ps.setDate(2, startDate);
            ps.setDate(3, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                	TransactionRecord transaction = new TransactionRecord();
                    transaction.setTransTime(rs.getString("transTime"));
                    transaction.setSummary(rs.getString("summary"));
                    transaction.setChangeBalanceAccount(rs.getString("ChangeBalanceAccount"));
                    transaction.setExpenses(rs.getDouble("expenses"));
                    transaction.setTransferIn(rs.getDouble("TransferIn"));
                    transaction.setBalance(rs.getDouble("Balance"));
                    transaction.setTransNum(rs.getString("transNum"));
                    transaction.setTransInOutAcc(rs.getString("transInOutAcc"));
                    transaction.setOther(rs.getString("other"));
                    transactions.add(transaction);
                }
            }
        }
        return transactions;
    }
}
