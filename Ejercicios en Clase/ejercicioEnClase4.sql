DECLARE
vi number := 2500;
BEGIN
  LOOP
    EXIT WHEN vi > 5;  
    dbms_output.put_line(vi);
    vi := vi + 1;    
    EXIT WHEN vi > 5;
  END LOOP;
END;