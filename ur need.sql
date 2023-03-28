SELECT id,ProductCode,ShortDescription FROM `product_list_variable`;


SELECT id, SUBSTRING_INDEX(ProductCode, '-', 1) as sku FROM `product_list_variable`;
SELECT * FROM `product_list_variable` GROUP BY SUBSTRING_INDEX(ProductCode, '-', 1);

INSERT INTO products
SELECT * FROM `product_list_variable`;


INSERT INTO products_sync
SELECT * FROM `products`;


UPDATE `products` SET `product_sizes` = SUBSTRING_INDEX(ProductCode, '-', 1);

UPDATE `products` SET `ProductCode` = `product_sizes`;
UPDATE `products` SET `product_sizes` = NULL;


UPDATE `product_list_variable` SET `product_sizes` = SUBSTRING_INDEX(ProductCode, '-', -1);
SELECT * FROM `product_list_variable`;



ALTER TABLE `product_list_variable` ADD `parent_id` VARCHAR(10) NULL AFTER `id`;
ALTER TABLE `product_list_variable` ADD `product_sizes` VARCHAR(120) NULL AFTER `parent_id`;
  
  
  
  
SELECT GROUP_CONCAT( SUBSTRING_INDEX(ProductCode, '-', -1) ) as size FROM `product_list_variable` WHERE ProductCode LIKE 'A912%';  
  
  
UPDATE `products` SET `product_sizes` = ( 
    SELECT GROUP_CONCAT( SUBSTRING_INDEX(ProductCode, '-', -1) )  FROM `product_list_variable` WHERE ProductCode LIKE CONCAT(products.ProductCode, '%')
)
WHERE `products`.`id` = 1;


UPDATE `products` SET `product_sizes` = ( 
    SELECT GROUP_CONCAT( SUBSTRING_INDEX(ProductCode, '-', -1) )  FROM `product_list_variable` WHERE ProductCode LIKE CONCAT(products.ProductCode, '%')
);

SELECT id,ProductCode,product_sizes FROM `products`;
  
  
SET @newid=0;
UPDATE `products_sync` SET id=(@newid:=@newid+1) ORDER BY `ProductCode` ASC;
SELECT * FROM `products_sync`;
  
  

/*
[Variable - Parent ]
Variations

*/