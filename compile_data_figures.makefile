print-%: ; @echo $*=$($*)
rdata = Data
pdata = Processed_data
fig = Figures

GENERATED_FILES =\
	$(pdata)/combined_final_data_frame.csv $(fig)/correlation_plot.pdf \
	$(pdata)/summary_before_normalization.csv \
	$(pdata)/tentative_vaccine_risk_data.csv \
	$(pdata)/Imputed_data.csv \
	$(pdata)/imputed_vaccine_index_using_factor_analysis_weight.csv \
	$(fig)/Factor_analysis_components.pdf \
	$(fig)/vaccine_risk_index_with_FACTOR_ANALYSIS_imputed_heatmap.pdf \
	$(fig)/Factor_scores_by_WHO_region_classification.pdf


.PHONY: all clean


all: $(GENERATED_FILES)

clean:
	rm -rf $(pdata)/* $(fig)/*



$(pdata)/combined_final_data_frame.csv $(fig)/correlation_plot.pdf: $(rdata)/Measles_MCV1_coverage/coverage_series_copy.csv \
$(rdata)/Measles_MCV1_coverage/data-verbose.csv \
$(rdata)/GAIN_resources/gain/gain.csv \
$(rdata)/Urban_population/*.xls \
$(rdata)/Total_population/API_SP.POP.TOTL_DS2_en_csv_v2_422125/API_SP.POP.TOTL_DS2_en_csv_v2_422125.csv \
$(rdata)/Measles_incidence/IHME-GBD_2017_DATA-88f3e762-1/IHME-GBD_2017_DATA-88f3e762-1.csv \
$(rdata)/Human_development_index/Human\ Development\ Index\ (HDI).csv \
$(rdata)/Refugee_origin/Refugee_Origin_API_SM.POP.REFG.OR_DS2_en_csv_v2_438456/API_SM.POP.REFG.OR_DS2_en_csv_v2_438456.csv \
$(rdata)/Internal_displacement_due_to_conflict/Internal_displacement_conflict_API_VC.IDP.NWCV_DS2_en_csv_v2_465624/API_VC.IDP.NWCV_DS2_en_csv_v2_465624.csv \
$(rdata)/Internal_displacement_due_to_disaster/Internal_displacement_Disaster_API_VC.IDP.NWDS_DS2_en_csv_v2_465625/API_VC.IDP.NWDS_DS2_en_csv_v2_465625.csv \
$(rdata)/Climate_risk/Global\ Climate\ Risk\ Index\ 2019_2_pages.xlsx \
$(rdata)/Vaccine_sentiment/Data\ on\ Vaccine\ sentiment_2018.xlsx \
$(rdata)/Peace_index/PeaceIndex_2017.csv
	Rscript -e "rmarkdown::render('scripts/Process_raw_data.Rmd')"

$(pdata)/summary_before_normalization.csv : $(pdata)/combined_final_data_frame.csv
	Rscript -e "rmarkdown::render('scripts/generate_summary.Rmd')"

$(pdata)/tentative_vaccine_risk_data.csv: $(pdata)/combined_final_data_frame.csv
	Rscript -e "rmarkdown::render('scripts/prepare_data_for_imputation.Rmd')"

$(pdata)/Imputed_data.csv : $(pdata)/tentative_vaccine_risk_data.csv
	Rscript -e "rmarkdown::render('scripts/impute_data.Rmd')"

$(pdata)/imputed_vaccine_index_using_factor_analysis_weight.csv $(fig)/Factor_analysis_components.pdf: $(pdata)/Imputed_data.csv
	Rscript -e "rmarkdown::render('scripts/factor_analysis.Rmd')"

$(fig)/vaccine_risk_index_with_FACTOR_ANALYSIS_imputed_heatmap.pdf $(fig)/Factor_scores_by_WHO_region_classification.pdf: \
$(rdata)/ne_50m_admin_0_countries/ne_50m_admin_0_countries.shp \
$(pdata)/Imputed_data.csv \
$(rdata)/Measles_MCV1_coverage/coverage_series_copy.csv
	Rscript -e "rmarkdown::render('scripts/generate_heat_maps.Rmd')"
	Rscript -e  "rmarkdown::render('scripts/summarize_by_country_categories.Rmd')"	

