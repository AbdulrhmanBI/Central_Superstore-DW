# Expected results of the 16 analytical queries

Values computed from the cleaned dataset (2,323 sales lines). Your SQL Server output should match; the number of decimal places may differ.

## Row counts after the full load

| Table | Rows |
|---|---|
| bronze.superstore_raw | 5,108 |
| silver.superstore_clean | 2,323 |
| gold.DimCustomer | 629 |
| gold.DimProduct | 1,326 |
| gold.DimLocation | 195 |
| gold.DimShipMode | 4 |
| gold.DimDate | 1,058 |
| gold.FactSales | 2,323 |

## Q1 Overall KPIs

| totalsales | totalprofit | totalquantity | profitmarginpct |
|---|---|---|---|
| 501239.89 | 39706.36 | 8780 | 7.92 |

## Q2 Highest and lowest sale

| highestsale | lowestsale |
|---|---|
| 17499.95 | 0.44 |

## Q3 Orders and average order value

| totalorders | avgordervalue |
|---|---|
| 1175 | 426.59 |

## Q4 Sales and profit by category

| category | totalsales | totalprofit |
|---|---|---|
| Technology | 170416.31 | 33697.43 |
| Office Supplies | 167026.42 | 8879.98 |
| Furniture | 163797.16 | -2871.05 |

## Q5 Sales and profit by region

| region | totalsales | totalprofit |
|---|---|---|
| Central | 501239.89 | 39706.36 |

## Q6 Sales and profit by segment

| segment | totalsales | totalprofit |
|---|---|---|
| Corporate | 157995.81 | 18703.9 |
| Home Office | 91212.64 | 12438.41 |
| Consumer | 252031.43 | 8564.05 |

## Q7 Sales and profit by year

| yearnumber | totalsales | totalprofit |
|---|---|---|
| 2013 | 103838.16 | 539.55 |
| 2014 | 102874.22 | 11716.8 |
| 2015 | 147429.38 | 19899.16 |
| 2016 | 147098.13 | 7550.84 |

## Q8 Top 10 customers by profit

| customerid | customername | totalsales | totalprofit |
|---|---|---|---|
| TC-20980 | Tamara Chand | 18437.14 | 8745.06 |
| AB-10105 | Adrian Barton | 12181.59 | 5362.61 |
| SC-20095 | Sanjit Chand | 9900.19 | 4668.69 |
| AR-10540 | Andy Reiter | 5802.7 | 2602.09 |
| HM-14860 | Harry Marie | 6621.48 | 1996.88 |
| SD-20485 | Shirley Daniels | 4724.42 | 1841.58 |
| HW-14935 | Helen Wasserman | 6100.75 | 1378.88 |
| BE-11335 | Bill Eplett | 3501.9 | 1241.43 |
| DW-13480 | Dianna Wilson | 3760.41 | 1158.66 |
| TT-21460 | Tonja Turnell | 5301.69 | 1113.03 |

## Q9 Top 5 orders by sales

| orderid | totalsales | totalprofit |
|---|---|---|
| CA-2013-118689 | 18336.74 | 8762.39 |
| CA-2011-139892 | 10539.9 | -1878.79 |
| CA-2011-116904 | 9900.19 | 4668.69 |
| CA-2013-117121 | 9892.74 | 4946.37 |
| CA-2014-138289 | 5802.7 | 2602.09 |

## Q10 Top 5 products by sales

| productid | productname | totalsales | totalprofit |
|---|---|---|---|
| TEC-CO-10004722 | Canon imageCLASS 2200 Advanced Copier | 17499.95 | 8399.98 |
| TEC-MA-10000822 | Lexmark MX611dhe Monochrome Laser Printer | 14279.92 | -1189.99 |
| OFF-BI-10001120 | Ibico EPK-21 Electric Binding System | 11339.94 | 1700.99 |
| OFF-BI-10000545 | GBC Ibimaster 500 Manual ProClick Binding System | 10653.72 | 3804.9 |
| OFF-BI-10004995 | GBC DocuBind P400 Electric Binding System | 8710.34 | -3048.62 |

## Q11 Top 10 loss-making products

| productname | productid | totalsales | totalprofit |
|---|---|---|---|
| GBC DocuBind P400 Electric Binding System | OFF-BI-10004995 | 8710.34 | -3048.62 |
| Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind | OFF-BI-10003527 | 6100.75 | -1525.19 |
| 3.6 Cubic Foot Counter Height Office Refrigerator | OFF-AP-10002534 | 530.32 | -1378.82 |
| Lexmark MX611dhe Monochrome Laser Printer | TEC-MA-10000822 | 14279.92 | -1189.99 |
| Ibico Hi-Tech Manual Binding System | OFF-BI-10004632 | 1829.94 | -1189.46 |
| GBC ProClick 150 Presentation Binding System | OFF-BI-10004584 | 695.16 | -1147.01 |
| Hoover Upright Vacuum With Dirt Cup | OFF-AP-10002651 | 1331.84 | -929.39 |
| High Speed Automatic Electric Letter Opener | OFF-SU-10000151 | 3930.07 | -786.01 |
| Tenex Chairmat w/ Average Lip, 45" x 53" | FUR-FU-10003806 | 544.9 | -681.12 |
| GBC DocuBind TL300 Electric Binding System | OFF-BI-10001359 | 2690.97 | -636.86 |

## Q12 Profit and loss analysis

| profitstatus | saleslines | totalsales | totalprofit |
|---|---|---|---|
| Profit | 1571 | 355822.92 | 96021.25 |
| Loss | 741 | 141282.66 | -56314.88 |
| Break-even | 11 | 4134.31 | 0.0 |

## Q13 Shipping duration by ship mode

| shipmode | avgshippingdays | totalsales | totalprofit |
|---|---|---|---|
| Standard Class | 4.99 | 318527.56 | 25352.38 |
| Second Class | 3.33 | 103550.01 | 9114.83 |
| First Class | 2.32 | 58746.92 | 3707.27 |
| Same Day | 0.03 | 20415.41 | 1531.88 |

## Q14 Profitability by discount level

| discountlevel | saleslines | totalsales | totalprofit |
|---|---|---|---|
| No Discount | 828 | 243150.64 | 76125.44 |
| Low | 852 | 128955.15 | 15973.2 |
| Medium | 205 | 105525.64 | -15908.58 |
| High | 438 | 23608.46 | -36483.69 |

## Q15 Monthly sales trend

| yearnumber | monthnumber | monthname | totalsales | totalprofit |
|---|---|---|---|---|
| 2013 | 1 | January | 1539.91 | 118.49 |
| 2013 | 2 | February | 1233.17 | 294.81 |
| 2013 | 3 | March | 5827.6 | -274.05 |
| 2013 | 4 | April | 3712.34 | 229.38 |
| 2013 | 5 | May | 4048.51 | -506.02 |
| 2013 | 6 | June | 9646.3 | 1246.12 |
| 2013 | 7 | July | 6740.57 | -4055.33 |
| 2013 | 8 | August | 3022.18 | 628.43 |
| 2013 | 9 | September | 34408.69 | 1422.8 |
| 2013 | 10 | October | 8965.76 | 1341.24 |
| 2013 | 11 | November | 14057.57 | -794.16 |
| 2013 | 12 | December | 10635.57 | 887.85 |
| 2014 | 1 | January | 2510.51 | -602.85 |
| 2014 | 2 | February | 2527.59 | 330.97 |
| 2014 | 3 | March | 6730.27 | 51.41 |
| 2014 | 4 | April | 11642.06 | 992.06 |
| 2014 | 5 | May | 8623.9 | 963.93 |
| 2014 | 6 | June | 3713.19 | -420.67 |
| 2014 | 7 | July | 7605.57 | 305.26 |
| 2014 | 8 | August | 9301.45 | 1031.58 |
| 2014 | 9 | September | 7578.52 | 1563.34 |
| 2014 | 10 | October | 7000.49 | 48.66 |
| 2014 | 11 | November | 18903.09 | 3261.6 |
| 2014 | 12 | December | 16737.6 | 4191.5 |
| 2015 | 1 | January | 5942.16 | 474.09 |
| 2015 | 2 | February | 1115.73 | -142.57 |
| 2015 | 3 | March | 13153.81 | -606.04 |
| 2015 | 4 | April | 7439.74 | -1334.09 |
| 2015 | 5 | May | 11514.57 | 1407.38 |
| 2015 | 6 | June | 6755.04 | 149.85 |
| 2015 | 7 | July | 7633.55 | 504.34 |
| 2015 | 8 | August | 8269.62 | 494.55 |
| 2015 | 9 | September | 17525.21 | -557.95 |
| 2015 | 10 | October | 25098.06 | 10656.84 |
| 2015 | 11 | November | 16712.63 | 1488.58 |
| 2015 | 12 | December | 26269.27 | 7364.18 |
| 2016 | 1 | January | 21690.66 | 2865.93 |
| 2016 | 2 | February | 3334.82 | -999.19 |
| 2016 | 3 | March | 15504.58 | 2054.64 |
| 2016 | 4 | April | 3383.12 | 124.58 |
| 2016 | 5 | May | 11588.85 | 1765.19 |
| 2016 | 6 | June | 12966.76 | 1209.5 |
| 2016 | 7 | July | 8872.96 | 1027.79 |
| 2016 | 8 | August | 6252.99 | 531.37 |
| 2016 | 9 | September | 17343.0 | 1130.47 |
| 2016 | 10 | October | 12122.34 | 597.52 |
| 2016 | 11 | November | 15154.98 | -1518.6 |
| 2016 | 12 | December | 18883.07 | -1238.38 |

## Q16 Products with above-average profit

358 products are above the average product profit (top 10 shown).

| productid | productname | totalprofit |
|---|---|---|
| TEC-CO-10004722 | Canon imageCLASS 2200 Advanced Copier | 8399.98 |
| OFF-BI-10000545 | GBC Ibimaster 500 Manual ProClick Binding System | 3804.9 |
| TEC-CO-10003763 | Canon PC1060 Personal Laser Copier | 2302.97 |
| OFF-BI-10001120 | Ibico EPK-21 Electric Binding System | 1700.99 |
| OFF-AP-10002945 | Honeywell Enviracaire Portable HEPA Air Cleaner for 17' x 22' Room | 1289.79 |
| OFF-BI-10004600 | Ibico Ibimaster 300 Manual Binding System | 1159.17 |
| TEC-CO-10002095 | Hewlett Packard 610 Color Digital Copier / Printer | 1074.98 |
| TEC-CO-10001046 | Canon Imageclass D680 Copier / Fax | 874.99 |
| TEC-AC-10004666 | Maxell iVDR EX 500GB Cartridge | 829.38 |
| TEC-CO-10002313 | Canon PC1080F Personal Copier | 803.99 |
