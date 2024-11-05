#issues Fertilizer amount is out of range, plot size was not provided
carob_script <- function(path) {

"TAMASA Ethiopia. Yield, soil and agronomy data from farmers’ maize fields collected by CSA, 2015 season. This files ontains yiedl and soils data coillected by CSA (Central Statistical Agency) from four zones in Oromia (East Showa, Wollega, West and South West Showa and Jimma) and one Zone in Amhara (West Gojjam). A total of 38 primary sampling units were covered and making a total of 383 sampling points. Unreplicated crop cuts were made on farmers maize fields and yield measured. Soil samples were also collected at 0-20 and 20-50cm but are not all analysed yet."



	uri <- "hdl:11529/11014"
	group <- "agronomy"
 
	ff  <- carobiner::get_data(uri, path, group)

 
	meta <- data.frame(
		carobiner::read_metadata(uri, path, group, major=2, minor=1),
		data_institute = "CIMMYT",
		publication = NA,
		project = "TAMASA",
		data_type = "experiment",
		treatment_vars = "fertilizer_used;OM_used",
		response_vars = "yield", 
		carob_contributor = "Your Name",
		carob_date = "2024-11-05",
		notes = NA,
		design = NA
	)
	


	f <- ff[basename(ff) == "TAMASA_ET_CC_2015_CSAF.xlsx"]

	r <- carobiner::read.excel(f,sheet = "Revised_data")


	d <- data.frame(
		variety= r$`Name of variety`,
		yield=r$`Moisture adjusted grain  yield (kg /ha)`,
		soil_pH=r$pH,
		soil_C=r$`Carbon (%)`,
		soil_Al=r$`Al (mg/kg)`,
		soil_Ca=r$`Ca  (mg/kg)`,
		soil_S=r$`S  (mg/kg)`,
		soil_Mn=r$`Mn  (mg/kg)`,
		soil_Zn=r$`Zn  (mg/kg)`,
		soil_Mg=r$`Mg  (mg/kg)`,
		soil_Na=r$`Na  (mg/kg)`,
		soil_K=r$`K  (mg/kg)`,
		soil_B=r$`Boron  (mg/kg)`,
		soil_N=r$`Nitrogen (%)`,
		soil_P_total=r$`P  (mg/kg)`,
		fertilizer_amount= as.numeric(r$`amount of Inorganic fertilizer`),
		OM_amount=r$`amount of organic fertilizer`,
		variety_type=r$`Type of variety`,
		fertilizer_used=r$`Fertilizer type/inorganic`,
		OM_used=r$`Fertilizer type/organic`)

	d$trial_id <- "1"
	d$on_farm <- TRUE
	d$is_survey <- FALSE
	d$irrigated <-FALSE
	
	d$longitude <- 40.498867
	d$latitude <- 9.149175
	d$geo_from_source <- FALSE

	d$planting_date <- "2015"
	d$harvest_date  <- "2015"

  d$crop <- "maize"
	d$yield_part <- "grain"
	d$country <- "Ethiopia"
	
	d$N_fertilizer <- d$P_fertilizer  <- d$K_fertilizer <- as.numeric(NA)
	

	carobiner::write_files(path, meta, d)
}

## now test your function in a _clean_ R environment (no packages loaded, no other objects available)
# path <- _____
# carob_script(path)

