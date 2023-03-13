SELECT DISTINCT * FROM (SELECT
    --(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD') || '#' ||
    (TO_VARCHAR(LAST_DAY(T0."CreateDate"),'YYYYMMDD') || '#' ||
    IFNULL(T0."ItemCode",'')|| '#' ||
    IFNULL(CAST(SUM(T0."InQty") - SUM(T0."OutQty")+
    IFNULL((SELECT
    SUM(TA."InQty") - SUM(TA."OutQty")
FROM
    "HBTGELVEZ_CUCUTA"."OINM" TA
WHERE
        (TA."CreateDate" <=LAST_DAY(ADD_MONTHS({1}))) AND TA."ItemCode" = T0."ItemCode" 
        AND TA."Warehouse" IN ('006')
    ),0) AS INT),'0') || '#' ||
IFNULL(T1."InvntryUom",'') || '#' ||
IFNULL (T0."Warehouse",'') || '#' ||
CASE T0."Warehouse"
WHEN '006' THEN 'PRINCIPAL CUCUTA'
WHEN '011' THEN 'PRINCIPAL OCAÑA'
WHEN '008' THEN 'AVERIAS CUCUTA'
WHEN '012' THEN 'AVERIAS OCAÑA'
WHEN '013' THEN 'PRINCIPAL ARAUCA'
WHEN '030' THEN 'CUCUTA MNM-TAT'
ELSE '0'
END

) AS "Inventario"
    FROM "HBTGELVEZ_CUCUTA"."OINM" T0
    INNER JOIN "HBTGELVEZ_CUCUTA"."OITM" T1 ON T1."ItemCode" = T0."ItemCode"
    INNER JOIN "HBTGELVEZ_CUCUTA"."OITB" T2 ON T2."ItmsGrpCod" = T1."ItmsGrpCod"
WHERE
T0."CreateDate"  BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
	--(T0."CreateDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1)),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 ))
	AND T0."Warehouse" IN ('006')
    GROUP BY T0."ItemCode", T1."InvntryUom",T0."Warehouse",LAST_DAY(T0."CreateDate")
--union para bogega 030
UNION ALL
SELECT
    --(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD') || '#' ||
    (TO_VARCHAR(LAST_DAY(T0."CreateDate"),'YYYYMMDD') || '#' ||
    IFNULL(T0."ItemCode",'')|| '#' ||
    IFNULL(CAST(SUM(T0."InQty") - SUM(T0."OutQty")+
    IFNULL((SELECT
    SUM(TA."InQty") - SUM(TA."OutQty")
FROM
    "HBTGELVEZ_CUCUTA"."OINM" TA
WHERE
        (TA."CreateDate" <=LAST_DAY(ADD_MONTHS({1}))) AND TA."ItemCode" = T0."ItemCode" 
        AND TA."Warehouse" IN ('030')
    ),0) AS INT),'0') || '#' ||
IFNULL(T1."InvntryUom",'') || '#' ||
IFNULL (T0."Warehouse",'') || '#' ||
CASE T0."Warehouse"
WHEN '006' THEN 'PRINCIPAL CUCUTA'
WHEN '011' THEN 'PRINCIPAL OCAÑA'
WHEN '008' THEN 'AVERIAS CUCUTA'
WHEN '012' THEN 'AVERIAS OCAÑA'
WHEN '013' THEN 'PRINCIPAL ARAUCA'
WHEN '030' THEN 'CUCUTA MNM-TAT'
ELSE '0'
END

) AS "Inventario"
    FROM "HBTGELVEZ_CUCUTA"."OINM" T0
    INNER JOIN "HBTGELVEZ_CUCUTA"."OITM" T1 ON T1."ItemCode" = T0."ItemCode"
    INNER JOIN "HBTGELVEZ_CUCUTA"."OITB" T2 ON T2."ItmsGrpCod" = T1."ItmsGrpCod"
WHERE
T0."CreateDate"  BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
	--(T0."CreateDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1)),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 ))
	AND T0."Warehouse" IN ('030')
    GROUP BY T0."ItemCode", T1."InvntryUom",T0."Warehouse",LAST_DAY(T0."CreateDate")

UNION ALL

SELECT --(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD') || '#' ||
     (TO_VARCHAR(LAST_DAY(T0."DocDate"),'YYYYMMDD') || '#' ||
    IFNULL(T2."U_U_Acronimo",'')|| '#' ||
    0 || '#' ||
    IFNULL(T2."InvntryUom",'') || '#' ||
IFNULL (T1."WhsCode",'') || '#' ||
CASE T1."WhsCode"
WHEN '006' THEN 'PRINCIPAL CUCUTA'
WHEN '011' THEN 'PRINCIPAL OCAÑA'
WHEN '008' THEN 'AVERIAS CUCUTA'
WHEN '012' THEN 'AVERIAS OCAÑA'
WHEN '013' THEN 'PRINCIPAL ARAUCA'
WHEN '030' THEN 'CUCUTA MNM-TAT'
ELSE '0'
END) AS "Inventario"
FROM
"HBTGELVEZ_CUCUTA".OINV T0
INNER JOIN "HBTGELVEZ_CUCUTA".INV1 T1 ON T0."DocEntry" = T1."DocEntry"
INNER JOIN "HBTGELVEZ_CUCUTA".OITM T2 ON T1."ItemCode" = T2."ItemCode"
WHERE T0."DocDate" BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND T1."WhsCode" IN ('006','030')
AND T2."U_U_CheckBit" = 'Y'

UNION ALL

SELECT --(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD') || '#' ||
     (TO_VARCHAR(LAST_DAY(T0."DocDate"),'YYYYMMDD') || '#' ||
    IFNULL(T2."U_U_Acronimo",'')|| '#' ||
    0 || '#' ||
    IFNULL(T2."InvntryUom",'') || '#' ||
IFNULL (T1."WhsCode",'') || '#' ||
CASE T1."WhsCode"
WHEN '006' THEN 'PRINCIPAL CUCUTA'
WHEN '011' THEN 'PRINCIPAL OCAÑA'
WHEN '008' THEN 'AVERIAS CUCUTA'
WHEN '012' THEN 'AVERIAS OCAÑA'
WHEN '013' THEN 'PRINCIPAL ARAUCA'
WHEN '030' THEN 'CUCUTA MNM-TAT'
ELSE '0'
END) AS "Inventario"
FROM
"HBTGELVEZ_CUCUTA".ORIN T0
INNER JOIN "HBTGELVEZ_CUCUTA".RIN1 T1 ON T0."DocEntry" = T1."DocEntry"
INNER JOIN "HBTGELVEZ_CUCUTA".OITM T2 ON T1."ItemCode" = T2."ItemCode"
WHERE T0."DocDate" BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND T1."WhsCode" IN ('006','030')
AND T2."U_U_CheckBit" = 'Y') AS "TA"
--ORDER BY TA."Inventario"

--UNION CON LA CONSULTA DEL TRAN DISTROBUIDOR

UNION ALL

SELECT DISTINCT * FROM (SELECT
    -- (TO_VARCHAR(CURRENT_DATE,'YYYYMMDD') || '#' ||
    (TO_VARCHAR(LAST_DAY(T0."CreateDate"),'YYYYMMDD') || '#' ||
    T0."ItemCode" || '#' ||
    IFNULL(CAST(SUM(T0."InQty") - SUM(T0."OutQty")+
    IFNULL((SELECT
    SUM(TA."InQty") - SUM(TA."OutQty")
FROM
    "HBTGRANDISTRIBUIDOR"."OINM" TA
WHERE
        (TA."CreateDate" <=LAST_DAY(ADD_MONTHS({1}))) AND TA."ItemCode" = T0."ItemCode" 
        AND TA."Warehouse" = '014'
    ),0) AS INT),'0') || '#' ||
IFNULL(T1."InvntryUom",'') || '#' ||
IFNULL (T0."Warehouse",'') || '#' ||
'PRINCIPAL GIRON'
) AS "Inventario"
    FROM "HBTGRANDISTRIBUIDOR"."OINM" T0
    INNER JOIN "HBTGRANDISTRIBUIDOR"."OITM" T1 ON T1."ItemCode" = T0."ItemCode"
    INNER JOIN "HBTGRANDISTRIBUIDOR"."OITB" T2 ON T2."ItmsGrpCod" = T1."ItmsGrpCod"
WHERE
 --T0."CreateDate" BETWEEN '[%0]' AND '[%1]'
	T0."CreateDate" BETWEEN {0}
	AND T0."Warehouse" = '014'
    GROUP BY T0."ItemCode", T1."InvntryUom",T0."Warehouse",LAST_DAY(T0."CreateDate") --CURRENT_DATE

UNION ALL

SELECT
    -- (TO_VARCHAR(CURRENT_DATE,'YYYYMMDD') || '#' ||
    (TO_VARCHAR(LAST_DAY(T0."CreateDate"),'YYYYMMDD') || '#' ||
    T0."ItemCode" || '#' ||
    IFNULL(CAST(SUM(T0."InQty") - SUM(T0."OutQty")+
    IFNULL((SELECT
    SUM(TA."InQty") - SUM(TA."OutQty")
FROM
    "HBTGRANDISTRIBUIDOR"."OINM" TA
WHERE
        (TA."CreateDate" <= LAST_DAY(ADD_MONTHS({1}))) AND TA."ItemCode" = T0."ItemCode" 
        AND TA."Warehouse" = '010'
    ),0) AS INT),'0') || '#' ||
IFNULL(T1."InvntryUom",'') || '#' ||
IFNULL (T0."Warehouse",'') || '#' ||
'PRINCIPAL CALI'
) AS "Inventario"
    FROM "HBTGRANDISTRIBUIDOR"."OINM" T0
    INNER JOIN "HBTGRANDISTRIBUIDOR"."OITM" T1 ON T1."ItemCode" = T0."ItemCode"
    INNER JOIN "HBTGRANDISTRIBUIDOR"."OITB" T2 ON T2."ItmsGrpCod" = T1."ItmsGrpCod"
WHERE
--T0."CreateDate" BETWEEN '[%0]' AND '[%1]'
	(T0."CreateDate" BETWEEN {0})--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 ))
	AND T0."Warehouse" = '010'
    GROUP BY T0."ItemCode", T1."InvntryUom",T0."Warehouse",LAST_DAY(T0."CreateDate") --CURRENT_DATE

	UNION ALL

SELECT
    -- (TO_VARCHAR(CURRENT_DATE,'YYYYMMDD') || '#' ||
    (TO_VARCHAR(LAST_DAY(T0."CreateDate"),'YYYYMMDD') || '#' ||
    T0."ItemCode" || '#' ||
    IFNULL(CAST(SUM(T0."InQty") - SUM(T0."OutQty")+
    IFNULL((SELECT
    SUM(TA."InQty") - SUM(TA."OutQty")
FROM
    "HBTGRANDISTRIBUIDOR"."OINM" TA
WHERE
        (TA."CreateDate" <= LAST_DAY(ADD_MONTHS({1}))) AND TA."ItemCode" = T0."ItemCode" 
        AND TA."Warehouse" = '019'
    ),0) AS INT),'0') || '#' ||
IFNULL(T1."InvntryUom",'') || '#' ||
IFNULL (T0."Warehouse",'') || '#' ||
'PRINCIPAL EJE CAFETERO'
) AS "Inventario"
    FROM "HBTGRANDISTRIBUIDOR"."OINM" T0
    INNER JOIN "HBTGRANDISTRIBUIDOR"."OITM" T1 ON T1."ItemCode" = T0."ItemCode"
    INNER JOIN "HBTGRANDISTRIBUIDOR"."OITB" T2 ON T2."ItmsGrpCod" = T1."ItmsGrpCod"
WHERE
--T0."CreateDate" BETWEEN '[%0]' AND '[%1]'
	(T0."CreateDate" BETWEEN {0})--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 ))
	AND T0."Warehouse" = '019'
    GROUP BY T0."ItemCode", T1."InvntryUom",T0."Warehouse",LAST_DAY(T0."CreateDate") --CURRENT_DATE
UNION ALL

SELECT --(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD') || '#' ||
     (TO_VARCHAR(LAST_DAY(T0."DocDate"),'YYYYMMDD') || '#' ||
    IFNULL(T2."U_U_Acronimo",'')|| '#' ||
    0 || '#' ||
    IFNULL(T2."InvntryUom",'') || '#' ||
IFNULL (T1."WhsCode",'') || '#' ||
CASE T1."WhsCode"
WHEN '010' THEN 'PRINCIPAL CALI'
WHEN '014' THEN 'PRINCIPAL GIRON'
WHEN '019' THEN 'PRINCIPAL EJE CAFETERO'
ELSE '0'
END) AS "Inventario"
FROM
"HBTGRANDISTRIBUIDOR".OINV T0
INNER JOIN "HBTGRANDISTRIBUIDOR".INV1 T1 ON T0."DocEntry" = T1."DocEntry"
INNER JOIN "HBTGRANDISTRIBUIDOR".OITM T2 ON T1."ItemCode" = T2."ItemCode"
WHERE T0."DocDate" BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND T1."WhsCode" IN (010,014,019)
AND T2."U_U_CheckBit" = 'Y'

UNION ALL

SELECT --(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD') || '#' ||
     (TO_VARCHAR(LAST_DAY(T0."DocDate"),'YYYYMMDD') || '#' ||
    IFNULL(T2."U_U_Acronimo",'')|| '#' ||
    0 || '#' ||
    IFNULL(T2."InvntryUom",'') || '#' ||
IFNULL (T1."WhsCode",'') || '#' ||
CASE T1."WhsCode"
WHEN '010' THEN 'PRINCIPAL CALI'
WHEN '014' THEN 'PRINCIPAL GIRON'
WHEN '019' THEN 'PRINCIPAL EJE CAFETERO'
ELSE '0'
END) AS "Inventario"
FROM
"HBTGRANDISTRIBUIDOR".ORIN T0
INNER JOIN "HBTGRANDISTRIBUIDOR".RIN1 T1 ON T0."DocEntry" = T1."DocEntry"
INNER JOIN "HBTGRANDISTRIBUIDOR".OITM T2 ON T1."ItemCode" = T2."ItemCode"
WHERE T0."DocDate" BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND T1."WhsCode" IN (010,014,019)
AND T2."U_U_CheckBit" = 'Y'	
) AS "TT"
