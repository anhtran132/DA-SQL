-- Chuyển đổi kiểu dữ liệu phù hợp cho các trường ( sử dụng câu lệnh ALTER) 
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN priceeach TYPE numeric USING(trim(priceeach)::numeric)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN ordernumber TYPE numeric USING(trim(ordernumber)::numeric)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN quantityordered TYPE numeric USING(trim(quantityordered)::numeric)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN orderlinenumber TYPE numeric USING(trim(orderlinenumber)::numeric)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN sales TYPE numeric USING(trim(sales)::numeric)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN orderdate TYPE Date USING(trim(orderdate)::Date)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN msrp TYPE numeric USING(trim(msrp)::numeric)

-- Check NULL/BLANK (‘’)  ở các trường: ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE : Không có giá trị null cho các trường nêu trên
-- Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ CONTACTFULLNAME . 
Chuẩn hóa CONTACTLASTNAME, CONTACTFIRSTNAME theo định dạng chữ cái đầu tiên viết hoa, chữ cái tiếp theo viết thường. 
ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN contactlastname VARCHAR(20)

ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN contactfirstname VARCHAR(20)

UPDATE sales_dataset_rfm_prj
SET contactlastname = SUBSTRING(contactfullname, 1, POSITION('-' IN contactfullname) - 1)

UPDATE sales_dataset_rfm_prj
SET contactlastname = UPPER(SUBSTRING(contactlastname, 1,1 )) || SUBSTRING(contactlastname, 2, LENGTH(contactlastname) - 1)

UPDATE sales_dataset_rfm_prj
SET contactfirstname = SUBSTRING(contactfullname, POSITION('-' IN contactfullname) + 1, LENGTH(contactfullname))

UPDATE sales_dataset_rfm_prj
SET contactfirstname = UPPER(SUBSTRING(contactfirstname, 1,1 )) || SUBSTRING(contactfirstname, 2, LENGTH(contactfirstname) - 1)
-- Thêm cột QTR_ID, MONTH_ID, YEAR_ID lần lượt là Qúy, tháng, năm được lấy ra từ ORDERDATE 
ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN QTR_ID INTEGER

ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN MONTH_ID INTEGER

ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN YEAR_ID INTEGER

UPDATE sales_dataset_rfm_prj
SET year_id = EXTRACT(year FROM orderdate)
UPDATE sales_dataset_rfm_prj
SET month_id = EXTRACT(month FROM orderdate)
UPDATE sales_dataset_rfm_prj
SET qtr_id = EXTRACT(quarter FROM orderdate)

-- Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED và hãy chọn cách xử lý cho bản ghi đó (2 cách) ( Không chạy câu lệnh trước khi bài được review)
-- DOING 
-- Sau khi làm sạch dữ liệu, hãy lưu vào bảng mới  tên là SALES_DATASET_RFM_PRJ_CLEAN
-- DOING 
