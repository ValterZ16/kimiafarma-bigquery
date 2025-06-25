SELECT ft.transaction_id AS transaction_id, ft.date AS date_trans, ft.branch_id AS branch_id, bc.branch_name AS branch_name, bc.kota AS kota, bc.provinsi AS provinsi, bc.rating as rating_cabang, ft.customer_name AS customer_name, p.product_id AS product_id, p.product_name AS product_name, ft.price AS actual_price, ft.discount_percentage AS discount_percentage,
CASE
  WHEN ft.price <= 50.000 THEN 0.10
  WHEN ft.price > 50.000 AND ft.price <= 100.000 THEN 0.15
  WHEN ft.price > 100.000 AND ft.price <= 300.000 THEN 0.20
  WHEN ft.price > 300.000 AND ft.price <= 500.000 THEN 0.25
  ELSE 0.30
END AS persentase_gross_laba,
(1 - ft.discount_percentage) * ft.price AS nett_sales,
(1 - ft.discount_percentage) * ft.price *
CASE
  WHEN ft.price <= 50.000 THEN 0.10
  WHEN ft.price > 50.000 AND ft.price <= 100.000 THEN 0.15
  WHEN ft.price > 100.000 AND ft.price <= 300.000 THEN 0.20
  WHEN ft.price > 300.000 AND ft.price <= 500.000 THEN 0.25
  ELSE 0.30
END AS nett_profit, ft.rating AS rating_transaksi
FROM `rakaminkfanalytics-464005.kimia_farma.kf_final_transaction` ft JOIN `rakaminkfanalytics-464005.kimia_farma.kf_product` p ON
ft.product_id = p.product_id JOIN `rakaminkfanalytics-464005.kimia_farma.kf_kantor_cabang` bc ON
bc.branch_id = ft.branch_id