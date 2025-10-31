from lxml import etree

# Đọc và parse file XML
tree = etree.parse('quanlykho.xml')
root = tree.getroot()

# 1. Lấy tất cả sản phẩm còn tồn kho dưới 30
print("1. Sản phẩm tồn kho thấp (< 30):")
low_stock = root.xpath("//KE[TONKHO < 30]")
for item in low_stock:
    masp = item.find('MASP').text
    product_name = root.xpath(f"//SANPHAM[MASP='{masp}']/TENSP")[0].text
    stock = item.find('TONKHO').text
    print(f"- {product_name}: {stock} cái")

# 2. Lấy phiếu nhập hàng trong tháng 1/2024
print("\n2. Phiếu nhập hàng tháng 1/2024:")
import_orders = root.xpath("//PHIEU[LOAIPHIEU='nhap' and contains(NGAYNHAP, '2024-01')]")
for order in import_orders:
    supplier_id = order.find('MANCC').text
    supplier_name = root.xpath(f"//NHACUNGCAP[MANCC='{supplier_id}']/TENNCC")[0].text
    print(f"- {order.find('MAPHIEU').text}: {supplier_name} - {order.find('TONGTIEN').text} VNĐ")

# 3. Lấy sản phẩm của nhà cung cấp Apple
print("\n3. Sản phẩm từ nhà cung cấp Apple:")
apple_products = root.xpath("//SANPHAM[HANG='Apple']")
for product in apple_products:
    price = int(product.find('GIABAN').text)
    print(f"- {product.find('TENSP').text}: {price:,} VNĐ")

# 4. Lấy chi tiết các phiếu xuất kho
print("\n4. Chi tiết phiếu xuất kho:")
export_details = root.xpath("//CHITIETPHIEU[starts-with(MAPHIEU, 'PX')]")
for detail in export_details:
    product_id = detail.find('MASP').text
    product_name = root.xpath(f"//SANPHAM[MASP='{product_id}']/TENSP")[0].text
    quantity = detail.find('SOLUONG').text
    price = int(detail.find('GIA').text)
    print(f"- {product_name}: {quantity} x {price:,} VNĐ")

# 5. Lấy thông tin kệ hàng theo vị trí
print("\n5. Sản phẩm ở khu vực A:")
zone_a = root.xpath("//KE[contains(VITRI, 'Khu A')]")
for item in zone_a:
    product_id = item.find('MASP').text
    product_name = root.xpath(f"//SANPHAM[MASP='{product_id}']/TENSP")[0].text
    location = item.find('VITRI').text
    stock = item.find('TONKHO').text
    print(f"- {product_name}: {stock} cái tại {location}")

# 6. Lấy nhân viên và số phiếu đã xử lý
print("\n6. Nhân viên và số phiếu đã xử lý:")
employees = root.xpath("//NHANVIEN")
for emp in employees:
    emp_id = emp.find('MANV').text
    emp_name = emp.find('TENNV').text
    order_count = len(root.xpath(f"//PHIEU[MANV='{emp_id}']"))
    print(f"- {emp_name}: {order_count} phiếu")

# 7. Lấy sản phẩm theo danh mục
print("\n7. Sản phẩm theo danh mục Điện Thoại:")
phone_products = root.xpath("//SANPHAM[MADM='DM001']")
for product in phone_products:
    color = product.find('MAUSAC').text
    size = product.find('KICHTHUOC').text
    print(f"- {product.find('TENSP').text} ({color}, {size})")

# 8. Lấy tổng số lượng nhập/xuất theo sản phẩm
print("\n8. Tổng nhập/xuất sản phẩm:")
products = root.xpath("//SANPHAM")[:3]  # Lấy 3 sản phẩm đầu để demo
for product in products:
    product_id = product.find('MASP').text
    product_name = product.find('TENSP').text
    
    total_import = sum(int(x.find('SOLUONG').text) for x in 
                      root.xpath(f"//CHITIETPHIEU[MASP='{product_id}' and starts-with(MAPHIEU, 'PN')]"))
    
    total_export = sum(int(x.find('SOLUONG').text) for x in 
                      root.xpath(f"//CHITIETPHIEU[MASP='{product_id}' and starts-with(MAPHIEU, 'PX')]"))
    
    print(f"- {product_name}: Nhập {total_import}, Xuất {total_export}")