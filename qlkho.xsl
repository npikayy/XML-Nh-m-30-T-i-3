<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  
  
  <!-- Template gốc -->
  <xsl:template match="/">
    <html>
      <head>
        <title>Quản lý Kho</title>
        <style>
          table {
          border-collapse: collapse;
          width: 100%;
          margin-bottom: 25px;
          }
          th, td {
          border: 1px solid black;
          padding: 8px;
          text-align: left;
          }
          th {
          background-color: #f2f2f2;
          }
          .money { text-align: right; }
          .center { text-align: center; }
          .table-title {
          font-weight: bold;
          font-size: 16px;
          margin: 15px 0 10px 0;
          color: #2c3e50;
          }
          h1 {
          text-align: center;
          color: #34495e;
          }
          body {
          font-family: Arial, sans-serif;
          margin: 20px;
          }
        </style>
      </head>
      <body>
        <h1>QUẢN LÝ KHO HÀNG</h1>
        
        <!-- 1. DANH MỤC -->
        <div class="table-container">
          <div class="table-title">1. Danh sách danh mục sản phẩm</div>
          <table>
            <tr>
              <th>STT</th><th>Mã DM</th><th>Tên DM</th><th>Mô tả</th>
            </tr>
            <xsl:apply-templates select="QUANLYKHO/DANHMUC"/>
          </table>
        </div>
        
        <!-- 2. SẢN PHẨM -->
        <div class="table-container">
          <div class="table-title">2. Danh sách sản phẩm</div>
          <table>
            <tr>
              <th>STT</th><th>Mã SP</th><th>Tên SP</th><th>Hãng</th><th>Giá nhập</th><th>Giá bán</th><th>Tồn kho</th>
            </tr>
            <xsl:apply-templates select="QUANLYKHO/SANPHAM" mode="sanpham-list"/>
          </table>
        </div>
        
        <!-- 3. NHÀ CUNG CẤP -->
        <div class="table-container">
          <div class="table-title">3. Danh sách nhà cung cấp</div>
          <table>
            <tr>
              <th>STT</th><th>Mã NCC</th><th>Tên NCC</th><th>Địa chỉ</th><th>SĐT</th><th>Email</th>
            </tr>
            <xsl:apply-templates select="QUANLYKHO/NHACUNGCAP"/>
          </table>
        </div>
        
        <!-- 4. NHÂN VIÊN -->
        <div class="table-container">
          <div class="table-title">4. Danh sách nhân viên</div>
          <table>
            <tr>
              <th>STT</th><th>Mã NV</th><th>Tên NV</th><th>SĐT</th><th>Tài khoản</th>
            </tr>
            <xsl:apply-templates select="QUANLYKHO/NHANVIEN"/>
          </table>
        </div>
        
        <!-- 5. SẢN PHẨM APPLE -->
        <div class="table-container">
          <div class="table-title">5. Sản phẩm của Apple</div>
          <table>
            <tr>
              <th>STT</th><th>Mã SP</th><th>Tên SP</th><th>Giá bán</th><th>Kích thước</th><th>Màu sắc</th>
            </tr>
            <xsl:apply-templates select="QUANLYKHO/SANPHAM[HANG='Apple']" mode="apple-products"/>
          </table>
        </div>
        
        <!-- 6. SẢN PHẨM GIÁ CAO -->
        <div class="table-container">
          <div class="table-title">6. Sản phẩm có giá bán trên 20,000,000 VND</div>
          <table>
            <tr>
              <th>STT</th><th>Mã SP</th><th>Tên SP</th><th>Hãng</th><th>Giá bán</th>
            </tr>
            <xsl:apply-templates select="QUANLYKHO/SANPHAM[GIABAN &gt; 20000000]" mode="high-price"/>
          </table>
        </div>
        
        <!-- 7. PHIẾU NHẬP PN001 -->
        <div class="table-container">
          <div class="table-title">7. Thông tin phiếu nhập PN001</div>
          <table>
            <tr>
              <th>STT</th><th>Mã phiếu</th><th>Nhà cung cấp</th><th>Nhân viên</th><th>Ngày nhập</th><th>Tổng tiền</th>
            </tr>
            <xsl:apply-templates select="QUANLYKHO/PHIEU[MAPHIEU='PN001']" mode="phieu-info"/>
          </table>
        </div>
        
        <!-- 8. CHI TIẾT PHIẾU NHẬP -->
        <div class="table-container">
          <div class="table-title">8. Chi tiết phiếu nhập PN001</div>
          <table>
            <tr>
              <th>STT</th><th>Mã SP</th><th>Tên SP</th><th>Số lượng</th><th>Đơn giá</th><th>Thành tiền</th>
            </tr>
            <xsl:apply-templates select="QUANLYKHO/CHITIETPHIEU[MAPHIEU='PN001']" mode="ctpn-detail"/>
          </table>
        </div>
        
        <!-- 9. TỒN KHO -->
        <div class="table-container">
          <div class="table-title">9. Thống kê tồn kho theo sản phẩm</div>
          <table>
            <tr>
              <th>STT</th><th>Mã SP</th><th>Tên SP</th><th>Số lượng tồn</th><th>Vị trí</th><th>Ngày cập nhật</th>
            </tr>
            <xsl:apply-templates select="QUANLYKHO/KE" mode="tonkho"/>
          </table>
        </div>
        
        <!-- 10. TỔNG SỐ LƯỢNG -->
        <div class="table-container">
          <div class="table-title">10. Tổng số lượng sản phẩm trong kho</div>
          <table>
            <tr><th>STT</th><th>Tổng sản phẩm</th><th>Tổng tồn kho</th></tr>
            <tr>
              <td class="center">1</td>
              <td class="center"><xsl:value-of select="count(QUANLYKHO/SANPHAM)"/></td>
              <td class="center"><xsl:value-of select="sum(QUANLYKHO/KE/TONKHO)"/></td>
            </tr>
          </table>
        </div>
        
        <!-- 11. PHIẾU CỦA NHÂN VIÊN -->
        <div class="table-container">
          <div class="table-title">11. Số phiếu nhập của nhân viên NV001</div>
          <table>
            <tr><th>STT</th><th>Mã NV</th><th>Tên NV</th><th>Số phiếu nhập</th></tr>
            <tr>
              <td class="center">1</td>
              <td>NV001</td>
              <td><xsl:value-of select="QUANLYKHO/NHANVIEN[MANV='NV001']/TENNV"/></td>
              <td class="center"><xsl:value-of select="count(QUANLYKHO/PHIEU[MANV='NV001' and LOAIPHIEU='nhap'])"/></td>
            </tr>
          </table>
        </div>
        
        <!-- 12. SẢN PHẨM CỦA NCC APPLE -->
        <div class="table-container">
          <div class="table-title">12. Danh sách sản phẩm của nhà cung cấp Apple</div>
          <table>
            <tr><th>STT</th><th>Mã SP</th><th>Tên SP</th><th>Giá bán</th><th>Tồn kho</th></tr>
            <xsl:apply-templates select="QUANLYKHO/SANPHAM[HANG='Apple']" mode="ncc-apple"/>
          </table>
        </div>
        
        <!-- 13. GIÁ TRỊ TỒN KHO THEO HÃNG -->
        <!-- <div class="table-container">
          <div class="table-title">13. Tổng giá trị tồn kho theo hãng</div>
          <table>
            <tr><th>STT</th><th>Hãng</th><th>Số sản phẩm</th><th>Tổng giá trị tồn kho</th></tr>
            <xsl:for-each select="QUANLYKHO/SANPHAM[generate-id()=generate-id(key('', HANG)[1])]">
              <xsl:variable name="hang" select="HANG"/>
              <xsl:variable name="tongGiaTri"
                select="sum(/QUANLYKHO/SANPHAM[HANG=$hang]/GIANHAP *
                    /QUANLYKHO/KE[MASP=/QUANLYKHO/SANPHAM[HANG=$hang]/MASP]/TONKHO)"/>
              <tr>
                <td class='center'><xsl:value-of select="position()"/></td>
                <td><xsl:value-of select="HANG"/></td>
                <td class='center'><xsl:value-of select="count(/QUANLYKHO/SANPHAM[HANG=$hang])"/></td>
                <td class='money'><xsl:value-of select="format-number($tongGiaTri, '#,##0')"/> VND</td>
              </tr>
            </xsl:for-each>
          </table>
        </div> -->
        
        <!-- 13. CHI TIẾT PHIẾU XUẤT -->
        <div class="table-container">
          <div class="table-title">13. Chi tiết phiếu xuất PX001</div>
          <table>
            <tr><th>STT</th><th>Mã SP</th><th>Tên SP</th><th>Giá bán</th><th>Số lượng</th><th>Thành tiền</th></tr>
            <xsl:apply-templates select="QUANLYKHO/CHITIETPHIEU[MAPHIEU='PX001']" mode="ctpx-detail"/>
            <xsl:for-each select="QUANLYKHO/PHIEU[MAPHIEU='PX001']">
              <tr>
                <td colspan="5" style="text-align:right;font-weight:bold;">Tổng cộng:</td>
                <td class="money" style="font-weight:bold;">
                  <xsl:value-of select="format-number(TONGTIEN, '#,##0')"/> VND
                </td>
              </tr>
            </xsl:for-each>
          </table>
        </div>
        
        <!-- 14. PHIẾU XUẤT PX001 -->
        <div class="table-container">
          <div class="table-title">14. Thông tin phiếu xuất PX001</div>
          <table>
            <tr>
              <th>STT</th><th>Mã phiếu</th><th>Nhà cung cấp</th><th>Nhân viên</th><th>Ngày xuất</th><th>Tổng tiền</th><th>Ghi chú</th>
            </tr>
            <xsl:apply-templates select="QUANLYKHO/PHIEU[MAPHIEU='PX001']" mode="phieuxuat-info"/>
          </table>
        </div>
        
        <!-- 15. CHI TIẾT PHIẾU XUẤT PX001 -->
        <div class="table-container">
          <div class="table-title">15. Chi tiết phiếu xuất PX001</div>
          <table>
            <tr>
              <th>STT</th><th>Mã SP</th><th>Tên SP</th><th>Số lượng</th><th>Đơn giá</th><th>Thành tiền</th>
            </tr>
            <xsl:apply-templates select="QUANLYKHO/CHITIETPHIEU[MAPHIEU='PX001']" mode="ctxuat-detail"/>
          </table>
        </div>

      </body>
    </html>
  </xsl:template>
  
  <!-- Các template con -->
  <xsl:template match="DANHMUC">
    <tr><td class="center"><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="MADM"/></td>
      <td><xsl:value-of select="TENDM"/></td>
      <td><xsl:value-of select="MOTA"/></td></tr>
  </xsl:template>
  
  <xsl:template match="SANPHAM" mode="sanpham-list">
    <tr>
      <td class="center"><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="MASP"/></td>
      <td><xsl:value-of select="TENSP"/></td>
      <td><xsl:value-of select="HANG"/></td>
      <td class="money"><xsl:value-of select="format-number(GIANHAP,'#,##0')"/> VND</td>
      <td class="money"><xsl:value-of select="format-number(GIABAN,'#,##0')"/> VND</td>
      <td class="center"><xsl:value-of select="/QUANLYKHO/KE[MASP=current()/MASP]/TONKHO"/></td>
    </tr>
  </xsl:template>
  
  <xsl:template match="NHACUNGCAP">
    <tr>
      <td class="center"><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="MANCC"/></td>
      <td><xsl:value-of select="TENNCC"/></td>
      <td><xsl:value-of select="DIACHI"/></td>
      <td><xsl:value-of select="SODT"/></td>
      <td><xsl:value-of select="EMAIL"/></td>
    </tr>
  </xsl:template>
  
  <xsl:template match="NHANVIEN">
    <tr>
      <td class="center"><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="MANV"/></td>
      <td><xsl:value-of select="TENNV"/></td>
      <td><xsl:value-of select="SODT"/></td>
      <td><xsl:value-of select="TAIKHOAN"/></td>
    </tr>
  </xsl:template>
  
  <xsl:template match="SANPHAM" mode="apple-products">
    <tr>
      <td class="center"><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="MASP"/></td>
      <td><xsl:value-of select="TENSP"/></td>
      <td class="money"><xsl:value-of select="format-number(GIABAN,'#,##0')"/> VND</td>
      <td><xsl:value-of select="KICHTHUOC"/></td>
      <td><xsl:value-of select="MAUSAC"/></td>
    </tr>
  </xsl:template>
  
  <xsl:template match="SANPHAM" mode="high-price">
    <tr>
      <td class="center"><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="MASP"/></td>
      <td><xsl:value-of select="TENSP"/></td>
      <td><xsl:value-of select="HANG"/></td>
      <td class="money"><xsl:value-of select="format-number(GIABAN,'#,##0')"/> VND</td>
    </tr>
  </xsl:template>
  
  <xsl:template match="PHIEU" mode="phieu-info">
    <tr>
      <td class="center">1</td>
      <td><xsl:value-of select="MAPHIEU"/></td>
      <td><xsl:value-of select="/QUANLYKHO/NHACUNGCAP[MANCC=current()/MANCC]/TENNCC"/></td>
      <td><xsl:value-of select="/QUANLYKHO/NHANVIEN[MANV=current()/MANV]/TENNV"/></td>
      <td><xsl:value-of select="NGAYNHAP"/></td>
      <td class="money"><xsl:value-of select="format-number(TONGTIEN,'#,##0')"/> VND</td>
    </tr>
  </xsl:template>
  
  <xsl:template match="CHITIETPHIEU" mode="ctpn-detail">
    <tr>
      <td class="center"><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="MASP"/></td>
      <td><xsl:value-of select="/QUANLYKHO/SANPHAM[MASP=current()/MASP]/TENSP"/></td>
      <td class="center"><xsl:value-of select="SOLUONG"/></td>
      <td class="money"><xsl:value-of select="format-number(GIA,'#,##0')"/> VND</td>
      <td class="money"><xsl:value-of select="format-number(SOLUONG*GIA,'#,##0')"/> VND</td>
    </tr>
  </xsl:template>
  
  <xsl:template match="KE" mode="tonkho">
    <tr>
      <td class="center"><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="MASP"/></td>
      <td><xsl:value-of select="/QUANLYKHO/SANPHAM[MASP=current()/MASP]/TENSP"/></td>
      <td class="center"><xsl:value-of select="TONKHO"/></td>
      <td><xsl:value-of select="VITRI"/></td>
      <td><xsl:value-of select="NGAYCAPNHAT"/></td>
    </tr>
  </xsl:template>
  
  <xsl:template match="SANPHAM" mode="ncc-apple">
    <tr>
      <td class="center"><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="MASP"/></td>
      <td><xsl:value-of select="TENSP"/></td>
      <td class="money"><xsl:value-of select="format-number(GIABAN,'#,##0')"/> VND</td>
      <td class="center"><xsl:value-of select="/QUANLYKHO/KE[MASP=current()/MASP]/TONKHO"/></td>
    </tr>
  </xsl:template>
  
  <xsl:template match="CHITIETPHIEU" mode="ctpx-detail">
    <tr>
      <td class="center"><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="MASP"/></td>
      <td><xsl:value-of select="/QUANLYKHO/SANPHAM[MASP=current()/MASP]/TENSP"/></td>
      <td class="money"><xsl:value-of select="format-number(/QUANLYKHO/SANPHAM[MASP=current()/MASP]/GIABAN,'#,##0')"/> VND</td>
      <td class="center"><xsl:value-of select="SOLUONG"/></td>
      <td class="money">
        <xsl:variable name="giaban" select="/QUANLYKHO/SANPHAM[MASP=current()/MASP]/GIABAN"/>
        <xsl:value-of select="format-number($giaban*SOLUONG,'#,##0')"/> VND
      </td>
    </tr>
  </xsl:template>
  
  <!-- Template hiển thị thông tin Phiếu Xuất -->
  <xsl:template match="PHIEU" mode="phieuxuat-info">
    <tr>
      <td class="center">1</td>
      <td><xsl:value-of select="MAPHIEU"/></td>
      <td><xsl:value-of select="/QUANLYKHO/NHACUNGCAP[MANCC=current()/MANCC]/TENNCC"/></td>
      <td><xsl:value-of select="/QUANLYKHO/NHANVIEN[MANV=current()/MANV]/TENNV"/></td>
      <td><xsl:value-of select="NGAYNHAP"/></td>
      <td class="money"><xsl:value-of select="format-number(TONGTIEN, '#,###')"/></td>
      <td><xsl:value-of select="MOTA"/></td>
    </tr>
  </xsl:template>
  
  <!-- Template hiển thị Chi tiết Phiếu Xuất -->
  <xsl:template match="CHITIETPHIEU" mode="ctxuat-detail">
    <tr>
      <td class="center"><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="MASP"/></td>
      <td><xsl:value-of select="/QUANLYKHO/SANPHAM[MASP=current()/MASP]/TENSP"/></td>
      <td class="center"><xsl:value-of select="SOLUONG"/></td>
      <td class="money"><xsl:value-of select="format-number(GIA, '#,###')"/></td>
      <td class="money">
        <xsl:value-of select="format-number(SOLUONG * GIA, '#,###')"/>
      </td>
    </tr>
  </xsl:template>

  
</xsl:stylesheet>
