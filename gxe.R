Step 1: Create interaction terms 

# Read in data
genotype_data <- read.table("genotype_data.txt", header=TRUE)
environmental_data <- read.table("environmental_data.txt", header=TRUE)

# Create interaction terms
interaction_terms <- genotype_data * environmental_data$environmental_variable

# Combine with original data
combined_data <- cbind(genotype_data, environmental_data, interaction_terms)
write.table(combined_data, "combined_data_with_interactions.txt", quote=FALSE, row.names=FALSE)

Step 2: Extract Residuals
Extract residuals from the BOLT-LMM output. These residuals represent the phenotype adjusted for genetic background and covariates.

Step 3: Run Interaction analysis 
# Example in R
lm_results <- lm(residuals ~ SNP + environmental_variable + SNP:environmental_variable, data=combined_data)
summary(lm_results)
