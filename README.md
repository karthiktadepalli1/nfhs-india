# NFHS India district dataset

From the NFHS website:

> The National Family Health Survey (NFHS) is a large-scale, multi-round survey conducted in a representative sample of households throughout India. Three rounds of the survey have been conducted since the first survey in 1992-93. The survey provides state and national information for India on fertility, infant and child mortality, the practice of family planning, maternal and child health, reproductive health, nutrition, anaemia, utilization and quality of health and family planning services. Each successive round of the NFHS has had two specific goals: a) to provide essential data on health and family welfare needed by the Ministry of Health and Family Welfare and other agencies for policy and programme purposes, and b) to provide information on important emerging health and family welfare issues.

The NFHS-4 contains extremely valuable information to health and economics researchers in India, but it is very difficult to access: NFHS statistics are published only as PDF reports, which are extremely inconvenient for data analysis. To solve this, I scraped every NFHS-4 district factsheet and cleaned the resulting data dump into a single dataset with one row for each of 637 districts, and one column for each of the 93 questions in the NFHS-4.

## Data Dictionary

The repository contains a CSV data dictionary, `district_data_dict.csv`. This data dictionary is also reproduced below, following the order of questions on the NFHS-4 survey. More detail can be found in any NFHS district factsheet, such as [this one.](http://rchiips.org/nfhs/FCTS/JH/JH_Factsheet_355_Bokaro.pdf)

|Variable                           |Meaning                                                                                                                                   |
|:---------------------------------:|:----------------------------------------------------------------------------------------------------------------------------------------:|
|district                           |District name                                                                                                                             |
|district_num                       |District number                                                                                                                           |
|state_code                         |State code                                                                                                                                |
|pct_female_ever_school             |1. Population (female) age 6 years and above who ever attended school (%)                                                                 |
|pct_below_15                       |2. Population below age 15 years (%)                                                                                                      |
|sex_ratio                          |3. Sex ratio of the total population (females per 1,000 males)                                                                            |
|sex_ratio_5years                   |4. Sex ratio at birth for children born in the last five years (females per 1,000 males)                                                  |
|pct_kids_u5_registered_birth       |5. Children under age 5 years whose birth was registered (%)                                                                              |
|pct_hh_electrified                 |6. Households with electricity (%)                                                                                                        |
|pct_hh_clean_water                 |7. Households with an improved drinking-water source1 (%)                                                                                 |
|pct_hh_sanitation                  |8. Households using improved sanitation facility2 (%)                                                                                     |
|pct_hh_clean_fuel                  |9. Households using clean fuel for cooking3 (%)                                                                                           |
|pct_hh_iodized_salt                |10. Households using iodized salt (%)                                                                                                     |
|pct_has_insurance                  |11. Households with any usual member covered by a health scheme or health insurance (%)                                                   |
|pct_literate_women                 |12. Women who are literate (%)                                                                                                            |
|pct_literate_men                   |13. Men who are literate (%)                                                                                                              |
|pct_women_10yrs_school             |14. Women with 10 or more years of schooling (%)                                                                                          |
|pct_young_women_married_pre18      |15. Women age 20-24 years married before age 18 years (%)                                                                                 |
|pct_young_men_married_pre21        |16. Men age 25-29 years married before age 21 years (%)                                                                                   |
|pct_teen_women_mothers             |17. Women age 15-19 years who were already mothers or pregnant at the time of the survey (%)                                              |
|pct_any_contraception              |18. Using any method of family planning (%)                                                                                                                       |
|pct_modern_contraception           |19. Using any modern method of family planning (%)                                                                                                                |
|pct_fem_sterilization              |20. Using female sterilization (%)                                                                                                              |
|pct_male_sterilization             |21. Using male sterilization (%)                                                                                                                |
|pct_using_iud                      |22. Using IUD/PPIUD (%)                                                                                                                         |
|pct_using_pill                     |23. Using pill (%)                                                                                                                              |
|pct_using_condoms                  |24. Using condom (%)                                                                                                                            |
|pct_unmet_need_contraception       |25. Total unmet need (%)                                                                                                                  |
|pct_unmet_need_spacing             |26. Unmet need for spacing (%)                                                                                                            |
|pct_health_worker_spoke_contra     |27. Health worker ever talked to female non-users about family planning (%)                                                               |
|pct_users_told_side_effects        |28. Current users ever told about side effects of current method of family planning (%)                                                                     |
|pct_moms_1trimester_checkup        |29. Mothers who had antenatal check-up in the first trimester (%)                                                                         |
|pct_mothers_4_antenatal_visits     |30. Mothers who had at least 4 antenatal care visits (%)                                                                                  |
|pct_moms_prev_tetanus              |31. Mothers whose last birth was protected against neonatal tetanus (%)                                                                  |
|pct_moms_folic_acid                |32. Mothers who consumed iron folic acid for 100 days or more when they were pregnant (%)                                                 |
|pct_moms_full_antenatal            |33. Mothers who had full antenatal care8 (%)                                                                                              |
|pct_moms_mcp_card                  |34. Registered pregnancies for which the mother received Mother and Child Protection (MCP) card (%)                                       |
|pct_moms_postnatal                 |35. Mothers who received postnatal care from a doctor/nurse/LHV/ANM/midwife/other health personnel within 2 days of delivery (%)           |
|pct_moms_fin_assistance            |36. Mothers who received financial assistance under Janani Suraksha Yojana (JSY) for births delivered in an institution (%)                  |
|pocket_expense_birth               |37. Average out-of-pocket expenditure per delivery in public health facility (Rs.)                                                        |
|pct_home_births_taken_facility     |38. Children born at home who were taken to a health facility for check-up within 24 hours of birth (%)                                   |
|pct_births_checkup_2days           |39. Children who received a health check after birth from a doctor/nurse/LHV/ANM/midwife/other health personnel within 2 days of birth (%)|
|pct_institutional_births           |40. Institutional births (%)                                                                                                              |
|pct_institutional_births_public    |41. Institutional births in public facility (%)                                                                                           |
|pct_home_delivery_skilled_personnel|42. Home delivery conducted by skilled health personnel (out of total deliveries) (%)                                                     |
|pct_births_assisted                |43. Births assisted by a doctor/nurse/LHV/ANM/other health personnel (%)                                                                  |
|pct_births_csection                |44. Births delivered by caesarean section (%)                                                                                             |
|pct_births_private_csection        |45. Births in a private health facility delivered by caesarean section (%)                                                                |
|pct_births_public_csection         |46. Births in a public health facility delivered by caesarean section (%)                                                                 |
|pct_kids_fully_immunized           |47. Children age 12-23 months fully immunized (BCG, measles, and 3 doses each of polio and DPT) (%)                                       |
|pct_kids_bcg                       |48. Children age 12-23 months who have received BCG (%)                                                                                   |
|pct_kids_polio_vacc                |49. Children age 12-23 months who have received 3 doses of polio vaccine (%)                                                              |
|pct_kids_dpt                       |50. Children age 12-23 months who have received 3 doses of DPT vaccine (%)                                                                |
|pct_kids_measles_vacc              |51. Children age 12-23 months who have received measles vaccine (%)                                                                       |
|pct_kids_hep_vacc                  |52. Children age 12-23 months who have received 3 doses of Hepatitis B vaccine (%)                                                        |
|pct_kids_vitamin_a                 |53. Children age 9-59 months who received a vitamin A dose in last 6 months (%)                                                           |
|pct_kids_vacc_public               |54. Children age 12-23 months who received most of the vaccinations in public health facility (%)                                         |
|pct_kids_vacc_private              |55. Children age 12-23 months who received most of the vaccinations in private health facility (%)                                        |
|pct_diarrhea_2weeks                |56. Prevalence of diarrhoea (reported) in the last 2 weeks preceding the survey (%)                                                       |
|pct_kids_diarrhea_ors              |57. Children with diarrhoea in the last 2 weeks who received oral rehydration salts (ORS) (%)                                             |
|pct_kids_diarrhea_zinc             |58. Children with diarrhoea in the last 2 weeks who received zinc (%)                                                                     |
|pct_kids_diarrhea_facility         |59. Children with diarrhoea in the last 2 weeks taken to a health facility (%)                                                            |
|pct_kids_ari                       |60. Prevalence of symptoms of acute respiratory infection (ARI) in the last 2 weeks preceding the survey (%)                              |
|pct_kids_ari_facility              |61. Children with fever or symptoms of ARI in the last 2 weeks preceding the survey taken to a health facility (%)                        |
|pct_kids_breastfed                 |62. Children under age 3 years breastfed within one hour of birth9 (%)                                                                    |
|pct_kids_only_breastfed            |63. Children under age 6 months exclusively breastfed10 (%)                                                                               |
|pct_kids_food_breastmilk           |64. Children age 6-8 months receiving solid or semi-solid food and breastmilk10 (%)                                                       |
|pct_breastfed_adeq_diet            |65. Breastfeeding children age 6-23 months receiving an adequate diet10,11 (%)                                                            |
|pct_nonbreastfed_adeq_diet         |66. Non-breastfeeding children age 6-23 months receiving an adequate diet10,11 (%)                                                        |
|pct_kids_adeq_diet                 |67. Total children age 6-23 months receiving an adequate diet10,11 (%)                                                                    |
|pct_kids_stunted                   |68. Children under 5 years who are stunted (height-for-age)12 (%)                                                                         |
|pct_kids_wasted                    |69. Children under 5 years who are wasted (weight-for-height)12 (%)                                                                       |
|pct_kids_severely_wasted           |70. Children under 5 years who are severely wasted (weight-for-height)13 (%)                                                              |
|pct_kids_underweight               |71. Children under 5 years who are underweight (weight-for-age)12 (%)                                                                     |
|pct_women_underweight              |72. Women whose Body Mass Index (BMI) is below normal (BMI < 18.5 kg/m2)14 (%)                                                            |
|pct_men_underweight                |73. Men whose Body Mass Index (BMI) is below normal (BMI < 18.5 kg/m2) (%)                                                                |
|pct_women_overweight               |74. Women who are overweight or obese (BMI ≥ 25.0 kg/m2)14 (%)                                                                            |
|pct_men_overweight                 |75. Men who are overweight or obese (BMI ≥ 25.0 kg/m2) (%)                                                                                |
|pct_kids_anaemic                   |76. Children age 6-59 months who are anaemic (<11.0 g/dl) (%)                                                                             |
|pct_nonpreg_women_anaemic          |77. Non-pregnant women age 15-49 years who are anaemic (<12.0 g/dl) (%)                                                                   |
|pct_preg_women_anaemic             |78. Pregnant women age 15-49 years who are anaemic (<11.0 g/dl) (%)                                                                       |
|pct_women_anaemic                  |79. All women age 15-49 years who are anaemic (%)                                                                                         |
|pct_men_anaemic                    |80. Men age 15-49 years who are anaemic (<13.0 g/dl) (%)                                                                                  |
|pct_women_high_sugar               |81. Women age 15-49 years with high blood sugar level (>140 mg/dl) (%)                                                                                             |
|pct_women_very_high_sugar          |82. Women age 15-49 years with very high blood sugar level (>160 mg/dl) (%)                                                                                        |
|pct_men_high_sugar                 |83. Men age 15-49 years with high blood sugar level (>140 mg/dl) (%)                                                                                             |
|pct_men_very_high_sugar            |84. Men age 15-49 years with very high blood sugar level (>160 mg/dl) (%)                                                                                        |
|pct_women_medium_bp                |85. Women age 15-49 years with blood pressure slightly above normal (Systolic 140-159 mm of Hg and/or Diastolic 90-99 mm of Hg) (%)   |
|pct_women_high_bp                  |86. Women age 15-49 years with moderately high blood pressure (Systolic 160-179 mm of Hg and/or Diastolic 100-109 mm of Hg) (%)                               |
|pct_women_very_high_bp             |87. Women age 15-49 years with very high blood pressure (Systolic ≥180 mm of Hg and/or Diastolic ≥110 mm of Hg) (%)                                                    |
|pct_men_medium_bp                  |88. Men age 15-49 years with blood pressure slightly above normal (Systolic 140-159 mm of Hg and/or Diastolic 90-99 mm of Hg) (%)                           |
|pct_men_high_bp                    |89. Men age 15-49 years with moderately high blood pressure (Systolic 160-179 mm of Hg and/or Diastolic 100-109 mm of Hg) (%)                      |
|pct_men_very_high_bp               |90. Men age 15-49 years with very high blood pressure (Systolic ≥180 mm of Hg and/or Diastolic ≥110 mm of Hg) (%)                                   |
|pct_women_cervix_exam              |91. Women age 15-49 years who have ever undergone cervix exam (%)                                                                     |
|pct_women_breast_exam              |92. Women age 15-49 years who have ever undergone breast exam (%)                                                                                  |
|pct_women_oral_exam                |93. Women age 15-49 years who have ever undergone oral cavity exam (%)                                                                            |
