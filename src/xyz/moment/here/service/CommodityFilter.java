package xyz.moment.here.service;

import xyz.moment.here.dao.CommodityDAO;
import xyz.moment.here.po.Commodity;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommodityFilter {

    //全部商品
    public List<Commodity> allCommodities() throws SQLException, ClassNotFoundException {
        String sql = "select * from commodity";
        return CommodityDAO.selectCommodities(sql);
    }

    //按类别选择商品
    public List<Commodity> typeSelect(String type) throws SQLException, ClassNotFoundException {
        String sql = "select * from commodity natural join commodityType where typeName = '" + type
                +"'";
        return CommodityDAO.selectCommodities(sql);
    }

    //所有上架商品
    public List<Commodity> onSale() throws SQLException, ClassNotFoundException {
        String sql = "select * from commodity where status = 1";
        return CommodityDAO.selectCommodities(sql);
    }

    //所有下架商品
    public List<Commodity> discontinuued() throws SQLException, ClassNotFoundException {
        String sql = "select * from commodity where status = 0";
        return CommodityDAO.selectCommodities(sql);
    }

    //所有被删除的商品
    public List<Commodity> deleted() throws SQLException, ClassNotFoundException {
        String sql = "select * from commodity where status = -1";
        return CommodityDAO.selectCommodities(sql);
    }

    //按CID选商品
    public Commodity getCommodity(String CID) throws SQLException, ClassNotFoundException {
        String sql = "select * from commodity where CID = "+CID;
        return CommodityDAO.queryCommodity(sql);
    }

    //所有商品总库存
    public int totalInventory() throws SQLException, ClassNotFoundException {
        List<Commodity> allCommodities = new ArrayList<>();
        allCommodities = allCommodities();
        int totalInventory = 0;
        for(Commodity commodity : allCommodities) {
            totalInventory += commodity.getInventory();
        }
        return totalInventory;
    }

    //所有商品总售价
    public float totalPrice() throws SQLException, ClassNotFoundException {
        List<Commodity> allCommodities = allCommodities();
        float totalPrice = 0;
        for (Commodity commodity : allCommodities) {
            totalPrice += commodity.getPrice()*commodity.getInventory();
        }
        return totalPrice;
    }

    //所有商品总浏览量
    public int totalViewTime() throws SQLException, ClassNotFoundException {
        int totalViewTime = 0;
        List<Commodity> allCommodities = allCommodities();
        for(Commodity commodity : allCommodities) {
            totalViewTime += commodity.getViewedTime();
        }
        return totalViewTime;
    }


}
