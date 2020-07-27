#' Title
#'
#' @param x 
#' @param drug 
#' @param cyto_list 
#' @param drug_list 
#'
#' @return
#' @export
#'
#' @examples
plot_corr <- function(x, cyto_list, drug_list){

  
  comb_frame <- get_inner_join(x,
                               cyto_list, drug_list)

  if(is.null(comb_frame)){return(NULL)}
    
    
  cytokine <- x$Var2
  drug <- x$Var1
  
  cor_val <- signif(
    cor(as.numeric(comb_frame$drug_auc), as.numeric(comb_frame$out_var)),
    digits = 3)
  
  comb_frame %>% ggplot(aes_string(x="out_var", y="drug_auc")) +
    geom_point() + stat_smooth(method=lm, se=FALSE) +
    ggtitle(paste0(cytokine, " vs. ", drug, " correlation=", cor_val)) + 
    theme(axis.text.x = element_text(angle = 90)) + xlab("Cytokine Expression") +
    ylab("Drug AUC")
}

#' Title
#'
#' @param x 
#' @param cyto_list 
#' @param drug_list 
#'
#' @return
#' @export
#'
#' @examples
get_inner_join <- function(x, cyto_list, drug_list){
  
  cytokine <- as.character(x$Var2)
  drug <- as.character(x$Var1)
  
  if(!cytokine %in% names(cyto_list)) {return(NULL)}
  if(!drug %in% names(drug_list)){return(NULL)}
  
  cyto_frame <- tidyr::drop_na(cyto_list[[cytokine]])
  drug_frame <- tidyr::drop_na(drug_list[[drug]])
  
  comb_frame <- cyto_frame %>% 
    inner_join(y=drug_frame, by=c("lab_id"="lab_id"))
  comb_frame
}



#plot_corr(cytokine = cytokines[1], drug=inhibitors[1], cyto_list, drug_list)

#' Title
#'
#' @param x 
#' @param cyto_list 
#' @param drug_list 
#'
#' @return
#' @export
#'
#' @examples
calc_cor <- function(x, cyto_list, drug_list){
  
  comb_frame <- get_inner_join(x,
                               cyto_list, drug_list)
  
  if(is.null(comb_frame)){return(NULL)}  

  cor_val <- try(cor.test(as.numeric(comb_frame$out_var), comb_frame$drug_auc))
  return(cor_val[c("estimate", "p.value")])
}