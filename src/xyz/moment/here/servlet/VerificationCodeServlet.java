package xyz.moment.here.servlet;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

@WebServlet(name = "VerificationCodeServlet",urlPatterns = "/VerificationCodeServlet")
public class VerificationCodeServlet extends HttpServlet {
    private static int width=60;
    private static int height=25;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("=======");
        HttpSession session=request.getSession();
        response.setContentType("image/jpeg");
        ServletOutputStream servletOutputStream=response.getOutputStream();
        //设置浏览器不要缓存此图片
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        //创建内存图片并获得其图形上下文
        BufferedImage image=new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics graphics=image.getGraphics();
        //产生随机的验证码
        char[] rands=generCode();
        //产生图像
        drawRands(graphics, rands);
        //结束图像的绘制过程，完成图像
        graphics.dispose();
        //将图像输出到客户端
        ByteArrayOutputStream byteArrayOutputStream=new ByteArrayOutputStream();
        ImageIO.write(image, "JPEG", byteArrayOutputStream);
        byte[] buf=byteArrayOutputStream.toByteArray();
        response.setContentLength(buf.length);
        servletOutputStream.write(buf);
        byteArrayOutputStream.close();
        servletOutputStream.close();

        //将当前的验证码写入到session中
        session.setAttribute("checkcode", new String(rands));
    }
    private char[] generCode(){
        //定义验证码的字符表
        String chars="0123456789abcdefghijklmnopqrstuvwxyz";
        char[] rands=new char[4];
        for(int i=0;i<4;i++){
            int rand=(int)(Math.random()*36);
            rands[i]=chars.charAt(rand);
        }
        return rands;
    }
    private void drawRands(Graphics g, char[] rands){
        /*g.setRenderingHint(RenderingHints.KEY_STROKE_CONTROL,RenderingHints.VALUE_STROKE_DEFAULT);;//解决模糊
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,RenderingHints.VALUE_ANTIALIAS_ON);*/
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, width, height);
        g.setColor(Color.RED);
        g.setFont(new Font(null, Font.ITALIC|Font.BOLD, 18));
        //在不同高度上输出验证码的每个字符
        g.drawString(""+rands[0], 1, 17);
        g.setColor(Color.CYAN);
        g.drawString(""+rands[1], 16, 15);
        g.setColor(Color.green);
        g.drawString(""+rands[2], 31, 18);
        g.setColor(Color.lightGray);
        g.drawString(""+rands[3], 46, 16);
        System.out.println(rands);

    }
}
