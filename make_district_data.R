#------------SETUP--------------------

if (!require("pacman")) install.packages("pacman")
pacman::p_load("tabulizer", "tidyverse", "rvest", "readxl", "janitor")

#-------------SCRAPE DATA-----------------

# read URLs and clean them
urls <- read_xlsx("nfhs_urls.xlsx")$Link
urls <- gsub(" ", "%20", urls)
urls <- gsub("amp;", "", urls)

cnames <- c("vbl", "val", "district", "district_num", "state_code")
dists <- data.frame(vbl = NA, val = NA, district = NA,
                    district_num = NA, state_code = NA)

# helper function to extract info from fact sheet, append to dists
extract <- function(url) {
  short <- sub("http://rchiips.org/NFHS/FCTS/", "", url)
  s_code <- substr(short, 1, 2)
  s <- paste0(s_code, "/", s_code, "_Factsheet_")
  shorter <- substr(short, 17, str_length(short))
  shortest <- str_split(sub(".pdf", "", shorter), "_")[[1]]
  dist_name <- gsub("%20", " ", shortest[[2]])
  dist_num <- shortest[[1]]
  tab <- extract_tables(url)
  if (length(tab) > 4) print("real shit going down")
  if (length(tab) == 4) tab <- tab[-1]
  df <- tab %>% do.call(what = "rbind") %>% as_tibble()
  colnames(df) <- c("vbl", "val")
  df$district <- dist_name
  df$district_num <- dist_num
  df$state_code <- s_code
  dists <<- bind_rows(dists, df)
}

sapply(urls, extract)

# remove empty row
dists <- dists[2:nrow(dists),]

#------------------CLEAN EXTRACTED TABLES-----------------

# helper to clean statistics into numbers
numerify <- function(col) {
  new <- sapply(col, function(x) {
    x <- gsub(",", "", gsub("\\(", "", gsub("\\)", "", x)))
    # keep real NAs as a fake value so they don't get removed
    return(as.numeric(x))
  })
  return(unname(new))
}  

# remove useless rows
extra <- c("Indicators", "Population and Household Profile", "Marriage and Fertility", 
           "Maternal and Child Health", "Nutritional Status of Adults (age 15-49 years)")
clean <- dists %>% 
  filter(!vbl %in% extra, val != "") %>%
  separate(val, into = c("Rural", "Urban", "Total"), sep = " ") %>% 
  mutate(Total = ifelse(is.na(Total), Urban, Total)) %>%
  mutate(Total = numerify(Total)) %>% 
  select(-c(Rural, Urban))

# clean cut-off lines to have the full description
clean$vbl <- sub("(MCP) card (%)", 
                 "34. Registered pregnancies for which the mother received Mother and Child Protection (MCP) card (%)", clean$vbl, fixed = T)
clean$vbl <- sub("personnel within 2 days of delivery (%)",
                 "35. Mothers who received postnatal care from a doctor/nurse/LHV/ANM/midwif/other health personnel within 2 days of delivery (%)", clean$vbl, fixed = T)
clean$vbl <- sub("^delivered in an institution \\(%\\)",
                 "36. Mothers who received financial assistance under Janani Suraksha Yojana (JSY) for births delivered in institution (%)", clean$vbl, fixed = F)
clean$vbl <- sub("delivered in an institution (%)",
                 "36. Mothers who received financial assistance under Janani Suraksha Yojana (JSY) for births delivered in an institution (%)", clean$vbl, fixed = T)
clean$vbl <- sub("health personnel within 2 days of birth (%)", 
                 "39. Children who received a health check after birth from a doctor/nurse/LHV/ANM/midwife/other
health personnel within 2 days of birth (%)", clean$vbl, fixed = T)
clean$vbl <- sub("polio and DPT) (%)",
                 "47. Children age 12-23 months fully immunized (BCG, measles, and 3 doses each of polio and DPT) (%)", clean$vbl, fixed = T)
clean$vbl <- sub("^DPT) \\(%\\)",
                 "47. Children age 12-23 months fully immunized (BCG, measles, and 3 doses each of polio and DPT) (%)", clean$vbl, fixed = F)
clean$vbl <- sub("^health facility \\(%\\)",
                 "61. Children with fever or symptoms of ARI in the last 2 weeks preceding the survey taken to a health facility (%)", clean$vbl, fixed = F)
clean$vbl <- sub("^birth \\(%\\)",
                 "38. Children born at home who were taken to a health facility for check-up within 24 hours of birth (%)", clean$vbl, fixed = F)
clean$vbl <- sub("^facility \\(%\\)",
                 "61. Children with fever or symptoms of ARI in the last 2 weeks preceding the survey taken to a health facility (%)", clean$vbl, fixed = F)
clean$vbl <- sub("^survey \\(%\\)",
                 "60. Prevalence of symptoms of acute respiratory infection (ARI) in the last 2 weeks preceding the survey (%)", clean$vbl, fixed = F)

#-------------------RESHAPE BY DISTRICT----------------------

# helper to get question number from question, needed to arrange in order
get_num <- function(vbl) {
  unname(sapply(vbl, function(x) {
    return(as.numeric(str_split(x, "\\.")[[1]][1]))
  }))
}

# arrange question numbers in order
full_names <- clean %>% tabyl(vbl) %>%
  mutate(n = get_num(vbl)) %>% filter(!is.na(vbl)) %>% arrange(n) %>% pull(vbl)

# make more readable names for final dataset
names_q <- c("pct_female_ever_school", "pct_below_15", "sex_ratio", "sex_ratio_5years",
             "pct_kids_u5_registered_birth", "pct_hh_electrified", "pct_hh_clean_water",
             "pct_hh_sanitation", "pct_hh_clean_fuel", "pct_hh_iodized_salt",
             "pct_has_insurance", "pct_literate_women", "pct_literate_men",
             "pct_women_10yrs_school", "pct_young_women_married_pre18",
             "pct_young_men_married_pre21", "pct_teen_women_mothers",
             "pct_any_contraception","pct_modern_contraception", "pct_fem_sterilization",
             "pct_male_sterilization", "pct_using_iud", "pct_using_pill", "pct_using_condoms",
             "pct_unmet_need_contraception", "pct_unmet_need_spacing",
             "pct_health_worker_spoke_contra", "pct_users_told_side_effects",
             "pct_moms_1trimester_checkup", "pct_mothers_4_antenatal_visits",
             "pct_moms_prev_tetanus", "pct_moms_folic_acid", "pct_moms_full_antenatal",
             "pct_moms_mcp_card", "pct_moms_postnatal", "pct_moms_fin_assistance",
             "pocket_expense_birth", "pct_home_births_taken_facility", 
             "pct_births_checkup_2days", "pct_institutional_births",
             "pct_institutional_births_public", "pct_home_delivery_skilled_personnel",
             "pct_births_assisted", "pct_births_csection", "pct_births_private_csection",
             "pct_births_public_csection", "pct_kids_fully_immunized", "pct_kids_bcg",
             "pct_kids_polio_vacc", "pct_kids_dpt", "pct_kids_measles_vacc", 
             "pct_kids_hep_vacc", "pct_kids_vitamin_a",
             "pct_kids_vacc_public", "pct_kids_vacc_private", "pct_diarrhea_2weeks",
             "pct_kids_diarrhea_ors", "pct_kids_diarrhea_zinc", "pct_kids_diarrhea_facility",
             "pct_kids_ari", "pct_kids_ari_facility", "pct_kids_breastfed", 
             "pct_kids_only_breastfed", "pct_kids_food_breastmilk", "pct_breastfed_adeq_diet",
             "pct_nonbreastfed_adeq_diet", "pct_kids_adeq_diet", "pct_kids_stunted",
             "pct_kids_wasted", "pct_kids_severely_wasted", "pct_kids_underweight",
             "pct_women_underweight", "pct_men_underweight", "pct_women_overweight",
             "pct_men_overweight", "pct_kids_anaemic", "pct_nonpreg_women_anaemic", 
             "pct_preg_women_anaemic", "pct_women_anaemic", "pct_men_anaemic",
             "pct_women_high_sugar", "pct_women_very_high_sugar", "pct_men_high_sugar",
             "pct_men_very_high_sugar", "pct_women_medium_bp", "pct_women_high_bp",
             "pct_women_very_high_bp", "pct_men_medium_bp", "pct_men_high_bp", 
             "pct_men_very_high_bp", "pct_women_cervix_exam", "pct_women_breast_exam",
             "pct_women_oral_exam")
names(names_q) <- full_names

# reshape and rename columns
wide <- clean %>% 
  filter(vbl != "Nutritional Status of Adults (age 15-49 years)") %>%
  spread(vbl, Total) %>%
  select(append(c("district", "district_num", "state_code"), full_names))

colnames(wide)[4:96] <- sapply(colnames(wide)[4:96], function(x) { return(names_q[x])})

# write final data dictionary and data
cols <- append(c("District name", "District number", "State code"), full_names)
dict <- data.frame(Variable = colnames(wide), Meaning = cols)
write.csv(dict, "district_data_dict.csv", row.names = F)

write.csv(wide, "district_nfhs_final.csv", row.names = F)
