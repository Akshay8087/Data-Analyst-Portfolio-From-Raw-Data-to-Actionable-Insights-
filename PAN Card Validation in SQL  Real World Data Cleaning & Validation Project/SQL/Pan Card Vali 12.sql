Create Table Pan_card(
Pan_Numbers VARCHAR(50)
);


Select * from pan_card;


select count(*) as total_record FROm pan_card;

-- HAving 10k Records in Our Data Set

select * from pan_card;

-- Identifing NA dhandling Missing Data

Select * from pan_card where  Pan_Numbers is null; -- total 965 values are missing

-- Checking FOr Dupolicates

Select  Pan_Numbers , count(*) 
from pan_card
group by pan_numbers 
having Count(1) >1 ;


--Handling Leadinig ANd  triling Spaces

select * from pan_card where pan_numbers <> trim(pan_numbers); --Total 9 records FOund

-- Checking Corect Letter Case

Select * from pan_card where pan_numbers <> upper(pan_numbers); --990 records 

--Cleaned Pan Numbers

select Distinct upper(trim(pan_numbers)) as pan_number
from pan_card
where pan_numbers is not Null
and trim(pan_numbers) <> '';



--Function to Check Adjustent Character Are The Same -- DQNPR4567P == DQNPR


CREATE OR REPLACE FUNCTION Function_to_check_adjusent_char(p_str text)
RETURNS boolean
LANGUAGE plpgsql
AS $$
DECLARE
    i integer;
BEGIN
    FOR i IN 1 .. (length(p_str) - 1) LOOP
        IF substring(p_str, i, 1) = substring(p_str, i+1, 1) THEN
            RETURN true; -- The characters are adjacent and equal
        END IF;
    END LOOP;

    RETURN false; -- No adjacent equal characters found
END;
$$;


select Function_to_check_adjusent_char('AAAAA')



------ Function To che Are Sequntial Character Use

CREATE OR REPLACE FUNCTION Function_to_Sequntial_char(p_str text)
RETURNS boolean
LANGUAGE plpgsql
AS $$
DECLARE
    i integer;
BEGIN
    FOR i IN 1 .. (length(p_str) - 1) LOOP
	if ascii(substring(p_str , i+1 , 1)) -  ascii(substring(p_str , i , 1)) <>1
        then
		   return False; --Strinbg Does Not Form A Seqvence
		   end if;
    END LOOP;
	return True; ---Strinbg Does Not Form A Seqvence
END;
$$;


select Function_to_Sequntial_char('AXDGE')


--Reguler Expression to validate the pattern or structure of PAN Numbers

SELECT *
FROM pan_card
WHERE pan_numbers ~ '^[A-Z]{5}[0-9]{4}[A-Z]$';


-- Valid ANd Invalid Categirization


WITH CTE_clened_pan AS (
    SELECT DISTINCT UPPER(TRIM(pan_numbers)) AS pan_number
    FROM pan_card
    WHERE pan_numbers IS NOT NULL
      AND TRIM(pan_numbers) <> ''
),
CTE_valid_pan AS (
    SELECT *
    FROM CTE_clened_pan
    WHERE Function_to_check_adjusent_char(pan_number) = false
      AND Function_to_Sequntial_char(SUBSTRING(pan_number, 1, 5)) = false
      AND Function_to_Sequntial_char(SUBSTRING(pan_number, 6, 4)) = false
      AND pan_number ~ '^[A-Z]{5}[0-9]{4}[A-Z]$'
)
SELECT cln.pan_number,
       CASE 
            WHEN vld.pan_number IS NOT NULL THEN 'Valid PAN'
            ELSE 'Invalid PAN'
       END AS status
FROM CTE_clened_pan cln
LEFT JOIN CTE_valid_pan vld 
       ON vld.pan_number = cln.pan_number;


-- Now creating VIEW


Create or replace view View_valid_invalid_pan
as
WITH CTE_clened_pan AS (
    SELECT DISTINCT UPPER(TRIM(pan_numbers)) AS pan_number
    FROM pan_card
    WHERE pan_numbers IS NOT NULL
      AND TRIM(pan_numbers) <> ''
),
CTE_valid_pan AS (
    SELECT *
    FROM CTE_clened_pan
    WHERE Function_to_check_adjusent_char(pan_number) = false
      AND Function_to_Sequntial_char(SUBSTRING(pan_number, 1, 5)) = false
      AND Function_to_Sequntial_char(SUBSTRING(pan_number, 6, 4)) = false
      AND pan_number ~ '^[A-Z]{5}[0-9]{4}[A-Z]$'
)
SELECT cln.pan_number,
       CASE 
            WHEN vld.pan_number IS NOT NULL THEN 'Valid PAN'
            ELSE 'Invalid PAN'
       END AS status
FROM CTE_clened_pan cln
LEFT JOIN CTE_valid_pan vld 
       ON vld.pan_number = cln.pan_number;

---
select * from View_valid_invalid_pan
