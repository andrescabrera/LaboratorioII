DECLARE
  CURSOR cincoProds
  IS
    SELECT
      product_id,
      description
    FROM
      product
    JOIN price USING (product_id)
    WHERE
      END_DATE IS NULL
    ORDER BY
      list_price DESC;
BEGIN
  FOR regProd IN cincoProds
  LOOP
    EXIT
  WHEN cincoProds%rowcount > 5;
    dbms_output.put_line(regProd.product_id ||' '|| regProd.description);
  END
  LOOP;
END
;