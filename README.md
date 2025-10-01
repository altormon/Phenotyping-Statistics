# Statistics-template

Template for performing statistical analysis of phenotyping values ​​or other experiments.


Requirements (first use only)

The use of Anaconda is recommended (a R distribution with all necessary tools included).

Download and install Anaconda from: https://www.anaconda.com/download.
During installation, choose: R version: 4.2.0. Default installation settings.
After installation, open the Anaconda Prompt (Windows) or a terminal (Linux).


Installation (first use only)

Download this repository from GitHub: Click on Code → Download ZIP. Extract the folder to a location of your choice (e.g. Documents/Phenotyping-Statistics).
Create a new environment in Anaconda (open "Anaconda Prompt", right click, "Run as administrator") and install the required libraries:

cd %USERPROFILE%\Documents\Phenotyping-Statistics

conda create -n statistics -c conda-forge r-base r-essentials

conda activate statistics


Usage

Inside the ASAP folder, place all the images you want to analyze inside the Input folder.
Run (in "Anaconda Prompt") the inference script (F6) using the pre-trained model (stomata_model.pt is already included):

cd %USERPROFILE%\Documents\Phenotyping-Statistics

conda activate statistics

Rscript Phenotyping_Analysis.R


Notes

Three files are available: two Excel files and an R script. For the Excel files, data only should be entered in the cells underlined in yellow; the rest of the cells should not be modified. Each file contains the following information:

- Phenotyping_Template.xlsx (NOT NECESSARY FOR STATISTICAL ANALYSIS): in the "Conditions" sheet, enter the names of the control samples (between 1 and 4 samples: WT1, WT2, WT3, and WT4) and the target samples (between 1 and 12 samples: L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, and L12) in cells C13-C28. In cell H5, enter the name of the treatment (maximum 1) to be compared (e.g., elevated CO2), or leave blank if there are no two conditions to compare. In cells H8-H10, enter the names (maximum 3) of the variables to be analyzed (e.g., aerial part weight, root length, and root weight). In cells B3 (with treatment) and C3 (without treatment), enter the number of days the plants were grown to calculate the values ​​for each variable per day (enter 1 if raw values ​​are desired). In cells B36 and C36, enter the percentage (value between 0 and 100) of values ​​to filter, both the lowest (B36) and highest (C36) values. For each leaf in the samples (between WT1 and L12), enter the values ​​per plate, with a maximum of 11 values ​​per plate for shoot weight and root length, and a maximum of 1 value for root weight (or the variable names entered in place of those 3 variables). The results are displayed in the "PartsPerUnit" sheets (values ​​in parts per unit for all samples), "WTAverage" (average values ​​for all controls: WT1, WT2, WT3, and WT4), "GraphicsPlates" (mean, standard deviation, standard error, and t-test values ​​for each sample per plate, both filtered and unfiltered), and "GraphicsAllMeasurements" (mean, standard deviation, standard error, and t-test values ​​for each sample, as total values, not per plate, both filtered and unfiltered). This Excel file is NOT used to perform statistical tests for ANOVA, but it can be used to obtain filtered phenotyping (or other similar experiments) values ​​(cells AC3-AF157 from each sheet with samples: WT1-L12) and, if desired, in parts per unit ("PartsPerUnit" sheet).

- Phenotyping_Analysis. xlsx: in the "Conditions" sheet, enter the names of the control samples (between 1 and 4 samples: WT1, WT2, WT3 and WT4) and the target samples (between 1 and 12 samples: L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11 and L12) in cells C13-C28. In cell H5, enter the name of the treatment (maximum 1) with which the comparison will be made (for example, high CO2), or leave blank if there are no two conditions to compare. In cells H10-H12, enter the names (maximum 3) of the variables to be analyzed (for example, aerial part weight, root length, and root weight). In cell H26, enter the percentage of variability accepted to determine whether two samples have the same sample size (for example, if there are 15 WT1 values ​​for a variable and 10 L1 values ​​for that variable, they do not have the same sample size if the value in cell H26 is 0, but they do if it is 100). It is recommended not to modify cell H26. In cell H29, select the p-value adjustment method, with "none" being the less restrictive and "Bonferroni" being the most restrictive. In the "TemplateLines" sheet, enter the values ​​for each sample, variable, and treatment in the cells underlined in yellow. In the "GraphicsLines" sheet, enter the mean, standard deviation, standard error, and t-test values ​​for each sample, both total values ​​and ratios, as well as the bar chart with these values. This Excel file is used for ANOVA analyses and MUST be in the same folder as "Phenotyping_Analysis.R".

- Phenotyping_Analysis.R: script to perform the statistical analysis. All the code must be executed. As a result, three folders are generated: "Boxplots" folder, with boxplots with the values ​​of each sample for each variable, both considering the treatment and without considering it; and "Homoscedasticity" and "Normality" folders, with the graphical representations of homoscedasticity and normality, respectively. Finally, the Excel file "Results_ANOVA.xlsx" is generated with the results (letters) of the ANOVA analyses: in the "Tests" sheet, the analyses for the appropriate tests are shown based on the normality and homoscedasticity values, and in the "Fisher" sheet, the analyses performed with the Fisher test (less restrictive), assuming that there is normality and homoscedasticity in the samples (if the number of values ​​for each sample, n, is very high, based on the Central Limit Theorem). To apply the Central Limit Theorem, the minimum number of samples (e.g., n > 50) is up to the user.
