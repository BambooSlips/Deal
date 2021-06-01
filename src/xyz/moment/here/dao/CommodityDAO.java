package xyz.moment.here.dao;

import xyz.moment.here.po.Commodity;
import xyz.moment.here.util.DBClient;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.DateTimeException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CommodityDAO {
    public static DBClient database = new DBClient("leaf","123456789",
            "jdbc:mysql://localhost:3306/myshop");

    public static Commodity queryCommodity(String sql) throws SQLException, ClassNotFoundException {
        Commodity commodity = new Commodity();
        ResultSet resultSet = database.query(sql, database.getConnection());
        while (resultSet.next()){
            commodity.setCID(resultSet.getString("CID"));
            commodity.setName(resultSet.getString("name"));
            commodity.setPrice(resultSet.getFloat("price"));
            //commodity.setPrice_prior(resultSet.getString("price_prior"));
            commodity.setPublishedDate(resultSet.getDate("publishedDate"));
            commodity.setInventory(resultSet.getInt("inventory"));
            commodity.setViewedTime(resultSet.getInt("viewedTime"));
            commodity.setPhoto(resultSet.getString("photo"));
            commodity.setStatus(resultSet.getInt("status"));
            commodity.setDescription(resultSet.getString("description"));
            commodity.setTID(resultSet.getString("TID"));
        }
        return commodity;
    }

    public static List<Commodity> queryAllCommodities() throws SQLException, ClassNotFoundException {
        List<Commodity> allCommodities = new ArrayList<Commodity>();
        String sql = "select * from commodity;";
        ResultSet resultSet = database.query(sql, database.getConnection());
        while (resultSet.next()){
            Commodity commodity = new Commodity();
            commodity.setCID(resultSet.getString("CID"));
            commodity.setName(resultSet.getString("name"));
            commodity.setPrice(resultSet.getInt("price"));
            //commodity.setPrice_prior(resultSet.getString("price_prior"));
            commodity.setPublishedDate(resultSet.getDate("publishedDate"));
            commodity.setInventory(resultSet.getInt("inventory"));
            commodity.setViewedTime(resultSet.getInt("viewedTime"));
            commodity.setPhoto(resultSet.getString("photo"));
            commodity.setStatus(resultSet.getInt("status"));
            commodity.setDescription(resultSet.getString("description"));
            commodity.setTID(resultSet.getString("TID"));
            allCommodities.add(commodity);
        }
        return allCommodities;
    }

    public static List<Commodity> selectCommodities(String sql) throws SQLException, ClassNotFoundException {
        List<Commodity> selectedCommodities = new ArrayList<>();
        ResultSet resultSet = database.query(sql, database.getConnection());
        while (resultSet.next()) {
            Commodity commodity = new Commodity();
            commodity.setCID(resultSet.getString("CID"));
            commodity.setName(resultSet.getString("name"));
            commodity.setPrice(resultSet.getFloat("price"));
            //System.out.println(resultSet.getFloat("price")+"/"+commodity.getPrice());
            //commodity.setPrice_prior(resultSet.getString("price_prior"));
            commodity.setPublishedDate(resultSet.getDate("publishedDate"));
            commodity.setInventory(resultSet.getInt("inventory"));
            commodity.setViewedTime(resultSet.getInt("viewedTime"));
            commodity.setPhoto(resultSet.getString("photo"));
            commodity.setStatus(resultSet.getInt("status"));
            commodity.setDescription(resultSet.getString("description"));
            commodity.setTID(resultSet.getString("TID"));
            selectedCommodities.add(commodity);
        }
        return selectedCommodities;
    }

    public static void addCommodity(int TID, String name, float price, int inventory, String description, String photo, int status) throws SQLException, ClassNotFoundException {
        String sql = "insert into commodity(CID,TID,IID,name,publishedDate, price, inventory, viewedTime, description," +
                " photo, status) values(right(RAND(),9),"+TID+", null, '"+name+"', current_timestamp(), "+price+", "+inventory+", null, '"+description +"', '"+photo+"',"+status+")";

        System.out.println(sql);
        database.execute(sql,database.getConnection());
        System.out.println("添加成功！");
    }

    public static void updateCommodity(Commodity commodity) throws SQLException, ClassNotFoundException {
        String sql = "update commodity set TID="+commodity.getTID()+",name='"+commodity.getName()+"', price="+commodity.getPrice()+", viewedTime="+commodity.getViewedTime()+",inventory="
                +commodity.getInventory()+",description='"+commodity.getDescription()+"', photo='"+commodity.getPhoto()+"', status="+commodity.getStatus()+" where CID="+
                commodity.getCID();
        System.out.println(sql);
        database.execute(sql,database.getConnection());
        System.out.println("修改成功！");
    }
}
