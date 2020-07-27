# Script to build data objects for shiny app from amlprojectdata data
# package.

library(here)
library(tidyverse)

#set true to rerun the correlations
run_corr <- FALSE

knitr::opts_chunk$set(echo = TRUE)
library(plotly)

library(here)
library(readr)
library(readxl)
library(ggplot2)
library(dplyr)
library(DT)
library(janitor)

source("R/helper.R")


if(run_corr == TRUE){
  library(amlprojectdata)
  data(sensitivity)
  data("cytokine_data_long")
  cytokine_data_long <- cytokine_data_long %>% mutate(value = log2(value))

  cytokines <- cytokine_data_long %>% pull(cytokine) %>% unique()

  cyto_list <- lapply(cytokines, function(x){cytokine_data_long %>% 
    select(lab_id, cytokine, out_var=value) %>% filter(cytokine == !!x)})

  names(cyto_list) <- cytokines
    inhibitors <- sensitivity %>% pull(inhibitor) %>% unique()

  #separate out drug data into individual data frames
  drug_list <- lapply(inhibitors, function(x){
    sensitivity %>% select(lab_id,inhibitor,drug_auc = auc) %>%
    filter(inhibitor == x)
    }) 
# label the list
names(drug_list) <- inhibitors

# make all combinations of drugs/cytokines
all_combos <- expand.grid(inhibitors, cytokines)

ac_list <- split(all_combos, seq(nrow(all_combos)))

##correlate all drug/cytokine combos
cor_list <- lapply(ac_list, calc_cor, cyto_list, drug_list)

cor_vec <- bind_rows(cor_list)

out_frame <- data.frame(all_combos, cor_vec) %>% select(drug=Var1, cytokine=Var2, correlation=estimate, pvalue="p.value") %>% mutate(FDR=p.adjust(pvalue, method="BH"))
}

if(run_corr ==FALSE){
load(here("data/corr_results.rda"))
}


correlations <- out_frame %>% 
  select(drug, cytokine, correlation, FDR)

correlation_mat <- correlations %>%
  select(drug, cytokine, correlation) %>%
  tidyr::pivot_wider(id_cols = c(drug), 
                     names_from="cytokine",
                     values_from = "correlation") 

correlation_mat2 <- as.matrix(correlation_mat[,-1])
rownames(correlation_mat2) <- correlation_mat$drug
  
h <- heatmaply::heatmapr(correlation_mat2)

matrows <- h$matrix$rows
matcols <- h$matrix$cols

save(correlations, correlation_mat2, cyto_list, drug_list,
     matcols, matrows, file=here("data/data.RData"))