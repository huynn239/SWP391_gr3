Create database shopOnline
use shopOnline
CREATE TABLE user_roles (
  ID VARCHAR(255) NOT NULL,
  RoleName VARCHAR(255) NOT NULL, -- Tên vai trò (ví dụ: Admin, Customer)
  PRIMARY KEY (ID)
);
INSERT INTO user_roles (ID, RoleName)
VALUES 
  ('1', 'Admin'),
  ('2', 'Marketing'),
  ('3', 'Sale'),
  ('4', 'Customer');


CREATE TABLE users (
  ID INT IDENTITY(1,1) NOT NULL,
  uName NVARCHAR(255) NOT NULL,
  Username VARCHAR(255) NOT NULL,
  Password VARCHAR(255) NOT NULL,
  Avatar VARCHAR(255) ,
  Gender VARCHAR(255) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  Mobile VARCHAR(255) ,
  uAddress NVARCHAR(255),
  RoleID VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT users_fk_roles FOREIGN KEY (RoleID) REFERENCES user_roles (ID)
) 

INSERT INTO users (uName, Username, Password, Avatar, Gender, Email, Mobile, uAddress, RoleID)
VALUES
(N'Nguyễn Hải Phong', 'bubucon', 'password30', NULL, 'Male', 'phongvg04@gmail.com', '0930000000', N'Hưng Yên', '4'),
(N'Nguyễn Văn Hùng', 'nguyenvanhung', 'password1', NULL, 'Male', 'nguyenvanhung@gmail.com', '0912345678', N'Hà Nội', '4'),
(N'Trần Thị Hoa', 'tranthihoa', 'password2', NULL, 'Female', 'tranthihoa@gmail.com', '0987654321', N'Hồ Chí Minh', '4'),
(N'Lê Minh Tuấn', 'leminhtuan', 'password3', NULL, 'Male', 'leminhtuan@gmail.com', '0934567890', N'Đà Nẵng', '4'),
(N'Phạm Thị Lan', 'phamthilan', 'password4', NULL, 'Female', 'phamthilan@gmail.com', '0923456781', N'Hải Phòng', '4'),
(N'Hoàng Văn Nam', 'hoangvannam', 'password5', NULL, 'Male', 'hoangvannam@gmail.com', '0909876543', N'Cần Thơ', '4'),
(N'Đặng Thị Vân', 'dangthivan', 'password6', NULL, 'Female', 'dangthivan@gmail.com', '0945678901', N'Nghệ An', '4'),
(N'Vũ Đức Thịnh', 'vuducthinh', 'password7', NULL, 'Male', 'vuducthinh@gmail.com', '0934567800', N'Thanh Hóa', '4'),
(N'Ngô Thị Ngọc', 'ngothingoc', 'password8', NULL, 'Female', 'ngothingoc@gmail.com', '0987654322', N'Quảng Ninh', '4'),
(N'Đỗ Văn Long', 'dovanlong', 'password9', NULL, 'Male', 'dovanlong@gmail.com', '0912345800', N'Bắc Ninh', '4'),
(N'Bùi Thị Mai', 'buithimai', 'password10', NULL, 'Female', 'buithimai@gmail.com', '0965432100', N'Lào Cai', '4'),
(N'Nguyễn Thị Hương', 'nguyenthihuong', 'password11', NULL, 'Female', 'nguyenthihuong@gmail.com', '0911111111', N'Hà Giang', '4'),
(N'Trần Văn Bình', 'tranvanbinh', 'password12', NULL, 'Male', 'tranvanbinh@gmail.com', '0912222222', N'Cao Bằng', '4'),
(N'Lê Văn Hải', 'levanhai', 'password13', NULL, 'Male', 'levanhai@gmail.com', '0913333333', N'Tuyên Quang', '4'),
(N'Phạm Thị Thu', 'phamthithu', 'password14', NULL, 'Female', 'phamthithu@gmail.com', '0914444444', N'Bắc Kạn', '4'),
(N'Hoàng Văn Hậu', 'hoangvanhau', 'password15', NULL, 'Male', 'hoangvanhau@gmail.com', '0915555555', N'Lạng Sơn', '4'),
(N'Đặng Thị Hồng', 'dangthihong', 'password16', NULL, 'Female', 'dangthihong@gmail.com', '0916666666', N'Thái Nguyên', '3')




INSERT INTO users (uName, Username, Password, Avatar, Gender, Email, Mobile, uAddress, RoleID)
VALUES
(N'Nguyễn Thị Mai', 'nguyenthimai', 'password2', NULL, 'Female', 'nguyenthimai@gmail.com', '0912345679', N'Hà Nội', '2'),
(N'Trần Minh Tú', 'tranminhtu', 'password3', NULL, 'Female', 'tranminhtu@gmail.com', '0912345680', N'Hồ Chí Minh', '2'),
(N'Phạm Quang Huy', 'phamquanghuy', 'password4', NULL, 'Male', 'phamquanghuy@gmail.com', '0912345681', N'Đà Nẵng', '2');

INSERT INTO users (uName, Username, Password, Avatar, Gender, Email, Mobile, uAddress, RoleID)
VALUES
('Lê Văn An', 'levanan', 'password5', NULL, 'Male', 'levanan@gmail.com', '0912345682', 'Hà Nội', '1');

UPDATE users
SET Password = '+YbybiBa9lafGMKw3bPeUYvSePk='



CREATE TABLE categoryblog (
  ID INT NOT NULL,
  Name NVARCHAR(255) NOT NULL,
  Description NVARCHAR(255) ,
  PRIMARY KEY (ID)
) 

CREATE TABLE blog (
  ID VARCHAR(255) NOT NULL,
  Title NVARCHAR(255) NOT NULL,
  Content NVARCHAR(255),
  UploadDate VARCHAR(255) NOT NULL,
  UploadTime VARCHAR(255) NOT NULL,
  UsersID int NOT NULL,
  CateID INT NOT NULL,
  BlogImage VARCHAR(255),
  PRIMARY KEY (ID),
  FOREIGN KEY (UsersID) REFERENCES users (ID),
  FOREIGN KEY (CateID) REFERENCES categoryblog (ID)
) 


-- Tạo bảng branch
CREATE TABLE brand (
  ID VARCHAR(255) NOT NULL,
  Name NVARCHAR(255) NOT NULL,
  PRIMARY KEY (ID)
);

insert into brand(ID,Name) VALUES
('br1','COOLMATE'),
('br2','TORANO')

-- Tạo bảng type
CREATE TABLE Category (
  ID INT IDENTITY(1,1) NOT NULL,
  Name NVARCHAR(255) NOT NULL,
  PRIMARY KEY (ID)
);

insert into Category(Name) VALUES
(N'Áo thun'),
(N'Áo sơ mi'),
(N'Áo nỉ'),
(N'Áo Polo'),
(N'Áo khoác'),
(N'Áo dài tay'),
(N'Áo thể thao'),
(N'Quần shorts'),
(N'Quần jean'),
(N'Quần kaki'),
(N'Quần jogger'),
(N'Quần thể thao')



CREATE TABLE Material (
    ID_Material INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính tự tăng
    Name NVARCHAR(255) NOT NULL, -- Tên chất liệu
);

Insert into Material(Name) values
(N'Vải Cafe'),
(N'Vải Cotton'),
(N'Vải Polyester'),
(N'Vải Polyamide')


CREATE TABLE Size (
    ID_Size INT IDENTITY(1,1) PRIMARY KEY,
    SizeName NVARCHAR(10) NOT NULL -- Ví dụ: 'S', 'M', 'L', 'XL'
);

INSERT INTO Size (SizeName) VALUES 
(N'S'),
(N'M'),
(N'L'),
(N'XL');

CREATE TABLE Color (
    ID_Color INT PRIMARY KEY IDENTITY(1,1),
    ColorName NVARCHAR(50) NOT NULL
);
INSERT INTO Color (ColorName) VALUES 
(N'Đen'),
(N'Xám'),
(N'Trắng'),
(N'Be'),
(N'Đỏ'),
(N'Cam'),
(N'Vàng'),
(N'Nâu'),
(N'Xanh sáng'),
(N'Xanh đậm'),
(N'Xanh lá')
CREATE TABLE Product (
  ID INT IDENTITY(1,1) NOT NULL,
  Name NVARCHAR(255) NOT NULL,
  Image VARCHAR(255) DEFAULT NULL,
  MaterialID INT NOT NULL,
  Price INT NOT NULL,
  Details NVARCHAR(255) NOT NULL,
  BrandID VARCHAR(255) NOT NULL,
  TypeID INT NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (BrandID) REFERENCES Brand(ID),
  FOREIGN KEY (TypeID) REFERENCES Category(ID),
  FOREIGN KEY (MaterialID) REFERENCES Material(ID_Material)
);

CREATE TABLE ProductSize (
    ProductID INT NOT NULL,
    SizeID INT NOT NULL,
    Quantity INT NOT NULL,
	ColorID INT NOT NULL,
    PRIMARY KEY (ProductID, SizeID, ColorID),
    FOREIGN KEY (ProductID) REFERENCES Product(ID),
    FOREIGN KEY (SizeID) REFERENCES Size(ID_Size)
);



CREATE TABLE ProductImage (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    ColorID INT,
    ImageURL NVARCHAR(255) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product(ID),
    FOREIGN KEY (ColorID) REFERENCES Color(ID_Color)
);
INSERT INTO Product (Name, Image, MaterialID, Price, Details, BrandID, TypeID)  
VALUES  
(N'Áo thun nam Cotton Compact','https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/April2022/denn3-(2)_copy.jpg', 2,  219000,  
 N'Áo thun nam cotton Compact Premium sử dụng chất liệu cotton mềm mại, mang đến cảm giác dễ chịu cho cả ngày dài hoạt động.','br1', 1),
 (N'Áo thun Cotton Trạm Phóng','https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/February2024/mockup4_73.jpg',  2,  233000,  
 N'Áo thun Cotton Trạm Phóng sử dụng chất liệu cotton mềm mại, mang đến cảm giác dễ chịu cho cả ngày dài hoạt động.', 'br1', 1),
 (N'Áo Thun Nam phối Jeans',  'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/May2023/Tee_Copper_den_1A1.jpg',  2,  149000,  
 N'Áo Thun Nam phối Jeans sử dụng chất liệu cotton mềm mại, mang đến cảm giác dễ chịu cho cả ngày dài hoạt động.',  'br1', 1),
 (N'Áo thun Relaxed fit Donald duck',  'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/June2024/2484SW.AT011.13.jpg',  3,  399000,  
 N'Áo thun Relaxed fit Donald duck sử dụng chất liệu mềm mại, mang đến cảm giác dễ chịu cho cả ngày dài hoạt động.',  'br1', 1),
 (N'Áo thun Relaxed fit Donald picnic',  'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/June2024/2484SW.AT009.7.jpg',  3,  309000,  
 N'Áo thun Relaxed fit Donald picnic sử dụng chất liệu mềm mại, mang đến cảm giác dễ chịu cho cả ngày dài hoạt động.',  'br1', 1),
 (N'Áo Thun Oversize',  'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/April2023/shadowAo_thun_oversize__84RISING_logo3.jpg',  1,  219000,  
 N'Áo Thun Oversize sử dụng chất liệu mềm mại, mang đến cảm giác dễ chịu cho cả ngày dài hoạt động.',  'br1', 1),
 (N'Áo Thun Corgi Papa',  'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/September2023/chubby_corgi_pappa-1.jpg',  1,  219000,  
 N'Áo Thun Corgi Papa sử dụng chất liệu mềm mại, mang đến cảm giác dễ chịu cho cả ngày dài hoạt động.',  'br1', 1),
 (N'Áo T shirt họa tiết in Freedom Peace',  'https://product.hstatic.net/200000690725/product/avt_web_1150_x_1475_px___1__8b6c11f3d07043c9b9b897b0e499ee93_master.png',  2,  219000,  
 N'Áo T shirt họa tiết in Freedom Peace thấm hút mồ hôi và thoải mái không gò bó khi vận động.',  'br2', 1),
 (N'Áo T shirt trơn in logo ngực',  'https://product.hstatic.net/200000690725/product/fsts001-bl-4_53542650254_o_879b9a9cca554876822b2df00ca94895_master.jpg',  3, 219000,  
 N'Áo T shirt trơn in logo ngực sử dụng chất liệu cotton mềm mại, mang đến cảm giác dễ chịu cho cả ngày dài hoạt động.',  'br2', 1),
 (N'Áo T shirt họa tiết in Speedhunters',  'https://product.hstatic.net/200000690725/product/53818949638_4c07aa0b47_k_14cc32aecb4246b1938f5d55ddc80f25_master.jpg',  3,  350000,  
 N'Áo T shirt họa tiết in Speedhunters sử dụng chất liệu mềm mại, mang đến cảm giác dễ chịu cho cả ngày dài hoạt động.',  'br2', 1),
 (N'Áo thun Stitch Summer Beach',  'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/March2024/stitchbeach2.jpg',  3,  186000,  
 N'Áo thun Stitch Summer Beach sử dụng chất liệu mềm mại, mang đến cảm giác dễ chịu cho cả ngày dài hoạt động.',  'br2', 1),
 (N'Áo Thun Cat Mama',  'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/September2023/cat_mama-3.jpg',  3,199000,  
 N'Áo Thun Cat Mama sử dụng chất liệu mềm mại, mang đến cảm giác dễ chịu cho cả ngày dài hoạt động.',  'br2', 1)

 INSERT INTO Product (Name, Image, MaterialID, Price, Details, BrandID, TypeID)  
VALUES
(N'Áo Sweater French Terry Oversize','https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/December2024/2484CW.ST002---9999--DO-3D_14.jpg', 4,  219000,  
 N'Áo Sweater French Terry Oversize mang đến khả năng hút ẩm và giữ ấm cho cơ thể tốt','br1', 3),
 (N'Áo Sweater Fleece','https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/November2024/24CMCW.ST002_-_XAM.jpg', 3,  279000,  
 N'Áo Sweater Fleece mang đến khả năng hút ẩm và giữ ấm cho cơ thể tốt','br1', 3),
 (N'Áo Sweater Essential Fleece','https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/December2024/24CMCW.ST003_-_Den_1.jpg', 3,  199000,  
 N'Áo Sweater Essential Fleece mang đến khả năng hút ẩm và giữ ấm cho cơ thể tốt','br1', 3),
 (N'Áo Nỉ chui đầu Essentials','https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/December2023/cmcwst001.2d.3_63.jpg', 4,  199000,  
 N'Áo Nỉ chui đầu Essentials mang đến khả năng hút ẩm và giữ ấm cho cơ thể tốt','br1', 3),
 (N'Áo Nỉ chui đầu Lifewear','https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/October2023/ST002.1_64.jpg', 3,  239000,  
 N'Áo Nỉ chui đầu Lifewear mang đến khả năng hút ẩm và giữ ấm cho cơ thể tốt','br1', 3),
 (N'Áo nỉ Hoodie trơn logo Dog','https://product.hstatic.net/200000690725/product/thiet_ke_chua_co_ten__5__88201915d6a14ffebcb12de74a04b8ce_master.png', 4,  590000,  
 N'Áo nỉ Hoodie trơn logo Dog mang đến khả năng hút ẩm và giữ ấm cho cơ thể tốt','br2', 3),
 (N'Áo nỉ họa tiết logo Glory','https://product.hstatic.net/200000690725/product/thiet_ke_chua_co_ten__4__5b2cf89f7d0648bc958ea2445a096c25_master.png', 3,  450000,  
 N'Áo nỉ họa tiết logo Glory mang đến khả năng hút ẩm và giữ ấm cho cơ thể tốt','br2', 3),
 (N'Áo nỉ trơn vải hiệu ứng','https://product.hstatic.net/200000690725/product/tw006-1_ecce5329a09748cab68e10452e9d6086_master.jpg', 3,  420000,  
 N'Áo nỉ trơn vải hiệu ứng mang đến khả năng hút ẩm và giữ ấm cho cơ thể tốt','br2', 3),
 (N'Áo nỉ bộ can phối tay','https://product.hstatic.net/200000690725/product/19334a78-6cbb-4bbb-abeb-31088b5578ff_ea4d8d95d7fe424297ad95179a26f18b_master.jpg', 3,  319000,  
 N'Áo nỉ bộ can phối tay mang đến khả năng hút ẩm và giữ ấm cho cơ thể tốt','br2', 3),
 (N'Áo nỉ bộ trơn basic','https://product.hstatic.net/200000690725/product/img_2087_53970441694_o_81da21399ff448f6a679479c15fb0f4d_master.jpg', 4,  299000,  
 N'Áo nỉ bộ trơn basic mang đến khả năng hút ẩm và giữ ấm cho cơ thể tốt','br2', 3),
 (N'Áo nỉ can phối màu tay','https://product.hstatic.net/200000690725/product/cbb4526f-41b8-40cf-9e7f-361ff3d3ba63_c620e6b9dbeb49d998d5ec309f8e2ce7_master.jpg', 3,  480000,  
 N'Áo nỉ can phối màu tay mang đến khả năng hút ẩm và giữ ấm cho cơ thể tốt','br2', 3),
 (N'Áo nỉ họa tiết logo Voyage','https://product.hstatic.net/200000690725/product/thiet_ke_chua_co_ten__7__2b3a0259ac0b4407b6d174bdf61a8329_master.png', 3,  450000,  
 N'Áo nỉ họa tiết logo Voyage mang đến khả năng hút ẩm và giữ ấm cho cơ thể tốt','br2', 3)

 INSERT INTO Product (Name, Image, MaterialID, Price, Details, BrandID, TypeID)  
VALUES
(N'Áo sơ mi dài tay cổ tàu Premium Poplin','https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/February2025/ao-so-mi-dai-tay-co-tau-premium-poplin-mau-be_(2).jpg', 2,  399000,  
 N'Áo sơ mi dài tay cổ tàu Premium Poplin mang đến sự lịch lãm nhưng không kém phần thoải mái','br1', 2),
 (N'Áo Sơ Mi Dài Tay Premium Poplin','https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/May2024/poplin11_23.jpg', 1,  599000,  
 N'Áo Sơ Mi Dài Tay Premium Poplin mang đến sự lịch lãm nhưng không kém phần thoải mái','br1', 2),
 (N'Áo Sơ Mi Dài Tay Premium Dobby','https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/May2024/Dobby_Trang_8_copy.jpg', 1,  599000,  
 N'Áo Sơ Mi Dài Tay Premium Dobby mang đến sự lịch lãm nhưng không kém phần thoải mái','br1', 2),
 (N'Áo sơ mi Overshirt 100% Cotton','https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/December2024/24CMCW.SM013_-_Den.jpg', 2,  399000,  
 N'Áo sơ mi Overshirt 100% Cotton mang đến sự lịch lãm nhưng không kém phần thoải mái','br1', 2),
 (N'Áo Sơ Mi Dài Tay Essentials Cotton','https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/October2024/DenBG_(1).png', 2,  399000,  
 N'Áo Sơ Mi Dài Tay Essentials Cotton mang đến sự lịch lãm nhưng không kém phần thoải mái','br1', 2),
 (N'Áo Sơ mi dài tay Café-DriS','https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/May2023/cae24.jpg', 1,  424000,  
 N'Áo Sơ mi dài tay Café-DriS mang đến sự lịch lãm nhưng không kém phần thoải mái','br1', 2),
 (N'Áo sơ mi dài tay kẻ','https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/May2023/cf5.jpg', 3,  500000,  
 N'Áo sơ mi dài tay kẻ mang đến sự lịch lãm nhưng không kém phần thoải mái','br2', 2),
 (N'Áo sơ mi ngắn tay trơn','https://product.hstatic.net/200000690725/product/tb023_69fdbfb524b84453adebc0a742d0fe46_master.png', 3,  380000,  
 N'Áo sơ mi ngắn tay trơn mang đến sự lịch lãm nhưng không kém phần thoải mái','br2', 2),
 (N'Áo sơ mi dài tay trơn dệt kim','https://product.hstatic.net/200000690725/product/tb001_c0675ef2b3a7434696f12bd8905d98e4_master.png', 2,  329000,  
 N'Áo sơ mi dài tay trơn dệt kim mang đến sự lịch lãm nhưng không kém phần thoải mái','br2', 2),
 (N'Áo sơ mi dài tay trơn Bamboo','https://product.hstatic.net/200000690725/product/tb613_0647775913b440d0bedd1f4523a6e55c_master.png', 2,  450000,  
 N'Áo sơ mi dài tay trơn Bamboo mang đến sự lịch lãm nhưng không kém phần thoải mái','br2', 2),
 (N'Áo sơ mi dài tay kẻ dọc','https://product.hstatic.net/200000690725/product/ac86f187-2312-4506-8f24-52f16ecd6813_32af0dab2a064afc9f9f4e5ba8168658_master.jpg', 1,  480000,  
 N'Áo sơ mi dài tay kẻ dọc mang đến sự lịch lãm nhưng không kém phần thoải mái','br2', 2)

Delete from product 
where ID = 23 or ID = 31

 INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (1, 1, 1, 30);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (1, 2, 1, 28);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (1, 3, 1, 35);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (1, 4, 1, 40);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (1, 1, 3, 27);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (1, 2, 3, 33);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (1, 3, 3, 25);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (1, 4, 3, 38);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (2, 1, 1, 35);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (2, 2, 1, 29);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (2, 3, 1, 40);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (2, 4, 1, 26);

-- Màu đen (ColorID = 1)
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (3, 1, 1, 30);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (3, 2, 1, 27);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (3, 3, 1, 35);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (3, 4, 1, 40);

-- Màu trắng (ColorID = 3)
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (3, 1, 3, 28);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (3, 2, 3, 32);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (3, 3, 3, 25);
INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES (3, 4, 3, 38);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES
(4, 1, 4, 29), (4, 2, 4, 34), (4, 3, 4, 27), (4, 4, 4, 31), -- Màu be
(4, 1, 3, 30), (4, 2, 3, 36), (4, 3, 3, 25), (4, 4, 3, 39); -- Màu trắng

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES
(5, 1, 3, 28), (5, 2, 3, 35), (5, 3, 3, 30), (5, 4, 3, 38);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES
(6, 1, 3, 27), (6, 2, 3, 32), (6, 3, 3, 29), (6, 4, 3, 35),
(6, 1, 1, 30), (6, 2, 1, 37), (6, 3, 1, 26), (6, 4, 1, 40);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES
(7, 1, 1, 30), (7, 2, 1, 35), (7, 3, 1, 28), (7, 4, 1, 40),
(7, 1, 4, 27), (7, 2, 4, 32), (7, 3, 4, 29), (7, 4, 4, 38),
(7, 1, 3, 26), (7, 2, 3, 37), (7, 3, 3, 31), (7, 4, 3, 39);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(8, 1, 3, 30), (8, 2, 3, 35), (8, 3, 3, 28), (8, 4, 3, 40);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(9, 1, 1, 30), (9, 2, 1, 35), (9, 3, 1, 28), (9, 4, 1, 40),
(9, 1, 4, 27), (9, 2, 4, 32), (9, 3, 4, 29), (9, 4, 4, 38),
(9, 1, 10, 26), (9, 2, 10, 37), (9, 3, 10, 31), (9, 4, 10, 39);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(10, 1, 1, 30), (10, 2, 1, 35), (10, 3, 1, 28), (10, 4, 1, 40),
(10, 1, 3, 27), (10, 2, 3, 32), (10, 3, 3, 29), (10, 4, 3, 38),
(10, 1, 10, 26), (10, 2, 10, 37), (10, 3, 10, 31), (10, 4, 10, 39);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(11, 1, 3, 30), (11, 2, 3, 35), (11, 3, 3, 28), (11, 4, 3, 40),
(11, 1, 4, 27), (11, 2, 4, 32), (11, 3, 4, 29), (11, 4, 4, 38);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(12, 1, 1, 30), (12, 2, 1, 35), (12, 3, 1, 28), (12, 4, 1, 40),
(12, 1, 4, 27), (12, 2, 4, 32), (12, 3, 4, 29), (12, 4, 4, 38),
(12, 1, 3, 26), (12, 2, 3, 37), (12, 3, 3, 31), (12, 4, 3, 39);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(13, 1, 8, 30), (13, 2, 8, 35), (13, 3, 8, 28), (13, 4, 8, 40),
(13, 1, 11, 27), (13, 2, 11, 32), (13, 3, 11, 29), (13, 4, 11, 38),
(13, 1, 5, 26), (13, 2, 5, 37), (13, 3, 5, 31), (13, 4, 5, 39);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(14, 1, 2, 30), (14, 2, 2, 35), (14, 3, 2, 28), (14, 4, 2, 40),
(14, 1, 8, 27), (14, 2, 8, 32), (14, 3, 8, 29), (14, 4, 8, 38),
(14, 1, 4, 26), (14, 2, 4, 37), (14, 3, 4, 31), (14, 4, 4, 39);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(15, 1, 1, 30), (15, 2, 1, 35), (15, 3, 1, 28), (15, 4, 1, 40),
(15, 1, 2, 27), (15, 2, 2, 32), (15, 3, 2, 29), (15, 4, 2, 38);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(16, 1, 1, 30), (16, 2, 1, 35), (16, 3, 1, 28), (16, 4, 1, 40),
(16, 1, 2, 27), (16, 2, 2, 32), (16, 3, 2, 29), (16, 4, 2, 38);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(17, 1, 2, 30), (17, 2, 2, 35), (17, 3, 2, 28), (17, 4, 2, 40),
(17, 1, 1, 27), (17, 2, 1, 32), (17, 3, 1, 29), (17, 4, 1, 38);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(18, 1, 4, 30), (18, 2, 4, 35), (18, 3, 4, 28), (18, 4, 4, 40);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
-- Màu đen
(19, 1, 1, 30), (19, 2, 1, 35), (19, 3, 1, 28), (19, 4, 1, 40);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(20, 1, 8, 30), (20, 2, 8, 35), (20, 3, 8, 28), (20, 4, 8, 40),
(20, 1, 3, 27), (20, 2, 3, 32), (20, 3, 3, 29), (20, 4, 3, 38);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(21, 1, 2, 30), (21, 2, 2, 35), (21, 3, 2, 28), (21, 4, 2, 40),
(21, 1, 1, 27), (21, 2, 1, 32), (21, 3, 1, 29), (21, 4, 1, 38),
(21, 1, 8, 26), (21, 2, 8, 37), (21, 3, 8, 31), (21, 4, 8, 39);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(22, 1, 10, 30), (22, 2, 10, 35), (22, 3, 10, 28), (22, 4, 10, 40),
(22, 1, 4, 27), (22, 2, 4, 32), (22, 3, 4, 29), (22, 4, 4, 38),
(22, 1, 1, 26), (22, 2, 1, 37), (22, 3, 1, 31), (22, 4, 1, 39);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(24, 1, 10, 30), (24, 2, 10, 35), (24, 3, 10, 28), (24, 4, 10, 40);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(25, 1, 10, 30), (25, 2, 10, 35), (25, 3, 10, 28), (25, 4, 10, 40),
(25, 1, 3, 27), (25, 2, 3, 32), (25, 3, 3, 29), (25, 4, 3, 38);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(26, 1, 10, 30), (26, 2, 10, 35), (26, 3, 10, 28), (26, 4, 10, 40),
(26, 1, 1, 27), (26, 2, 1, 32), (26, 3, 1, 29), (26, 4, 1, 38);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(27, 1, 10, 30), (27, 2, 10, 35), (27, 3, 10, 28), (27, 4, 10, 40),
(27, 1, 3, 27), (27, 2, 3, 32), (27, 3, 3, 29), (27, 4, 3, 38);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(28, 1, 1, 30), (28, 2, 1, 35), (28, 3, 1, 28), (28, 4, 1, 40),
(28, 1, 3, 27), (28, 2, 3, 32), (28, 3, 3, 29), (28, 4, 3, 38);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(29, 1, 1, 30), (29, 2, 1, 35), (29, 3, 1, 28), (29, 4, 1, 40),
(29, 1, 3, 27), (29, 2, 3, 32), (29, 3, 3, 29), (29, 4, 3, 38),
(29, 1, 11, 26), (29, 2, 11, 37), (29, 3, 11, 31), (29, 4, 11, 39);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(30, 1, 9, 30), (30, 2, 9, 35), (30, 3, 9, 28), (30, 4, 9, 40),
(30, 1, 3, 27), (30, 2, 3, 32), (30, 3, 3, 29), (30, 4, 3, 38);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
-- Màu trắng
(32, 1, 3, 30), (32, 2, 3, 35), (32, 3, 3, 28), (32, 4, 3, 40);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(33, 1, 2, 30), (33, 2, 2, 35), (33, 3, 2, 28), (33, 4, 2, 40),
(33, 1, 3, 27), (33, 2, 3, 32), (33, 3, 3, 29), (33, 4, 3, 38);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(34, 1, 9, 30), (34, 2, 9, 35), (34, 3, 9, 28), (34, 4, 9, 40);

INSERT INTO ProductSize (ProductID, SizeID, ColorID, Quantity) VALUES 
(35, 1, 3, 30), (35, 2, 3, 35), (35, 3, 3, 28), (35, 4, 3, 40);

Insert into ProductImage(ProductID,ColorID,ImageURL) values
(1,1,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/February2025/ao-thun-nam-cotton-compact-in-coolmate-mau-den_(5).jpg'),
(1,3,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/February2025/ao-thun-nam-cotton-compact-in-coolmate-mau-trang_(6).jpg'),
(2,1,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/February2024/mockup4_73.jpg'),
(3,1,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/February2025/coolmate-x-copper-denim-ao-thun-phoi-jean-den-1.jpg'),
(3,3,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/February2025/coolmate-x-copper-denim-ao-thun-phoi-jean-trang-1.jpg'),
(4,3,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/June2024/2484SW.AT011.13.jpg'),
(4,4,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/June2024/2484SW.AT011.14.jpg'),
(5,3,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/June2024/2484SW.AT009.7.jpg'),
(6,1,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/April2023/shadowAo_thun_oversize__84RISING_logo3.jpg'),
(6,3,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/April2023/shadowAo_thun_oversize__84RISING_logo5.jpg'),
(7,1,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/September2023/chubby_corgi_pappa-1.jpg'),
(7,3,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/September2023/chubby_corgi_pappa-2.jpg'),
(7,4,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/September2023/chubby_corgi_pappa-3.jpg'),
(8,3,'https://product.hstatic.net/200000690725/product/avt_web_1150_x_1475_px___1__8b6c11f3d07043c9b9b897b0e499ee93_master.png'),
(9,1,'https://product.hstatic.net/200000690725/product/fsts001-bl-4_53542650254_o_879b9a9cca554876822b2df00ca94895_master.jpg'),
(9,4,'https://product.hstatic.net/200000690725/product/fsts001-dcr-2_53542753715_o_5248827bded245b29529b2aaeda2472e_master.jpg'),
(9,10,'https://product.hstatic.net/200000690725/product/fsts001---cbb-4_53540510254_o_a90a121f384e4a3c8f429ba11446b4db_master.jpg'),
(10,1,'https://product.hstatic.net/200000690725/product/53818949638_4c07aa0b47_k_14cc32aecb4246b1938f5d55ddc80f25_master.jpg'),
(10,3,'https://product.hstatic.net/200000690725/product/53818949628_1b3744c97f_k_b4b8fca24ca142928e333b71ee57741a_master.jpg'),
(10,10,'https://product.hstatic.net/200000690725/product/53818702561_e5e2c22575_k_c1423c6bdd154badab7370a7d9e53479_master.jpg'),
(11,3,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/March2024/stitchbeach2.jpg'),
(11,4,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/March2024/stitchbeach3_75.jpg'),
(12,1,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/September2023/cat_mama-3.jpg'),
(12,3,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/September2023/cat_mama-2.jpg'),
(12,4,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/September2023/cat_mama-1.jpg'),
(13,5,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/December2024/2484CW.ST002---9999--DO-3D_14.jpg'),
(13,8,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/December2024/2484CW.ST002--0048--NAU-3D_36.jpg'),
(13,11,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/December2024/2484CW.ST002---0029--XANH-3D_50.jpg'),
(14,2,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/November2024/24CMCW.ST002_-_XAM.jpg'),
(14,8,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/November2024/24CMCW.ST002_-_NAU.jpg'),
(14,4,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/November2024/24CMCW.ST002_-_BE.jpg'),
(15,1,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/December2024/24CMCW.ST003_-_Den_1.jpg'),
(15,2,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/December2024/24CMCW.ST003---Metal-Grey-7.jpg'),
(16,1,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/December2023/cmcwst001.2d.3_63.jpg'),
(16,2,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/December2023/cmcwst001.2d.2.jpg'),
(17,1,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/October2023/ST002.1_64.jpg'),
(17,2,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/October2023/ST002.4_47.jpg'),
(18,4,'https://product.hstatic.net/200000690725/product/thiet_ke_chua_co_ten__5__88201915d6a14ffebcb12de74a04b8ce_master.png'),
(19,1,'https://product.hstatic.net/200000690725/product/thiet_ke_chua_co_ten__4__5b2cf89f7d0648bc958ea2445a096c25_master.png'),
(20,3,'https://product.hstatic.net/200000690725/product/tw006-1_ecce5329a09748cab68e10452e9d6086_master.jpg'),
(20,8,'https://product.hstatic.net/200000690725/product/fdabe2d7-12f0-474a-8b99-9ecda0be9d4c_95bd5adf35884092a30a123a93d3e4d4_master.jpg'),
(21,2,'https://product.hstatic.net/200000690725/product/fwtw001-fwbs001-dgr-2_53998675744_o_cddeb22291f0440aa1e48c4d22a7750f_master.jpg'),
(21,8,'https://product.hstatic.net/200000690725/product/fwtw001-fwbs001-lbr-4_53998675504_o_9b14c1c88a3e450789a8039ef7d2627f_master.jpg'),
(21,1,'https://product.hstatic.net/200000690725/product/fwtw001-fwbs001-bl-4_53998782015_o_b09f0cb0738249188716d2cf7460d5f3_master.jpg'),
(22,1,'https://product.hstatic.net/200000690725/product/img_2087_53970441694_o_81da21399ff448f6a679479c15fb0f4d_master.jpg'),
(22,4,'https://product.hstatic.net/200000690725/product/img_2091_53970556595_o_fc906f752622422d8ca80f57ca8201fb_master.jpg'),
(22,10,'https://product.hstatic.net/200000690725/product/img_2090_53970111696_o_20151ac55c014d0e8c152c5a388ab82e_master.jpg'),
(24,10,'https://product.hstatic.net/200000690725/product/thiet_ke_chua_co_ten__7__2b3a0259ac0b4407b6d174bdf61a8329_master.png'),
(25,3,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/February2025/ao-so-mi-dai-tay-co-tau-premium-poplin-mau-be_(2).jpg'),
(25,10,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/February2025/ao-so-mi-dai-tay-co-tau-premium-poplin-mau-xanh-blue-night_(4).jpg'),
(26,1,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/May2024/poplin11_23.jpg'),
(26,10,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/May2024/24CMCW.SM006.BLI.8.jpg'),
(27,3,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/May2024/Dobby_Trang_8_copy.jpg'),
(27,10,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/May2024/24CMCW.SM004.FRB.8.jpg'),
(28,1,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/December2024/24CMCW.SM013_-_Den.jpg'),
(28,3,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/December2024/24CMCW.SM013_-_Be_Kaki_20.jpg'),
(29,1,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/October2024/DenBG_(1).png'),
(29,3,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/June2024/Trang_6.jpg'),
(29,9,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/June2024/Xanh_nhat_6.jpg'),
(30,3,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/May2023/cae24.jpg'),
(30,9,'https://media3.coolmate.me/cdn-cgi/image/quality=80,format=auto/uploads/May2023/cf5.jpg'),
(32,3,'https://product.hstatic.net/200000690725/product/tb023_69fdbfb524b84453adebc0a742d0fe46_master.png'),
(33,2,'https://product.hstatic.net/200000690725/product/tb001_c0675ef2b3a7434696f12bd8905d98e4_master.png'),
(33,3,'https://product.hstatic.net/200000690725/product/tb001_wh_54087887899_o_3baed2b003c64a2ba89312cae22f5fb3_master.jpg'),
(34,9,'https://product.hstatic.net/200000690725/product/tb614_584d3caa1ef449abb090844a88d3d94f_master.png'),
(35,3,'https://product.hstatic.net/200000690725/product/ac86f187-2312-4506-8f24-52f16ecd6813_32af0dab2a064afc9f9f4e5ba8168658_master.jpg')

 
 

 



-- Bảng orders lưu thông tin tổng quan về đơn hàng
CREATE TABLE orders (
  ID INT IDENTITY(1,1) NOT NULL, -- Mã đơn hàng
  PaymentStatus VARCHAR(50) NOT NULL, -- Trạng thái thanh toán
  OrderDate DATE NOT NULL, -- Ngày đặt hàng
  TotalAmount DECIMAL(10,2) , -- Tổng giá trị đơn hàng
  UsersID INT NOT NULL, -- ID người dùng
  PRIMARY KEY (ID), -- Đặt ID làm khóa chính
  CONSTRAINT orders_fk_users FOREIGN KEY (UsersID) REFERENCES users (ID) -- Liên kết với bảng users
);

CREATE TABLE suborder (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    PaymentStatus VARCHAR(50) NOT NULL,
    ReceiverName NVARCHAR(255) NULL,
    ReceiverPhone NVARCHAR(20) NULL,
    ReceiverEmail NVARCHAR(255) NULL,
    ReceiverAddress NVARCHAR(500) NULL,
    CreatedDate DATETIME NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(ID) -- Giả sử bảng Orders tồn tại
);


-- Bảng orderdetails lưu chi tiết sản phẩm trong từng đơn hàng
-- Bảng orderdetails lưu chi tiết sản phẩm trong từng đơn hàng
CREATE TABLE orderdetails (
    ID INT IDENTITY(1,1) NOT NULL, 
    OrderID INT NOT NULL, -- Mã đơn hàng liên kết
    ProductID INT NOT NULL, -- Mã sản phẩm
    Quantity INT NOT NULL, -- Số lượng sản phẩm
    Price DECIMAL(10,2) NULL, -- Giá sản phẩm
    Size VARCHAR(50) NULL,
    CheckboxStatus VARCHAR(10) NOT NULL DEFAULT 'checked', -- Trạng thái checkbox với giá trị mặc định
    SubOrderID INT NULL, -- Liên kết với bảng suborder
    Color VARCHAR(50) NULL, -- Màu sản phẩm
    PRIMARY KEY (ID), -- Đặt ID làm khóa chính
    CONSTRAINT orderdetails_fk_orders FOREIGN KEY (OrderID) REFERENCES orders(ID), -- Liên kết với bảng orders
    CONSTRAINT orderdetails_fk_products FOREIGN KEY (ProductID) REFERENCES Product(ID), -- Liên kết với bảng products
    CONSTRAINT orderdetails_fk_suborder FOREIGN KEY (SubOrderID) REFERENCES suborder(ID) -- Liên kết với bảng suborder
	)

CREATE TABLE tokenForgetPassword (
    id int IDENTITY(1,1) PRIMARY KEY,
    token VARCHAR(255) NOT NULL,
    expiryTime datetime2 NOT NULL,
	isUsed bit NOT NULL,
	userId int NOT NULL,
	FOREIGN KEY (userId) REFERENCES [users](id)
);


CREATE TABLE feedback (
  ID INT IDENTITY(1,1) NOT NULL,
  RatedStar INT NOT NULL,
  Comment NVARCHAR(255),
  ProductID INT NOT NULL,
  UsersID INT NOT NULL,
  Status NVARCHAR(50) NOT NULL,
  FullName NVARCHAR(100) NOT NULL,
  Email NVARCHAR(255) NOT NULL,
  Mobile NVARCHAR(20) NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT feedback_ibfk_1 FOREIGN KEY (ProductID) REFERENCES product (ID),
  CONSTRAINT feedback_ibfk_2 FOREIGN KEY (UsersID) REFERENCES users (ID)
);

INSERT INTO feedback (RatedStar, Comment, ProductID, UsersID, Status, FullName, Email, Mobile)
VALUES 
(5, N'Chất lượng tuyệt vời, vải mềm mịn!', 1, 1, '1', N'Nguyễn Hải Phong', 'phongvg04@gmail.com', '0930000000'),
(4, N'Áo đẹp nhưng giao hàng hơi lâu.', 2, 2, '1', N'Nguyễn Văn Hùng', 'nguyenvanhung@gmail.com', '0912345678'),
(5, N'Mặc rất thoải mái, phù hợp đi chơi.', 3, 3, '1', N'Trần Thị Hoa', 'tranthihoa@gmail.com', '0987654321'),
(3, N'Hơi rộng so với size mình chọn.', 4, 4, '1', N'Lê Minh Tuấn', 'leminhtuan@gmail.com', '0934567890'),
(5, N'Sản phẩm đẹp, đúng như mô tả.', 5, 5, '1', N'Phạm Thị Lan', 'phamthilan@gmail.com', '0923456781'),
(4, N'Áo form rộng, phong cách cá tính.', 6, 6, '1', N'Hoàng Văn Nam', 'hoangvannam@gmail.com', '0909876543'),
(5, N'Sản phẩm chất lượng, sẽ ủng hộ tiếp.', 7, 7, '1', N'Đặng Thị Vân', 'dangthivan@gmail.com', '0945678901'),
(4, N'Màu sắc đẹp nhưng chất vải hơi dày.', 8, 8, '1', N'Vũ Đức Thịnh', 'vuducthinh@gmail.com', '0934567800'),
(5, N'Giao hàng nhanh, sản phẩm đẹp!', 9, 9, '1', N'Ngô Thị Ngọc', 'ngothingoc@gmail.com', '0987654322'),
(4, N'Áo khá đẹp nhưng cần thêm size lớn.', 10, 12, '1', N'Nguyễn Thị Hương', 'nguyenthihuong@gmail.com', '0911111111');





CREATE TABLE Slider ( id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,image_url nVARCHAR(255) NOT NULL,link nVARCHAR(255), status bit NOT NULL DEFAULT 1, 

 created_at DATETIME DEFAULT CURRENT_TIMESTAMP,);



INSERT INTO Slider (image_url, link, status)
VALUES
    ('https://newproductreviews.sapoapps.vn//Upload/ReviewImage/2022/1/21/d8d08dc69817c3dbaa2f08584de5c41e.png', 'productlist.jsp?category=1', 1),
    ('https://bizweb.dktcdn.net/thumb/1024x1024/100/399/392/products/ls.png', 'productlist.jsp?category=2', 1),
    ('https://aothudong.com/upload/product/atd-434/ao-gio-nam-hang-hieu-ghi-dep.jpg', 'productlist.jsp?sale=true', 1),
    ('https://aothudong.com/upload/product/atd-206/ao-khoac-gio-nam-dep-cao-cap.jpg', 'productlist.jsp?new=true', 1),
    ('https://golfgroup.com.vn/wp-content/uploads/2023/09/hinh-anh-ao-nam-lecoq-QGMVJK00-1.jpg', 'productlist.jsp?category=3', 1);


INSERT INTO categoryblog (ID, Name, Description) VALUES (1, N'Tin tức thời trang', N'Cập nhật xu hướng thời trang nam mới nhất'), (2, N'Mẹo phối đồ', N'Hướng dẫn phối đồ cho nam giới'), (3, N'Khuyến mãi', N'Tin tức về các chương trình giảm giá'), (4, N'Đánh giá sản phẩm', N'Đánh giá chi tiết các sản phẩm thời trang');


INSERT INTO blog (ID, Title, Content, UsersID, CateID, BlogImage, UploadDate, UploadTime)
VALUES
    ('blog1', N'Xu hướng áo thun nam 2025', 
     N'Bạn không nhất thiết phải chọn một chiếc áo thun tỉ mỉ, vừa khít vai, lưng hay vòng bụng như khi chọn áo sơ mi, nhưng ít nhất chúng cũng cần cân bằng tỉ lệ cơ thể cho bạn.',
     18, 1, 'https://canifa.com/blog/wp-content/uploads/mageplaza/blog/post/2017/03/mac-dep-ao-thun-nam-theo-hoan-canh.webp',
     '2025-03-06', '01:00:00'),
    ('blog2', N'Cách phối đồ với áo sơ mi nam', 
     N'Hướng dẫn phối áo sơ mi với quần jeans và phụ kiện để tạo phong cách lịch lãm.',
     19, 2, 'https://cf.shopee.vn/file/253725526e4387e68ee4c78bbd817892',
     '2025-03-06', '02:00:00'),
    ('blog3', N'Khuyến mãi tháng 3 - Giảm giá 30%', 
     N'Tin tức về chương trình giảm giá lớn trong tháng 3, đừng bỏ lỡ!',
     20, 3, 'https://tamanh.net/wp-content/uploads/2023/04/ao-thun-rong.jpg',
     '2025-03-06', '03:00:00'),
    ('blog4', N'Đánh giá áo nỉ Coolmate', 
     N'Đánh giá chi tiết chất liệu và form dáng áo nỉ Coolmate, đáng để thử!',
     21, 4, 'https://pubcdn.ivymoda.com/files/news/2024/04/08/db87a9540954dd9d01eb8da96b47e869.jpg',
     '2025-03-06', '04:00:00'),
    ('3', N'Top 5 áo thun đáng mua nhất', 
     N'Danh sách 5 mẫu áo thun nam đẹp và chất lượng cho năm 2025.',
     18, 1, 'https://www.gento.vn/wp-content/uploads/2023/12/cach-phoi-do-voi-quan-ong-rong-nam-3.jpg',
     '2025-03-06', '05:00:00');

ALTER TABLE Slider
ADD title VARCHAR(255);

CREATE TABLE Address (
    AddressID INT IDENTITY(1,1) PRIMARY KEY, 
    UserID INT NOT NULL, -- Mã người dùng liên kết
    ReceiverName NVARCHAR(255) NOT NULL,
    ReceiverPhone NVARCHAR(20) NOT NULL,
    ReceiverEmail NVARCHAR(255) NULL,
    ReceiverAddress NVARCHAR(500) NULL,
    CONSTRAINT fk_address_user FOREIGN KEY (UserID) REFERENCES Users(ID) 
);


Select * from ProductImage


