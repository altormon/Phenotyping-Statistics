# Open libraries and files
# options(repos = c(CRAN = "https://cloud.r-project.org"))
rm(list = ls())
packages = c("readxl", "car", "rcompanion", "rstatix", "multcomp", "emmeans", "ggplot2", "nortest", "e1071", "onewaytests", "dplyr", "BFpack", "PMCMRplus", "dunn.test", "PMCMR", "agricolae", "openxlsx")
for(i in packages){if(!requireNamespace(i, quietly = TRUE)){install.packages(i)}}
for(i in packages){library(i, character.only = TRUE)}
dir = setwd(dirname(rstudioapi::getSourceEditorContext()$path))
filename = paste(dir,"/Phenotyping_Analysis.xlsx",sep="")
conditions_data = read_excel(filename, sheet = "Conditions")
lines_data = read_excel(filename, sheet = "TemplateLines")

# All lines and groups data (WTs are the same)
variability_nh = 2
variability = as.numeric(as.list(conditions_data[23,7])$...7)
p_method = as.character(as.list(conditions_data[26,7])$...7)
treatments = as.list(conditions_data[3:4,7])$...7
lines_names = as.character(lapply(as.list(conditions_data[10:25,2])$...2, function(x) gsub("-", "", x)))
variables = as.list(conditions_data[12:20,7])$...7
measures = as.list(conditions_data[7:9,7])$...7
wt1 = as.data.frame(sapply(lines_data[9:2998,2:10], as.numeric))
wt2 = as.data.frame(sapply(lines_data[9:2998,12:20], as.numeric))
wt3 = as.data.frame(sapply(lines_data[9:2998,22:30], as.numeric))
wt4 = as.data.frame(sapply(lines_data[9:2998,32:40], as.numeric))
l1 = as.data.frame(sapply(lines_data[9:2998,42:50], as.numeric))
l2 = as.data.frame(sapply(lines_data[9:2998,52:60], as.numeric))
l3 = as.data.frame(sapply(lines_data[9:2998,62:70], as.numeric))
l4 = as.data.frame(sapply(lines_data[9:2998,72:80], as.numeric))
l5 = as.data.frame(sapply(lines_data[9:2998,82:90], as.numeric))
l6 = as.data.frame(sapply(lines_data[9:2998,92:100], as.numeric))
l7 = as.data.frame(sapply(lines_data[9:2998,102:110], as.numeric))
l8 = as.data.frame(sapply(lines_data[9:2998,112:120], as.numeric))
l9 = as.data.frame(sapply(lines_data[9:2998,122:130], as.numeric))
l10 = as.data.frame(sapply(lines_data[9:2998,132:140], as.numeric))
l11 = as.data.frame(sapply(lines_data[9:2998,142:150], as.numeric))
l12 = as.data.frame(sapply(lines_data[9:2998,152:160], as.numeric))
colnames(wt1) = variables
colnames(wt2) = variables
colnames(wt3) = variables
colnames(wt4) = variables
colnames(l1) = variables
colnames(l2) = variables
colnames(l3) = variables
colnames(l4) = variables
colnames(l5) = variables
colnames(l6) = variables
colnames(l7) = variables
colnames(l8) = variables
colnames(l9) = variables
colnames(l10) = variables
colnames(l11) = variables
colnames(l12) = variables

# Dataframe from lines, treatment as variable
wt1_df_treatment = data.frame(measure1 = c(wt1[[1]], wt1[[2]]), measure2 = c(wt1[[3]], wt1[[4]]), measure3 = c(wt1[[5]], wt1[[6]]), line = factor(rep(c(lines_names[1]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
wt2_df_treatment = data.frame(measure1 = c(wt2[[1]], wt2[[2]]), measure2 = c(wt2[[3]], wt2[[4]]), measure3 = c(wt2[[5]], wt2[[6]]), line = factor(rep(c(lines_names[2]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
wt3_df_treatment = data.frame(measure1 = c(wt3[[1]], wt3[[2]]), measure2 = c(wt3[[3]], wt3[[4]]), measure3 = c(wt3[[5]], wt3[[6]]), line = factor(rep(c(lines_names[3]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
wt4_df_treatment = data.frame(measure1 = c(wt4[[1]], wt4[[2]]), measure2 = c(wt4[[3]], wt4[[4]]), measure3 = c(wt4[[5]], wt4[[6]]), line = factor(rep(c(lines_names[4]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
l1_df_treatment = data.frame(measure1 = c(l1[[1]], l1[[2]]), measure2 = c(l1[[3]], l1[[4]]), measure3 = c(l1[[5]], l1[[6]]), line = factor(rep(c(lines_names[5]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
l2_df_treatment = data.frame(measure1 = c(l2[[1]], l2[[2]]), measure2 = c(l2[[3]], l2[[4]]), measure3 = c(l2[[5]], l2[[6]]), line = factor(rep(c(lines_names[6]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
l3_df_treatment = data.frame(measure1 = c(l3[[1]], l3[[2]]), measure2 = c(l3[[3]], l3[[4]]), measure3 = c(l3[[5]], l3[[6]]), line = factor(rep(c(lines_names[7]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
l4_df_treatment = data.frame(measure1 = c(l4[[1]], l4[[2]]), measure2 = c(l4[[3]], l4[[4]]), measure3 = c(l4[[5]], l4[[6]]), line = factor(rep(c(lines_names[8]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
l5_df_treatment = data.frame(measure1 = c(l5[[1]], l5[[2]]), measure2 = c(l5[[3]], l5[[4]]), measure3 = c(l5[[5]], l5[[6]]), line = factor(rep(c(lines_names[9]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
l6_df_treatment = data.frame(measure1 = c(l6[[1]], l6[[2]]), measure2 = c(l6[[3]], l6[[4]]), measure3 = c(l6[[5]], l6[[6]]), line = factor(rep(c(lines_names[10]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
l7_df_treatment = data.frame(measure1 = c(l7[[1]], l7[[2]]), measure2 = c(l7[[3]], l7[[4]]), measure3 = c(l7[[5]], l7[[6]]), line = factor(rep(c(lines_names[11]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
l8_df_treatment = data.frame(measure1 = c(l8[[1]], l8[[2]]), measure2 = c(l8[[3]], l8[[4]]), measure3 = c(l8[[5]], l8[[6]]), line = factor(rep(c(lines_names[12]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
l9_df_treatment = data.frame(measure1 = c(l9[[1]], l9[[2]]), measure2 = c(l9[[3]], l9[[4]]), measure3 = c(l9[[5]], l9[[6]]), line = factor(rep(c(lines_names[13]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
l10_df_treatment = data.frame(measure1 = c(l10[[1]], l10[[2]]), measure2 = c(l10[[3]], l10[[4]]), measure3 = c(l10[[5]], l10[[6]]), line = factor(rep(c(lines_names[14]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
l11_df_treatment = data.frame(measure1 = c(l11[[1]], l11[[2]]), measure2 = c(l11[[3]], l11[[4]]), measure3 = c(l11[[5]], l11[[6]]), line = factor(rep(c(lines_names[15]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
l12_df_treatment = data.frame(measure1 = c(l12[[1]], l12[[2]]), measure2 = c(l12[[3]], l12[[4]]), measure3 = c(l12[[5]], l12[[6]]), line = factor(rep(c(lines_names[16]), each = 5980)), treatment = factor(rep(c(treatments[1], treatments[2]), each = 2990, times = 1)))
lines_treatment = rbind(wt1_df_treatment, wt2_df_treatment, wt3_df_treatment, wt4_df_treatment, l1_df_treatment, l2_df_treatment, l3_df_treatment, l4_df_treatment, l5_df_treatment, l6_df_treatment, l7_df_treatment, l8_df_treatment, l9_df_treatment, l10_df_treatment, l11_df_treatment, l12_df_treatment)
colnames(lines_treatment) = c(measures[1], measures[2], measures[3], "lines", "treatment")

# Dataframe from lines, no treatment as variable
wt1_df = data.frame(variable1 = wt1[[1]], variable2 = wt1[[2]], variable3 = wt1[[3]], variable4 = wt1[[4]], variable5 = wt1[[5]], variable6 = wt1[[6]], variable7 = wt1[[7]], variable8 = wt1[[8]], variable9 = wt1[[9]], line = factor(rep(c(lines_names[1]), each = 2990)))
wt2_df = data.frame(variable1 = wt2[[1]], variable2 = wt2[[2]], variable3 = wt2[[3]], variable4 = wt2[[4]], variable5 = wt2[[5]], variable6 = wt2[[6]], variable7 = wt2[[7]], variable8 = wt2[[8]], variable9 = wt2[[9]], line = factor(rep(c(lines_names[2]), each = 2990)))
wt3_df = data.frame(variable1 = wt3[[1]], variable2 = wt3[[2]], variable3 = wt3[[3]], variable4 = wt3[[4]], variable5 = wt3[[5]], variable6 = wt3[[6]], variable7 = wt3[[7]], variable8 = wt3[[8]], variable9 = wt3[[9]], line = factor(rep(c(lines_names[3]), each = 2990)))
wt4_df = data.frame(variable1 = wt4[[1]], variable2 = wt4[[2]], variable3 = wt4[[3]], variable4 = wt4[[4]], variable5 = wt4[[5]], variable6 = wt4[[6]], variable7 = wt4[[7]], variable8 = wt4[[8]], variable9 = wt4[[9]], line = factor(rep(c(lines_names[4]), each = 2990)))
l1_df = data.frame(variable1 = l1[[1]], variable2 = l1[[2]], variable3 = l1[[3]], variable4 = l1[[4]], variable5 = l1[[5]], variable6 = l1[[6]], variable7 = l1[[7]], variable8 = l1[[8]], variable9 = l1[[9]], line = factor(rep(c(lines_names[5]), each = 2990)))
l2_df = data.frame(variable1 = l2[[1]], variable2 = l2[[2]], variable3 = l2[[3]], variable4 = l2[[4]], variable5 = l2[[5]], variable6 = l2[[6]], variable7 = l2[[7]], variable8 = l2[[8]], variable9 = l2[[9]], line = factor(rep(c(lines_names[6]), each = 2990)))
l3_df = data.frame(variable1 = l3[[1]], variable2 = l3[[2]], variable3 = l3[[3]], variable4 = l3[[4]], variable5 = l3[[5]], variable6 = l3[[6]], variable7 = l3[[7]], variable8 = l3[[8]], variable9 = l3[[9]], line = factor(rep(c(lines_names[7]), each = 2990)))
l4_df = data.frame(variable1 = l4[[1]], variable2 = l4[[2]], variable3 = l4[[3]], variable4 = l4[[4]], variable5 = l4[[5]], variable6 = l4[[6]], variable7 = l4[[7]], variable8 = l4[[8]], variable9 = l4[[9]], line = factor(rep(c(lines_names[8]), each = 2990)))
l5_df = data.frame(variable1 = l5[[1]], variable2 = l5[[2]], variable3 = l5[[3]], variable4 = l5[[4]], variable5 = l5[[5]], variable6 = l5[[6]], variable7 = l5[[7]], variable8 = l5[[8]], variable9 = l5[[9]], line = factor(rep(c(lines_names[9]), each = 2990)))
l6_df = data.frame(variable1 = l6[[1]], variable2 = l6[[2]], variable3 = l6[[3]], variable4 = l6[[4]], variable5 = l6[[5]], variable6 = l6[[6]], variable7 = l6[[7]], variable8 = l6[[8]], variable9 = l6[[9]], line = factor(rep(c(lines_names[10]), each = 2990)))
l7_df = data.frame(variable1 = l7[[1]], variable2 = l7[[2]], variable3 = l7[[3]], variable4 = l7[[4]], variable5 = l7[[5]], variable6 = l7[[6]], variable7 = l7[[7]], variable8 = l7[[8]], variable9 = l7[[9]], line = factor(rep(c(lines_names[11]), each = 2990)))
l8_df = data.frame(variable1 = l8[[1]], variable2 = l8[[2]], variable3 = l8[[3]], variable4 = l8[[4]], variable5 = l8[[5]], variable6 = l8[[6]], variable7 = l8[[7]], variable8 = l8[[8]], variable9 = l8[[9]], line = factor(rep(c(lines_names[12]), each = 2990)))
l9_df = data.frame(variable1 = l9[[1]], variable2 = l9[[2]], variable3 = l9[[3]], variable4 = l9[[4]], variable5 = l9[[5]], variable6 = l9[[6]], variable7 = l9[[7]], variable8 = l9[[8]], variable9 = l9[[9]], line = factor(rep(c(lines_names[13]), each = 2990)))
l10_df = data.frame(variable1 = l10[[1]], variable2 = l10[[2]], variable3 = l10[[3]], variable4 = l10[[4]], variable5 = l10[[5]], variable6 = l10[[6]], variable7 = l10[[7]], variable8 = l10[[8]], variable9 = l10[[9]], line = factor(rep(c(lines_names[14]), each = 2990)))
l11_df = data.frame(variable1 = l11[[1]], variable2 = l11[[2]], variable3 = l11[[3]], variable4 = l11[[4]], variable5 = l11[[5]], variable6 = l11[[6]], variable7 = l11[[7]], variable8 = l11[[8]], variable9 = l11[[9]], line = factor(rep(c(lines_names[15]), each = 2990)))
l12_df = data.frame(variable1 = l12[[1]], variable2 = l12[[2]], variable3 = l12[[3]], variable4 = l12[[4]], variable5 = l12[[5]], variable6 = l12[[6]], variable7 = l12[[7]], variable8 = l12[[8]], variable9 = l12[[9]], line = factor(rep(c(lines_names[16]), each = 2990)))
lines = rbind(wt1_df, wt2_df, wt3_df, wt4_df, l1_df, l2_df, l3_df, l4_df, l5_df, l6_df, l7_df, l8_df, l9_df, l10_df, l11_df, l12_df)
colnames(lines) = c(variables[1], variables[2], variables[3], variables[4], variables[5], variables[6], variables[7], variables[8], variables[9], "lines")

# Data representation (boxplots)
if(!file.exists(paste(dir,"/Boxplots/",sep=""))){dir.create(paste(dir,"/Boxplots/",sep=""))}
for(i in c(1:ncol(lines_treatment[1:length(measures)]))){tryCatch({
  if(any(!is.na(lines_treatment[[i]]))){} else {next}
  if(!file.exists(paste(dir,"/Boxplots/boxplots_lines_measures",sep=""))){dir.create(paste(dir,"/Boxplots/boxplots_lines_measures",sep=""))}
  title = gsub("/", "", measures[i])
  png(paste(dir,"/Boxplots/boxplots_lines_measures/",title,".png",sep=""))
  try(boxplot(as.numeric(na.omit(lines_treatment[[i]])) ~ lines_treatment[!is.na(lines_treatment[,i]), "lines"], ylab =measures[i], xlab = "", main = measures[i], las=1), TRUE, silent = TRUE)
  dev.off()}, error = function(e) {cat("Error in iteration", i, ": ", conditionMessage(e), "\n")})}
for(i in c(1:ncol(lines[1:length(variables)]))){tryCatch({
  if(any(!is.na(lines[[i]]))){} else {next}
  if(!file.exists(paste(dir,"/Boxplots/boxplots_lines_variables",sep=""))){dir.create(paste(dir,"/Boxplots/boxplots_lines_variables",sep=""))}
  title = gsub("/", "", variables[i])
  png(paste(dir,"/Boxplots/boxplots_lines_variables/",title,".png",sep=""))
  try(boxplot(as.numeric(na.omit(lines[[i]])) ~ lines[!is.na(lines[,i]), "lines"], ylab =variables[i], xlab = "", main = variables[i], las=1), TRUE, silent = TRUE)
  dev.off()}, error = function(e) {cat("Error in iteration", i, ": ", conditionMessage(e), "\n")})}

# Normality test (Shapiro-Wilk for n >= 50, Lilliefors for n < 50, no normal distribution if p value < 0.05 or asymmetry if n < 50, no normal distribution if p value < 0.05 and asymmetry if n >= 50)
## All lines separated (not useful, all lines are going to be analyzed together)
normality_lines_measures = rep(list(list(NA, NA, NA)), each = length(lines_names))
normality_lines_variables = rep(list(list(NA, NA, NA, NA, NA, NA, NA, NA, NA)), each = length(lines_names))
if(!file.exists(paste(dir,"/Normality/",sep=""))){dir.create(paste(dir,"/Normality/",sep=""))}
for(i in c(1:ncol(lines_treatment[1:length(measures)]))){
  for(j in c(1:length(lines_names))){tryCatch({
    if(any(!is.na(lines_treatment[lines_treatment[["lines"]]==lines_names[j],][[i]]))){} else {next}
    count = sum(!is.na(as.numeric(na.omit(lines_treatment[lines_treatment[["lines"]]==lines_names[j],][[i]]))))
    pvalue = 0
    if(count<50 && count>3){pvalue = lillie.test(na.omit(as.numeric(lines_treatment[lines_treatment[["lines"]]==lines_names[j],][[i]])))$p.value}
    if(count>49 && count>3){pvalue = shapiro.test(na.omit(as.numeric(lines_treatment[lines_treatment[["lines"]]==lines_names[j],][[i]])))$p.value}
    skew = skewness(na.omit(as.numeric(lines_treatment[lines_treatment[["lines"]]==lines_names[j],][[i]])))
    kurt = kurtosis(na.omit(as.numeric(lines_treatment[lines_treatment[["lines"]]==lines_names[j],][[i]])))
    if(count>=50){
      if(((0-0.5-variability_nh*count/100)>skew | skew>(0+0.5+variability_nh*count/100) | (3-0.5-variability_nh*count/100)>kurt | kurt>(3+0.5+variability_nh*count/100)) & pvalue<0.05){
        normality_lines_measures[[j]][i] = "no normal"} else {
          normality_lines_measures[[j]][i] = "normal"}} else {
            if(((0-0.5)>skew | skew>(0+0.5) | (3-0.5)>kurt | kurt>(3+0.5)) | pvalue<0.05){
              normality_lines_measures[[j]][i] = "no normal"} else {
                normality_lines_measures[[j]][i] = "normal"}}
    title = gsub("/", "", paste(normality_lines_measures[[j]][i]," ",lines_names[j]," ",measures[i],sep=""))
    if(!file.exists(paste(dir,"/Normality/normality_lines_measures",sep=""))){dir.create(paste(dir,"/Normality/normality_lines_measures",sep=""))}
    png(paste(dir,"/Normality/normality_lines_measures/",title,".png",sep=""))
    try(hist_result <- hist(as.numeric(lines_treatment[lines_treatment["lines"]==lines_names[j],i]), plot = FALSE), TRUE, silent = TRUE)
    try(maxhist <- max(hist_result$counts), TRUE, silent = TRUE)
    try(meanhist <- sum(hist_result$counts*hist_result$mids)/sum(hist_result$counts), TRUE, silent = TRUE)
    try(sdhist <- sqrt(sum(hist_result$counts*(hist_result$mids-meanhist)^2)/sum(hist_result$counts)), TRUE, silent = TRUE)
    try(pdfnormal <- dnorm(seq(min(hist_result$mids), max(hist_result$mids), length.out = 1000), mean = meanhist, sd = sdhist), TRUE, silent = TRUE)
    try(hist(as.numeric(lines_treatment[lines_treatment["lines"]==lines_names[j],i]), xlab = title, main = title), TRUE, silent = TRUE)
    try(lines(approx(seq(min(hist_result$mids), max(hist_result$mids), length.out = 1000), pdfnormal*maxhist/max(pdfnormal), n = 1000), col = "blue", lwd = 2), TRUE, silent = TRUE)
    dev.off()}, error = function(e) {cat("Error in iteration", i, ": ", conditionMessage(e), "\n")})}}
for(i in c(1:ncol(lines[1:length(variables)]))){
  for(j in c(1:length(lines_names))){tryCatch({
    if(any(!is.na(lines[lines[["lines"]]==lines_names[j],][[i]]))){} else {next}
    count = sum(!is.na(as.numeric(na.omit(lines[lines[["lines"]]==lines_names[j],][[i]]))))
    pvalue = 0
    if(count<50 && count>3){pvalue = lillie.test(na.omit(as.numeric(lines[lines[["lines"]]==lines_names[j],][[i]])))$p.value}
    if(count>49 && count>3){pvalue = shapiro.test(na.omit(as.numeric(lines[lines[["lines"]]==lines_names[j],][[i]])))$p.value}
    skew = skewness(na.omit(as.numeric(lines[lines[["lines"]]==lines_names[j],][[i]])))
    kurt = kurtosis(na.omit(as.numeric(lines[lines[["lines"]]==lines_names[j],][[i]])))
    if(count>=50){
      if(((0-0.5-variability_nh*count/100)>skew | skew>(0+0.5+variability_nh*count/100) | (3-0.5-variability_nh*count/100)>kurt | kurt>(3+0.5+variability_nh*count/100)) & pvalue<0.05){
        normality_lines_variables[[j]][i] = "no normal"} else {
          normality_lines_variables[[j]][i] = "normal"}} else {
            if(((0-0.5)>skew | skew>(0+0.5) | (3-0.5)>kurt | kurt>(3+0.5)) | pvalue<0.05){
              normality_lines_variables[[j]][i] = "no normal"} else {
                normality_lines_variables[[j]][i] = "normal"}}
    title = gsub("/", "", paste(normality_lines_variables[[j]][i]," ",lines_names[j]," ",variables[i],sep=""))
    if(!file.exists(paste(dir,"/Normality/normality_lines_variables",sep=""))){dir.create(paste(dir,"/Normality/normality_lines_variables",sep=""))}
    png(paste(dir,"/Normality/normality_lines_variables/",title,".png",sep=""))
    try(hist_result <- hist(as.numeric(lines[lines["lines"]==lines_names[j],i]), plot = FALSE), TRUE, silent = TRUE)
    try(maxhist <- max(hist_result$counts), TRUE, silent = TRUE)
    try(meanhist <- sum(hist_result$counts*hist_result$mids)/sum(hist_result$counts), TRUE, silent = TRUE)
    try(sdhist <- sqrt(sum(hist_result$counts*(hist_result$mids-meanhist)^2)/sum(hist_result$counts)), TRUE, silent = TRUE)
    try(pdfnormal <- dnorm(seq(min(hist_result$mids), max(hist_result$mids), length.out = 1000), mean = meanhist, sd = sdhist), TRUE, silent = TRUE)
    try(hist(as.numeric(lines[lines["lines"]==lines_names[j],i]), xlab = title, main = title), TRUE, silent = TRUE)
    try(lines(approx(seq(min(hist_result$mids), max(hist_result$mids), length.out = 1000), pdfnormal*maxhist/max(pdfnormal), n = 1000), col = "blue", lwd = 2), TRUE, silent = TRUE)
    dev.off()}, error = function(e) {cat("Error in iteration", i, ": ", conditionMessage(e), "\n")})}}
## All lines together
normality_lines_measures = c(NA, NA, NA)
normality_lines_variables = c(NA, NA, NA, NA, NA, NA, NA, NA, NA)
if(!file.exists(paste(dir,"/Normality/",sep=""))){dir.create(paste(dir,"/Normality/",sep=""))}
for(i in c(1:ncol(lines_treatment[1:length(measures)]))){tryCatch({
  if(any(!is.na(lines_treatment[[i]]))){} else {next}
  count = sum(!is.na(as.numeric(na.omit(lines_treatment[[i]]))))
  pvalue = 0
  if(count<50 && count>3){pvalue = lillie.test(na.omit(as.numeric(lines_treatment[[i]])))$p.value}
  if(count>49 && count>3){pvalue = shapiro.test(na.omit(as.numeric(lines_treatment[[i]])))$p.value}
  skew = skewness(na.omit(as.numeric(lines_treatment[[i]])))
  kurt = kurtosis(na.omit(as.numeric(lines_treatment[[i]])))
  if(count>=50){
    if(((0-0.5-variability_nh*count/100)>skew | skew>(0+0.5+variability_nh*count/100) | (3-0.5-variability_nh*count/100)>kurt | kurt>(3+0.5+variability_nh*count/100)) & pvalue<0.05){
      normality_lines_measures[i] = "no normal"} else {
        normality_lines_measures[i] = "normal"}} else {
          if(((0-0.5)>skew | skew>(0+0.5) | (3-0.5)>kurt | kurt>(3+0.5)) | pvalue<0.05){
            normality_lines_measures[i] = "no normal"} else {
              normality_lines_measures[i] = "normal"}}
  title = gsub("/", "", paste(normality_lines_measures[i]," ",measures[i],sep=""))
  if(!file.exists(paste(dir,"/Normality/normality_lines_measures",sep=""))){dir.create(paste(dir,"/Normality/normality_lines_measures",sep=""))}
  png(paste(dir,"/Normality/normality_lines_measures/",title,".png",sep=""))
  try(hist_result <- hist(as.numeric(lines_treatment[[i]]), plot = FALSE), TRUE, silent = TRUE)
  try(maxhist <- max(hist_result$counts), TRUE, silent = TRUE)
  try(meanhist <- sum(hist_result$counts*hist_result$mids)/sum(hist_result$counts), TRUE, silent = TRUE)
  try(sdhist <- sqrt(sum(hist_result$counts*(hist_result$mids-meanhist)^2)/sum(hist_result$counts)), TRUE, silent = TRUE)
  try(pdfnormal <- dnorm(seq(min(hist_result$mids), max(hist_result$mids), length.out = 1000), mean = meanhist, sd = sdhist), TRUE, silent = TRUE)
  try(hist(as.numeric(lines_treatment[[i]]), xlab = title, main = title), TRUE, silent = TRUE)
  try(lines(approx(seq(min(hist_result$mids), max(hist_result$mids), length.out = 1000), pdfnormal*maxhist/max(pdfnormal), n = 1000), col = "blue", lwd = 2), TRUE, silent = TRUE)
  dev.off()}, error = function(e) {cat("Error in iteration", i, ": ", conditionMessage(e), "\n")})}
for(i in c(1:ncol(lines[1:length(variables)]))){tryCatch({
  if(any(!is.na(lines[[i]]))){} else {next}
  count = sum(!is.na(as.numeric(na.omit(lines[[i]]))))
  pvalue = 0
  if(count<50 && count>3){pvalue = lillie.test(na.omit(as.numeric(lines[[i]])))$p.value}
  if(count>49 && count>3){pvalue = shapiro.test(na.omit(as.numeric(lines[[i]])))$p.value}
  skew = skewness(na.omit(as.numeric(lines[[i]])))
  kurt = kurtosis(na.omit(as.numeric(lines[[i]])))
  if(count>=50){
    if(((0-0.5-variability_nh*count/100)>skew | skew>(0+0.5+variability_nh*count/100) | (3-0.5-variability_nh*count/100)>kurt | kurt>(3+0.5+variability_nh*count/100)) & pvalue<0.05){
      normality_lines_variables[i] = "no normal"} else {
        normality_lines_variables[i] = "normal"}} else {
          if(((0-0.5)>skew | skew>(0+0.5) | (3-0.5)>kurt | kurt>(3+0.5)) | pvalue<0.05){
            normality_lines_variables[i] = "no normal"} else {
              normality_lines_variables[i] = "normal"}}
  title = gsub("/", "", paste(normality_lines_variables[i]," ",variables[i],sep=""))
  if(!file.exists(paste(dir,"/Normality/normality_lines_variables",sep=""))){dir.create(paste(dir,"/Normality/normality_lines_variables",sep=""))}
  png(paste(dir,"/Normality/normality_lines_variables/",title,".png",sep=""))
  try(hist_result <- hist(as.numeric(lines[[i]]), plot = FALSE), TRUE, silent = TRUE)
  try(maxhist <- max(hist_result$counts), TRUE, silent = TRUE)
  try(meanhist <- sum(hist_result$counts*hist_result$mids)/sum(hist_result$counts), TRUE, silent = TRUE)
  try(sdhist <- sqrt(sum(hist_result$counts*(hist_result$mids-meanhist)^2)/sum(hist_result$counts)), TRUE, silent = TRUE)
  try(pdfnormal <- dnorm(seq(min(hist_result$mids), max(hist_result$mids), length.out = 1000), mean = meanhist, sd = sdhist), TRUE, silent = TRUE)
  try(hist(as.numeric(lines[[i]]), xlab = title, main = title), TRUE, silent = TRUE)
  try(lines(approx(seq(min(hist_result$mids), max(hist_result$mids), length.out = 1000), pdfnormal*maxhist/max(pdfnormal), n = 1000), col = "blue", lwd = 2), TRUE, silent = TRUE)
  dev.off()}, error = function(e) {cat("Error in iteration", i, ": ", conditionMessage(e), "\n")})}

# Homogeneity of variances test (non-homoscedasticity if p.value<0.05; Hartley test for >2 groups with balanced design, Levene for other cases, check residuals' homogeneity with Shapiro test)
homoscedasticity_lines_measures = c(NA, NA, NA)
homoscedasticity_lines_variables = c(NA, NA, NA, NA, NA, NA, NA, NA, NA)
if(!file.exists(paste(dir,"/Homoscedasticity/",sep=""))){dir.create(paste(dir,"/Homoscedasticity/",sep=""))}
for(i in c(1:ncol(lines_treatment[1:length(measures)]))){tryCatch({
  if(any(!is.na(lines_treatment[[i]]))){} else {next}
  count = sum(!is.na(as.numeric(na.omit(lines_treatment[[i]]))) & !duplicated(lines_treatment[!is.na(lines_treatment[,i]), "lines"]))
  if(count>2){homoscedasticity_lines_measures[i] = tryCatch({hartleyTest(as.numeric(na.omit(lines_treatment[,i])) ~ lines_treatment[!is.na(lines_treatment[,i]), "lines"])$p.value}, warning = function(a) {homoscedasticity_lines_measures[i] = leveneTest(as.numeric(na.omit(lines_treatment[,i])) ~ lines_treatment[!is.na(lines_treatment[,i]), "lines"])$`Pr(>F)`[1]})} else {
    homoscedasticity_lines_measures[i] = leveneTest(as.numeric(na.omit(lines_treatment[,i])) ~ lines_treatment[!is.na(lines_treatment[,i]), "lines"])$`Pr(>F)`[1]}
  if(as.numeric(homoscedasticity_lines_measures[i]) > 0.05){homoscedasticity_lines_measures[i] = "homoscedasticity"} else {
    res = resid(lm(as.numeric(na.omit(lines_treatment[,i])) ~ lines_treatment[!is.na(lines_treatment[,i]), "lines"]))
    count = sum(!is.na(res))
    pvalue = 0
    if(count<50 && count>3){pvalue = lillie.test(res)$p.value}
    if(count>49 && count>3){pvalue = shapiro.test(res)$p.value}
    skew = skewness(res)
    kurt = kurtosis(res)
    if(count>=50){
      if(((0-0.5-variability_nh*count/100)>skew | skew>(0+0.5+variability_nh*count/100) | (3-0.5-variability_nh*count/100)>kurt | kurt>(3+0.5+variability_nh*count/100)) & pvalue<0.05){
        homoscedasticity_lines_measures[i] = "no homoscedasticity"} else {
          homoscedasticity_lines_measures[i] = "homoscedasticity"}} else {
            if(((0-0.5)>skew | skew>(0+0.5) | (3-0.5)>kurt | kurt>(3+0.5)) | pvalue<0.05){
              homoscedasticity_lines_measures[i] = "no homoscedasticity"} else {
                homoscedasticity_lines_measures[i] = "homoscedasticity"}}}
  title = gsub("/", "", paste(homoscedasticity_lines_measures[i]," ",measures[i],sep=""))
  if(!file.exists(paste(dir,"/Homoscedasticity/homoscedasticity_lines_measures",sep=""))){dir.create(paste(dir,"/Homoscedasticity/homoscedasticity_lines_measures",sep=""))}
  png(paste(dir,"/Homoscedasticity/homoscedasticity_lines_measures/",title,".png",sep=""))
  try(boxplot(resid(lm(as.numeric(na.omit(lines_treatment[,i])) ~ lines_treatment[!is.na(lines_treatment[,i]), "lines"])) ~ lines_treatment[!is.na(lines_treatment[,i]), "lines"], ylab = "Residuals", xlab = "", main = title, las=1), TRUE, silent = TRUE)
  dev.off()}, error = function(e) {cat("Error in iteration", i, ": ", conditionMessage(e), "\n")})}
for(i in c(1:ncol(lines[1:length(variables)]))){tryCatch({
  if(any(!is.na(lines[[i]]))){} else {next}
  count = sum(!is.na(as.numeric(na.omit(lines[[i]]))) & !duplicated(lines[!is.na(lines[,i]), "lines"]))
  if(count>2){homoscedasticity_lines_variables[i] = tryCatch({hartleyTest(as.numeric(na.omit(lines[,i])) ~ lines[!is.na(lines[,i]), "lines"])$p.value}, warning = function(a) {homoscedasticity_lines_variables[i] = leveneTest(as.numeric(na.omit(lines[,i])) ~ lines[!is.na(lines[,i]), "lines"])$`Pr(>F)`[1]})} else {
    homoscedasticity_lines_variables[i] = leveneTest(as.numeric(na.omit(lines[,i])) ~ lines[!is.na(lines[,i]), "lines"])$`Pr(>F)`[1]}
  if(as.numeric(homoscedasticity_lines_variables[i]) > 0.05){homoscedasticity_lines_variables[i] = "homoscedasticity"} else {
    res = resid(lm(as.numeric(na.omit(lines[,i])) ~ lines[!is.na(lines[,i]), "lines"]))
    count = sum(!is.na(res))
    pvalue = 0
    if(count<50 && count>3){pvalue = lillie.test(res)$p.value}
    if(count>49 && count>3){pvalue = shapiro.test(res)$p.value}
    skew = skewness(res)
    kurt = kurtosis(res)
    if(count>=50){
      if(((0-0.5-variability_nh*count/100)>skew | skew>(0+0.5+variability_nh*count/100) | (3-0.5-variability_nh*count/100)>kurt | kurt>(3+0.5+variability_nh*count/100)) & pvalue<0.05){
        homoscedasticity_lines_variables[i] = "no homoscedasticity"} else {
          homoscedasticity_lines_variables[i] = "homoscedasticity"}} else {
            if(((0-0.5)>skew | skew>(0+0.5) | (3-0.5)>kurt | kurt>(3+0.5)) | pvalue<0.05){
              homoscedasticity_lines_variables[i] = "no homoscedasticity"} else {
                homoscedasticity_lines_variables[i] = "homoscedasticity"}}}
  title = gsub("/", "", paste(homoscedasticity_lines_variables[i]," ",variables[i],sep=""))
  if(!file.exists(paste(dir,"/Homoscedasticity/homoscedasticity_lines_variables",sep=""))){dir.create(paste(dir,"/Homoscedasticity/homoscedasticity_lines_variables",sep=""))}
  png(paste(dir,"/Homoscedasticity/homoscedasticity_lines_variables/",title,".png",sep=""))
  try(boxplot(resid(lm(as.numeric(na.omit(lines[,i])) ~ lines[!is.na(lines[,i]), "lines"])) ~ lines[!is.na(lines[,i]), "lines"], ylab = "Residuals", xlab = "", main = title, las=1), TRUE, silent = TRUE)
  dev.off()}, error = function(e) {cat("Error in iteration", i, ": ", conditionMessage(e), "\n")})}

# Sample size (differences with X% variability, more variability implies less restrictive test (Fisher vs Tuckey))
counts_lines_measures = rep(list(list(NA, NA, NA)), each = length(lines_names))
counts_lines_variables = rep(list(list(NA, NA, NA, NA, NA, NA, NA, NA, NA)), each = length(lines_names))
for(i in c(1:ncol(lines_treatment[1:length(measures)]))){
  for(j in c(1:length(lines_names))){tryCatch({counts_lines_measures[[j]][i] = sum(!is.na(as.numeric(lines_treatment[lines_treatment[[4]]==lines_names[j],][[i]])))}, error = function(e) {cat("Error in iteration", i, ": ", conditionMessage(e), "\n")})}}
for(i in c(1:ncol(lines[1:length(variables)]))){
  for(j in c(1:length(lines_names))){tryCatch({counts_lines_variables[[j]][i] = sum(!is.na(as.numeric(lines[lines[[10]]==lines_names[j],][[i]])))}, error = function(e) {cat("Error in iteration", i, ": ", conditionMessage(e), "\n")})}}

# Select test (2 lines: t test with normality or n >30, Mann-Withney for other cases. More than 2 lines: non-parametric Kruskal-Wallis (Nemenyi for equal sample size, Dunn for other cases); parametric: Tukey (homocedasticity + equal sample size), Fisher (homocedasticity + unequal sample size), Dunnet T3 (no homocedasticity + unequal sample size + n<50), Games-Howell (no homocedasticity + unequal sample size + n>49))
test_lines_measures = c(NA, NA, NA)
test_lines_variables = c(NA, NA, NA, NA, NA, NA, NA, NA, NA)
for(i in c(1:ncol(lines_treatment[1:length(measures)]))){tryCatch({
  if(any(!is.na(lines_treatment[[i]]))){} else {next}
  counts = sapply(counts_lines_measures, "[[", i)
  counts = counts[counts != 0]
  if(length(counts) < 2){next}
  if(length(counts) == 2){
    if(normality_lines_measures[i] == "normal" | mean(counts) > 30){test_lines_measures[i] = "tTest"} 
    else {test_lines_measures[i] = "MannWithney"}}
  else {
    if(normality_lines_measures[i] == "normal"){
      if(homoscedasticity_lines_measures[i] == "homoscedasticity"){
        if(((sd(counts)/sqrt(length(counts)))/mean(counts))<=(variability/100)){test_lines_measures[i] = "Tukey"}
        else{test_lines_measures[i] = "Fisher"}}
      else{
        if(mean(counts)<50){test_lines_measures[i] = "DunnetT3"}
        else{test_lines_measures[i] = "GamesHowell"}}}
    else{if(((sd(counts)/sqrt(length(counts)))/mean(counts))<=(variability/100)){test_lines_measures[i] = "KruskalWallisNemenyi"}
      else{test_lines_measures[i] = "KruskalWallisDunn"}}
  }}, error = function(e) {cat("Error in iteration", i, ": ", conditionMessage(e), "\n")})}
for(i in c(1:ncol(lines[1:length(variables)]))){tryCatch({
  if(any(!is.na(lines[[i]]))){} else {next}
  counts = sapply(counts_lines_variables, "[[", i)
  counts = counts[counts != 0]
  if(length(counts) < 2){next}
  if(length(counts) == 2){
    if(normality_lines_variables[i] == "normal" | mean(counts) > 30){test_lines_variables[i] = "tTest"} 
    else {test_lines_variables[i] = "MannWithney"}}
  else {
    if(normality_lines_variables[i] == "normal"){
      if(homoscedasticity_lines_variables[i] == "homoscedasticity"){
        if(((sd(counts)/sqrt(length(counts)))/mean(counts))<=(variability/100)){test_lines_variables[i] = "Tukey"}
        else{test_lines_variables[i] = "Fisher"}}
      else{
        if(mean(counts)<50){test_lines_variables[i] = "DunnetT3"}
        else{test_lines_variables[i] = "GamesHowell"}}}
    else{if(((sd(counts)/sqrt(length(counts)))/mean(counts))<=(variability/100)){test_lines_variables[i] = "KruskalWallisNemenyi"}
      else{test_lines_variables[i] = "KruskalWallisDunn"}}
  }}, error = function(e) {cat("Error in iteration", i, ": ", conditionMessage(e), "\n")})}

# Do tests
anova_lines_measures = vector("list", 3)
for(i in 1:3){anova_lines_measures[[i]] = vector("character", length(na.omit(lines_names)))}
anova_lines_variables = vector("list", 9)
for(i in 1:9){anova_lines_variables[[i]] = vector("character", length(na.omit(lines_names)))}
order_letters = function(list1, list2, list3){
  new_list = vector(length = length(list1))
  for(i in 1:length(list1)){
    index = match(list1[i], list2)
    new_list[i] = list3[index]}
  return(new_list)}
pvalues_to_dataframe = function(pvalues, names){
  n = length(names)
  p_adjusted_matrix = matrix(NA, nrow = n, ncol = n)
  cont = 1
  for(i in c(1:n)){
    for(j in c(i:n)){
      if(j %in% c((i+1):n)){
        p_adjusted_matrix[j,i] = pvalues[cont]
        cont = cont + 1}}}
  p_adjusted_df = as.data.frame(p_adjusted_matrix)
  colnames(p_adjusted_df) = names
  rownames(p_adjusted_df) = names
  return(p_adjusted_df)}
for(i in c(1:length(na.omit(test_lines_variables)))){
  if(test_lines_variables[i] == "tTest"){if(normality_lines_variables[i] == "normal"){result = t.test(as.numeric(lines[[i]]) ~ lines[["lines"]], var.equal = TRUE, na.action = na.omit)$p.value} else {result = t.test(as.numeric(lines[[i]]) ~ lines[["lines"]], var.equal = FALSE, na.action = na.omit)$p.value}
    anova_lines_variables[[i]][[1]] = "A"
    if(result < 0.05){if(mean(na.omit(as.numeric(lines[lines$lines==na.omit(lines_names)[1],i]))) > mean(na.omit(as.numeric(lines[lines$lines==na.omit(lines_names)[2],i])))){
      anova_lines_variables[[i]][[2]] = "B"} else {
        anova_lines_variables[[i]][[1]] = "B"
        anova_lines_variables[[i]][[2]] = "A"}} else 
        {anova_lines_variables[[i]][[2]] = "A"}}
  if(test_lines_variables[i] == "MannWithney"){result = wilcox.test(as.numeric(lines[[i]]) ~ lines[["lines"]], na.action = na.omit)$p.value
    anova_lines_variables[[i]][[1]] = "A"
    if(result < 0.05){if(mean(na.omit(as.numeric(lines[lines$lines==na.omit(lines_names)[1],i]))) > mean(na.omit(as.numeric(lines[lines$lines==na.omit(lines_names)[2],i])))){
      anova_lines_variables[[i]][[2]] = "B"} else {
        anova_lines_variables[[i]][[1]] = "B"
        anova_lines_variables[[i]][[2]] = "A"}}
    else {anova_lines_variables[[i]][[2]] = "A"}}
  if(test_lines_variables[i] == "Tukey"){lines_names_ordered = na.omit(arrange(lines %>%  group_by(lines) %>% summarise(mean = mean(na.omit(as.numeric(!!sym(variables[i]))))), desc(mean))$lines)
    levels(lines_names_ordered) = lines_names_ordered
    lines_ordered = lines
    lines_ordered$lines = factor(lines_ordered$lines, levels = levels(lines_names_ordered))
    lines_ordered = arrange(lines_ordered, lines_ordered$lines)
    anova_variables = aov(as.numeric(lines_ordered[[i]]) ~ lines, data = lines_ordered)
    result = glht(anova_variables, linfct = mcp(lines = "Tukey"))
    p_adjusted = p.adjust(summary(result)$test$pvalues, method = p_method)
    p_adjusted_df = pvalues_to_dataframe(p_adjusted, levels(lines_ordered$lines))
    letters_anova = multcompView::multcompLetters(p_adjusted_df)
    letters_anova_ordered = order_letters(na.omit(lines_names), rownames(letters_anova$LetterMatrix), letters_anova$Letters)
    for(j in c(1:length(letters_anova_ordered))){anova_lines_variables[[i]][[j]] = toupper(letters_anova_ordered[[j]])}}
  if(test_lines_variables[i] == "Fisher"){lines_names_ordered = na.omit(arrange(lines %>%  group_by(lines) %>% summarise(mean = mean(na.omit(as.numeric(!!sym(variables[i]))))), desc(mean))$lines)
    levels(lines_names_ordered) = lines_names_ordered
    lines_ordered = lines
    lines_ordered$lines = factor(lines_ordered$lines, levels = levels(lines_names_ordered))
    lines_ordered = arrange(lines_ordered, lines_ordered$lines)
    anova_variables = aov(as.numeric(lines_ordered[[i]]) ~ lines, data = lines_ordered)
    result = LSD.test(anova_variables, trt = "lines", group = T, p.adj = p_method)
    letters_anova = result$groups
    letters_anova_ordered = order_letters(na.omit(lines_names), rownames(letters_anova), letters_anova$groups)
    for(j in c(1:length(letters_anova_ordered))){anova_lines_variables[[i]][[j]] = toupper(letters_anova_ordered[j])}}
  if(test_lines_variables[i] == "DunnetT3"){lines_names_ordered = na.omit(arrange(lines %>%  group_by(lines) %>% summarise(mean = mean(na.omit(as.numeric(!!sym(variables[i]))))), desc(mean))$lines)
    levels(lines_names_ordered) = lines_names_ordered
    lines_ordered = lines
    lines_ordered$lines = factor(lines_ordered$lines, levels = levels(lines_names_ordered))
    lines_ordered = arrange(lines_ordered, lines_ordered$lines)
    anova_variables = aov(as.numeric(lines_ordered[[i]]) ~ lines, data = lines_ordered)
    result = dunnettT3Test(anova_variables)
    df = result$p.value
    df = rbind(NA, df)
    df = cbind(df, NA)
    rownames(df) = levels(lines_names_ordered)
    colnames(df) = levels(lines_names_ordered)
    p_adjusted = na.omit(p.adjust(df, method = p_method))
    p_adjusted_df = pvalues_to_dataframe(p_adjusted, levels(lines_ordered$lines))
    letters_anova = multcompView::multcompLetters(p_adjusted_df)
    letters_anova_ordered = order_letters(na.omit(lines_names), rownames(letters_anova$LetterMatrix), letters_anova$Letters)
    for(j in c(1:length(letters_anova_ordered))){anova_lines_variables[[i]][[j]] = toupper(letters_anova_ordered[[j]])}}
  if(test_lines_variables[i] == "GamesHowell"){lines_names_ordered = na.omit(arrange(lines %>%  group_by(lines) %>% summarise(mean = mean(na.omit(as.numeric(!!sym(variables[i]))))), desc(mean))$lines)
    levels(lines_names_ordered) = lines_names_ordered
    lines_ordered = lines
    lines_ordered$lines = factor(lines_ordered$lines, levels = levels(lines_names_ordered))
    lines_ordered = arrange(lines_ordered, lines_ordered$lines)
    anova_variables = aov(as.numeric(lines_ordered[[i]]) ~ lines, data = lines_ordered)
    result = gamesHowellTest(anova_variables)
    df = result$p.value
    df = rbind(NA, df)
    df = cbind(df, NA)
    rownames(df) = levels(lines_names_ordered)
    colnames(df) = levels(lines_names_ordered)
    p_adjusted = na.omit(p.adjust(df, method = p_method))
    p_adjusted_df = pvalues_to_dataframe(p_adjusted, levels(lines_ordered$lines))
    letters_anova = multcompView::multcompLetters(p_adjusted_df)
    letters_anova_ordered = order_letters(na.omit(lines_names), rownames(letters_anova$LetterMatrix), letters_anova$Letters)
    for(j in c(1:length(letters_anova_ordered))){anova_lines_variables[[i]][[j]] = toupper(letters_anova_ordered[[j]])}}
  if(test_lines_variables[i] == "KruskalWallisNemenyi"){lines_names_ordered = na.omit(arrange(lines %>%  group_by(lines) %>% summarise(mean = mean(na.omit(as.numeric(!!sym(variables[i]))))), desc(mean))$lines)
    levels(lines_names_ordered) = lines_names_ordered
    lines_ordered = lines
    lines_ordered$lines = factor(lines_ordered$lines, levels = levels(lines_names_ordered))
    lines_ordered = arrange(lines_ordered, lines_ordered$lines)
    result = as.data.frame(suppressWarnings(kwAllPairsNemenyiTest(as.numeric(lines_ordered[[i]]), lines_ordered[["lines"]])$p.value))
    result = rbind(NA, result)
    result = cbind(result, NA)
    rownames(result) = levels(lines_names_ordered)
    colnames(result) = levels(lines_names_ordered)
    p_adjusted = na.omit(p.adjust(as.numeric(as.matrix(result)), method = p_method))
    p_adjusted_df = pvalues_to_dataframe(p_adjusted, levels(lines_ordered$lines))
    letters_anova = multcompView::multcompLetters(p_adjusted_df)
    letters_anova_ordered = order_letters(na.omit(lines_names), rownames(letters_anova$LetterMatrix), letters_anova$Letters)
    for(j in c(1:length(letters_anova_ordered))){anova_lines_variables[[i]][[j]] = toupper(letters_anova_ordered[[j]])}}
  if(test_lines_variables[i] == "KruskalWallisDunn"){lines_names_ordered = na.omit(arrange(lines %>%  group_by(lines) %>% summarise(mean = mean(na.omit(as.numeric(!!sym(variables[i]))))), desc(mean))$lines)
    levels(lines_names_ordered) = lines_names_ordered
    lines_ordered = lines
    lines_ordered$lines = factor(lines_ordered$lines, levels = levels(lines_names_ordered))
    lines_ordered = arrange(lines_ordered, lines_ordered$lines)
    result = suppressWarnings(kwAllPairsDunnTest(as.numeric(lines_ordered[[i]]), lines_ordered[["lines"]])$p.value)
    result = rbind(NA, result)
    result = cbind(result, NA)
    rownames(result) = levels(lines_names_ordered)
    colnames(result) = levels(lines_names_ordered)
    p_adjusted = na.omit(p.adjust(as.numeric(as.matrix(result)), method = p_method))
    p_adjusted_df = pvalues_to_dataframe(p_adjusted, levels(lines_ordered$lines))
    letters_anova = multcompView::multcompLetters(p_adjusted_df)
    letters_anova_ordered = order_letters(na.omit(lines_names), rownames(letters_anova$LetterMatrix), letters_anova$Letters)
    for(j in c(1:length(letters_anova_ordered))){anova_lines_variables[[i]][[j]] = toupper(letters_anova_ordered[[j]])}}}
test_lines_variables_Fisher = rep("Fisher", length(test_lines_variables))
anova_lines_variables_Fisher = vector("list", 9)
for(i in 1:9){anova_lines_variables_Fisher[[i]] = vector("character", length(na.omit(lines_names)))}
for(i in c(1:length(na.omit(test_lines_variables)))){
  if(test_lines_variables_Fisher[i] == "Fisher"){lines_names_ordered = na.omit(arrange(lines %>%  group_by(lines) %>% summarise(mean = mean(na.omit(as.numeric(!!sym(variables[i]))))), desc(mean))$lines)
    levels(lines_names_ordered) = lines_names_ordered
    lines_ordered = lines
    lines_ordered$lines = factor(lines_ordered$lines, levels = levels(lines_names_ordered))
    lines_ordered = arrange(lines_ordered, lines_ordered$lines)
    anova_variables = aov(as.numeric(lines_ordered[[i]]) ~ lines, data = lines_ordered)
    result = LSD.test(anova_variables, trt = "lines", group = T, p.adj = p_method)
    letters_anova = result$groups
    letters_anova_ordered = order_letters(na.omit(lines_names), rownames(letters_anova), letters_anova$groups)
    for(j in c(1:length(letters_anova_ordered))){anova_lines_variables_Fisher[[i]][[j]] = toupper(letters_anova_ordered[j])}}}
print(variables)
print(test_lines_variables)
print(anova_lines_variables)
print(test_lines_variables_Fisher)
print(anova_lines_variables_Fisher)

line_names = na.omit(lines_names) 
create_table <- function(anova_list, test_vector, variables, line_names) {
  if (length(anova_list) != length(variables)) {
    stop("Number of elements in 'anova_list' is different to 'variables'")
  }
  df <- data.frame(matrix(nrow = length(line_names), ncol = length(variables)))
  colnames(df) <- variables
  for (i in seq_along(anova_list)) {
    if (length(anova_list[[i]]) != length(line_names)) {
      warning(paste("Variable", variables[i], "does not have the correct number of values (NA added)."))
      df[[i]] <- rep(NA, length(line_names))
      df[[i]][seq_len(min(length(anova_list[[i]]), length(line_names)))] <- anova_list[[i]]
    } else {
      df[[i]] <- anova_list[[i]]
    }
  }
  rownames(df) <- line_names
  df <- rbind(df, Test = test_vector)
  df <- cbind(" " = rownames(df), df)
  rownames(df) <- NULL
  return(df)
}
table_tests <- create_table(anova_lines_variables, test_lines_variables, variables, line_names)
table_fisher <- create_table(anova_lines_variables_Fisher, test_lines_variables_Fisher, variables, line_names)
wb <- createWorkbook()
addWorksheet(wb, "Tests")
writeData(wb, "Tests", table_tests)
addWorksheet(wb, "Fisher")
writeData(wb, "Fisher", table_fisher)
saveWorkbook(wb, file = "Results_ANOVA.xlsx", overwrite = TRUE)
