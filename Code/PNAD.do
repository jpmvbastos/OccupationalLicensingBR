
/* USE THIS SECTION TO READ .TXT MICRODATA FILES FROM IBGE

db datazoom_social

forvalues year=2012/2024{
datazoom_pnadcontinua, years(`year') /// 
 original(/Users/jpmvbastos/Library/CloudStorage/OneDrive-TexasTechUniversity/Personal/Projects/Data/PNAD/Microdados) ///
 saving(/Users/jpmvbastos/Library/CloudStorage/OneDrive-TexasTechUniversity/Personal/Projects/Data/PNAD) nid
}
*/

forvalues year=2018/2024{
use "/Users/jpmvbastos/Library/CloudStorage/OneDrive-TexasTechUniversity/Personal/Projects/Data/PNAD/PNADC_trimestral_`year'.dta", clear

gen employed = 0 
replace employed = 1 if V4001==1 




********* CODING OCCUPATIONS ********
/*

Notes:

- Code 2413 is "Financial Analist". You can perform that job as either an economist or administrator.
I've placed under economist, but ultimately it doesn't matter because both are licensed occupations. 

Domestic economist and social worker have the same code under COD (2635). 
I'm only coding a dummy for social workers to avoid any double-counting.


*/

* V4010: Occupation Code

tostring(V4010), gen(workcode)
replace workcode = substr(workcode,1,3) 


gen admin = 0 if V4001==1
replace admin = 1 if (workcode=="121" | V4010==2421 | V4010==2422 | V4010==2423) ///
	& V4010==1
label var admin "Administrador: Conselho Federal de Administração (CFA)"

gen admin_t = 0 if V4001==1
replace admin_t = 1 if V4001==1 & V4010==3343 

gen lawyer = 0 if V4001==1	
replace lawyer = 1 if V4001==1 & V4010 == 2611
label var admin "Advogado: Ordem dos Advogados do Brasil (OAB)"

gen aircrew = 0 if V4001==1	
replace aircrew = 1 if V4001==1 & (workcode=="315"| V4010==5111)
label var aircrew "Aeronauta: Agência Nacional de Aviação Civil (ANAC)"

gen advertiser = 0 if V4001==1	
replace advertiser = 1 if V4001==1 & V4010 == 2431

gen invest = 0 if V4001==1	
replace invest = 1 if V4001==1 & (V4010 == 2431 | V4010==3311)

gen agronomist = 0 if V4001==1
replace agronomist  = 1 if V4001==1 & (V4010 == 2132 | V4010==3142 | V4010==3143)

gen architect = 0 if V4001==1
replace architect = 1 if V4001==1 & (V4010 == 2161 | V4010 == 2162 | V4010 == 2164 | V4010 == 2165)

gen archivist = 0 if V4001==1
replace archivist = 1 if V4001==1 & V4010 == 2621

gen archivist_t = 0 if V4001==1
replace archivist_t = 1 if V4001==1 & V4010 == 3313

gen artist = 0 if V4001==1
replace artist = 1 if V4001==1 & workcode=="265"

gen socialwork = 0 if V4001==1
replace socialwork = 1 if V4001==1 & (V4010==2635 | V4010==3412)

gen athlete = 0 if V4001==1
replace athlete = 1 if V4001==1 & V4010 == 3421

gen actuary = 0 if V4001==1
replace actuary = 1 if V4001==1 & V4010 == 2120

gen librarian = 0 if V4001==1
replace librarian=1 if V4001==1 & V4010 == 2622

gen biologist = 0 if V4001==1
replace biologist=1 if V4001==1 & (V4010 == 2131 | V4010==3141)

gen biomedic = 0 if V4001==1
replace biomedic=1 if V4001==1 & (V4010==3212 | V4010==2263 | V4010==2269)

gen firefighter = 0 if V4001==1
replace firefighter = 1 if V4001==1 & V4010==5411

gen hair = 0 if V4001==1
replace hair = 1 if V4001 & V4010==5141

gen esthetician = 0 if V4001==1
replace esthetician = 1 if V4001==1 & V4010==5142 & ((Ano==2018 & Trimestre>=3) | Ano>2018)

gen retailer = 0 if V4001==1
replace retailer = 1 if V4001==1 & workcode=="522" & (Ano>=2013)

gen composer = 0 if V4001==1
replace composer = 1 if V4001==1 & V4010 == 2652

gen accountant = 0 if V4001==1
replace accountant = 1 if V4001==1 & V4010==2411
* See 4311	Trabalhadores de contabilidade e cálculo de custos for a potential comparison

gen realestate = 0 if V4001==1
replace realestate = 1 if V4001==1 & V4010==3334

gen insurance = 0 if V4001==1
replace insurance = 1 if V4001==1 & V4010==3321

gen customs_license_agent = 0 if V4001==1
replace customs_license_agent = 1 if V4001==1 & V4010==3331
label var customs_license_agent "Despachante Aduaneiro: Receita Federal"

gen economist = 0 if V4001==1
replace economist=0 if V4001==1 & (V4010==2631 | V4010 == 2413) 

gen physed = 0 if V4001==1
replace physed=1 if V4001==1 & (V4010==3422 | V4010==3423)

gen maid = 0 if V4001==1
replace maid = 1 if V4001==1 & V4010==5152

gen nurse = 0 if V4001==1 
replace nurse = 1 if V4001==1 & V4010==2221
* See also 3221: Profissionais de nível médio de enfermagem 

gen engineer = 0 if V4001==1
replace engineer = 1 if V4001==1 & (workcode=="214" | workcode=="215")

gen engineer_t = 0 if V4001==1
replace engineer_t = 0 if V4001==1 & (workcode=="311"| workcode=="312")

gen estatistician = 0 if V4001==1
replace estatistician = 1 if V4001==1 & V4010==2120

gen pharmacist = 0 if V4001==1
replace pharmacist = 1 if V4001==1 & V4010==2262

gen pharmacist_t = 0 if V4001==1
replace pharmacist_t = 1 if V4001==1 & V4010==3213

gen physicist = 0 if V4001==1
replace physicist = 1 if V4001==1 & V4010==2111 & ((Ano==2018 & Trimestre>=3) | Ano>2018)

gen pt = 0 if V4001==1
replace pt = 1 if V4001==1 & V4010==2264

gen pt_t = 0 if V4001==1
replace pt_t = 1 if V4001==1 & V4010==3255

gen phono = 0 if V4001==1
replace phono = 1 if V4001==1 & V4010==2266

gen miner = 0 if V4001==1 
replace miner = 1 if V4001==1 & (V4010==9311 | V4010==8111)

gen geographer = 0 if V4001==1 
replace geographer = 1 if V4001==1 & V4010==2165

gen geologist = 0 if V4001==1
replace geologist = 1 if V4001==1 & V4010==2114

gen carwasher = 0 if V4001==1
replace carwasher = 1 if V4001==1 & V4010==9122

gen historian = 0 if V4001==1
replace historian = 1 if V4001==1 & V4010==2633 & Ano>=2021 

gen traffic_instruc = 0 if V4001==1
replace traffic_instruc = 1 if V4001==1 & V4010==5165

gen journalist = 0 if V4001==1
replace journalist = 1 if V4001==1 & V4010==2642

gen auctioneer = 0 if V4001==1
replace auctioneer = 1 if V4001==1 & (V4010==3324 | V4010==3315)

gen social_mom = 0 if V4001==1
replace social_mom = 1 if V4001==1 & V4010==2635

gen vet = 0 if V4001==1
replace vet = 1 if V4001==1 & V4010==2250

gen vet_t = 0 if V4001==1
replace vet_t = 1 if V4001==1 & V4010==3240

gen doctor = 0 if V4001==1
replace doctor = 1 if V4001==1 & workcode=="221"

gen mototaxi = 0 if V4001==1
replace mototaxi = 1 if V4001==1 & V4010==8321

gen museologist = 0 if V4001==1
replace museologist = 1 if V4001==1 & V4010==2621

gen musician = 0 if V4001==1 
replace musician = 1 if V4001==1 & V4010==2652

gen dietician = 0 if V4001==1
replace dietician = 1 if V4001==1 & V4010==2265

gen oceanographer = 0 if V4001==1
replace oceanographer = 1 if V4001==1 & V4010==3251

gen dentist = 0 if V4001==1
replace dentist = 1 if V4001==1 & V4010==2261

gen eduadvisor = 0 if V4001==1
replace eduadvisor = 1 if V4001==1 & V4010==2359

gen fisherman = 0 if V4001==1
replace fisherman = 1 if V4001==1 & V4010==6225

gen psychologist = 0 if V4001==1
replace psychologist = 1 if V4001==1 & V4010==2634

gen prosthetics = 0 if V4001==1 
replace prosthetics = 1 if V4001==1 & V4010==3214

gen chemist = 0 if V4001==1
replace chemist = 1 if V4001==1 & V4010==2113

gen chemist_t = 0 if V4001==1
replace chemist_t = 1 if V4001==1 & (V4010==3132 | V4010==3133 | V4010==3134| V4010==3135)

gen radio = 0 if V4001==1
replace radio = 1 if V4001==1 & V4010==2656

gen pubrel = 0 if V4001==1
replace pubrel = 1 if V4001==1 & (V4010==2432 | V4010==1222)

gen commercialrep = 0 if V4001==1
replace commercialrep = 1 if V4001==1 & V4010==3322

gen sanitarian = 0 if V4001==1
replace sanitarian = 1 if V4001==1 & V4010==3253 & Ano>=2024

gen secretary = 0 if V4001==1 
replace secretary = 1 if V4001==1 & (V4010==4120 | workcode=="334")

gen sociologist = 0 if V4001==1
replace sociologist = 1 if V4001==1 & V4010==2632

gen taxi = 0 if V4001==1
replace taxi = 1 if V4001==1 & V4010==8322 

gen radiologist = 0 if V4001==1
replace radiologist = 1 if V4001==1 & V4010==3211

gen laborsafety = 0 if V4001==1
replace laborsafety = 1 if V4001==1 & V4010==3257

gen entertainment = 0 if V4001==1
replace entertainment = 1 if V4001==1 & V4010==3435

gen signlang = 0 if V4001==1
replace signlang = 1 if V4001==1 & V4010==2643

gen tourism = 0 if V4001==1
replace tourism = 1 if V4001==1 & V4010==5113 

gen zootecnician = 0 if V4001==1
replace zootecnician  = 1 if V4001==1 & (V4010==3240 | V4010==3141)

************	

gen licensed = 0 if V4001==1
replace licensed = 1 if V4001==1 & (admin==1 | lawyer==1 | aircrew==1 | advertiser==1 | ///
		invest==1 | agronomist==1 | architect==1 | archivist==1 | artist==1 | ///
		socialwork==1 | actuary==1 | librarian==1 | composer==1 | accountant==1 | ///
		customs_license_agent==1 | economist==1 | physed==1 | engineer==1 | nurse==1 | ///
		estatistician==1 | pharmacist==1 | pt==1 | phono==1 | geographer==1 | ///
		geologist==1 | carwasher==1 | historian==1 | traffic_instruc==1 | journalist==1 | ///
		auctioneer==1 | social_mom==1 | vet==1 | doctor==1 | mototaxi==1 | museologist==1 | ///
		musician==1 | dietician==1 | dentist==1 | fisherman==1 | psychologist==1 | ///
		chemist==1 | radio==1 | pubrel==1 | commercialrep==1 | secretary==1 | ///
		taxi==1 | zootecnician==1 | laborsafety==1  | sociologist==1 | physicist==1)

gen technician = 0 if V4001==1 
replace technician = 1 if V4001==1 & (admin_t==1 | archivist_t==1| chemist_t==1 | ///
		engineer_t==1 | pharmacist_t==1 | chemist_t==1 | vet_t==1  |  prosthetics==1 )

gen licensed_t = 0 if V4001==1
replace licensed_t = 1 if V4001==1 & (licensed==1 | technician==1)


gen exante = 0 if V4001==1
replace exante = 1 if V4001==1 & (firefighter==1 |		/// 
	oceanographer==1 | signlang==1 | sanitarian==1 | esthetician==1 |   /// 
	eduadvisor==1 )

gen minreq = 0 if V4001==1
replace minreq = 1 if licensed==1 | exante==1 | technician==1 | licensed_t==1
 

gen regulated = 0 if V4001==1
replace regulated = 1 if V4001==1 & (minreq==1 | retailer==1 | maid==1 | miner==1 )	
	
******************

rename V403412 rendimento_bruto


gen unlicensed = 1 if V4001==1 & minreq==0 & exante==0 & licensed_t==0

gen allworkers=1 if V4001==1


*collapse (mean) rendimento_bruto [pweight=V1028], by(categories)

	

/* Check about minimum requirements vs. ex ante licensing

Physicits 
Enologist 

*/

*svyset UPA [pweight=V1028], strata(Estrato) fpc(V1029) 

log using "/Users/jpmvbastos/Documents/GitHub/OccupationalLicensingBR/Data/Results/shares_`year'.smcl", replace



svyset [pweight= V1028], strata(Estrato) psu(UPA)

forvalues i=1/4 {
	display("% of Workforce in category, Quarter `i'")
	*svy: mean regulated minreq licensed_t if Trimestre==`i'
	table if Trimestre==`i' [pweight=V1028], stat(mean regulated minreq licensed_t)
	*foreach j in allworkers unlicensed minreq licensed_t {
	*	display("Mean wage, category `j', Quarter `i'")
		*svy: mean rendimento_bruto if Trimestre==`i' & `j'==1
	*	table if Trimestre==`i' & `j'==1 [pweight=V1028] , stat(mean rendimento) stat(median rendimento)
	
*}
}

log close

}



******* NEW OCCUPATIONS 

use "/Users/jpmvbastos/Library/CloudStorage/OneDrive-TexasTechUniversity/Personal/Projects/Data/PNAD/PNADC_trimestral_2012.dta", clear

gen new = 0 if V4001==1
replace new =1 if sanitarian==1 | historian==1 | physicist==1 | esthetician==1 ///
		| tourism==1 | retailer==1 | hair==1 
	
table [pweight=V1028] , stat(mean regulated) stat(mean new) stat(mean retail)


