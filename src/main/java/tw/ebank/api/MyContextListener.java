package tw.ebank.api;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class MyContextListener implements ServletContextListener {
    
    public void contextInitialized(ServletContextEvent sce) {
        // 初始化資料庫連接池
        ConnectionPool connectionPool = new ConnectionPool();

        // 將連接池物件保存在 ServletContext 中
        ServletContext servletContext = sce.getServletContext();
        servletContext.setAttribute("connectionPool", connectionPool);
    }
    
    public void contextDestroyed(ServletContextEvent sce) {
        // 程式停止時釋放資料庫連接池資源
        ConnectionPool connectionPool = (ConnectionPool) sce.getServletContext().getAttribute("connectionPool");
        connectionPool.destroy();
    }
}
