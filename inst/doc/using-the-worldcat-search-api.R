## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
# let's load this package before getting started
library(libbib)

## ---- echo=FALSE--------------------------------------------------------------
# Sys.sleep(1)

## ---- eval=FALSE--------------------------------------------------------------
#  library(libbib)      # load this package
#  
#  result <- worldcat_api_search('$title="Madame Bovary" and
#                                   $author="Gustave Flaubert"')
#  
#  # get the column names
#  names(result)
#  #>  [1] "total_wc_results" "result_number"   "oclc"           "isbn"
#  #>  [5] "issn"             "title"           "author"         "pub_date"
#  #>  [9] "lang_code"        "bib_level"       "record_type"    "pub_place_code"
#  #> [13] "publisher"        "leader"          "oh08"           "query"
#  
#  # show the first three results
#  result[1:3,]
#  #>    total_wc_results result_number       oclc          isbn   issn
#  #>              <char>         <int>     <char>        <char> <char>
#  #> 1:              986             1 1125170419 9782253183464   <NA>
#  #> 2:              986             2 1049849403 9788415618843   <NA>
#  #> 3:              986             3 1203070641 9781664921993   <NA>
#  #>              title             author pub_date lang_code      bib_level
#  #>             <char>             <char>    <int>    <char>         <char>
#  #> 1: Madame Bovary : Flaubert, Gustave,     2019       fre Monograph/Item
#  #> 2: Madame Bovary / Flaubert, Gustave,     2019       spa Monograph/Item
#  #> 3: Madame Bovary / Flaubert, Gustave,     2021       eng Monograph/Item
#  #>                   record_type pub_place_code          publisher
#  #>                        <char>         <char>             <char>
#  #> 1:          Language Material             fr le Livre de poche,
#  #> 2:          Language Material             sp               <NA>
#  #> 3: Nonmusical sound recording            ohu               <NA>
#  #>                      leader                                     oh08
#  #>                      <char>                                   <char>
#  #> 1: 00000cam a2200000Mi 4500 190619s2019    fr a   g      000 1 fre d
#  #> 2: 00000cam a2200000Ii 4500 180827t20192018sp a          000 1 spa d
#  #> 3: 00000cim a2200000Mi 4500 201104s2021    ohunnnneq      f  n eng d
#  #>                                                    query
#  #>                                                   <char>
#  #> 1: srw.ti="Madame Bovary" and srw.au="Gustave Flauber...
#  #> 2: srw.ti="Madame Bovary" and srw.au="Gustave Flauber...
#  #> 3: srw.ti="Madame Bovary" and srw.au="Gustave Flauber...

## ---- echo=FALSE--------------------------------------------------------------
# Sys.sleep(1)

## ---- eval=FALSE--------------------------------------------------------------
#  # missing ending double quotes
#  worldcat_api_search('$title="Madame Bovary and $langauge=greek')
#  #> Received diagnostic message: Query syntax error (org.z3950.zing.cql.CQLParseException: expected index or term, got EOF)
#  #> no results found
#  #> NULL
#  
#  # "$titley" is not a valid search index
#  worldcat_api_search('$titley="Madame Bovary" and $langauge=greek')
#  #> Received diagnostic message: Unsupported index (srw.tiy)
#  #> no results found
#  #> NULL
#  
#  worldcat_api_search("$holding_library=NYP")
#  #> Received diagnostic message: Limit index, can only be used to narrow a result
#  #> for a non-limit index (srw.li)
#  #> no results found
#  #> NULL

## ---- eval=FALSE--------------------------------------------------------------
#  library(libbib)
#  
#  # title search for "The Brothers Karamazov"
#  results <- worldcat_api_search('$title="Brothers Karamazov"')
#  
#  # Madame Bovary by Gustave Flaubert in Greek
#  sru <- '$author="Gustave Flaubert" and
#            $title="Madame Bovary" and
#            $language=greek'
#  results <- worldcat_api_search(sru)
#  
#  # Hip Hop materials on wax, cassette, or CD published from
#  # 1987 to 1990
#  sru <- '(($material_type=cas or $material_type=cda or $material_type=lps)
#             and $subject="Rap") and $year="1987-1990"'
#  results <- worldcat_api_search(sru)
#  
#  # keyword search for "Common Lisp" for materials held
#  # at The New York Public Library
#  sru <- '$keyword="common lisp" and $holding_library=NYP'
#  results <- worldcat_api_search(sru)
#  
#  # keyword search for "Common Lisp" for materials held
#  # by any of the members of the "Manhattan Research
#  # Library Initiative" (MaRLI) joint borrowing program
#  # (New York Public Library, Columbia University, and
#  # New York University)
#  sru <- '($keyword="common lisp" and $holding_library=NYP)
#            or ($keyword="common lisp" and $holding_library=ZYU)
#            or ($keyword="common lisp" and $holding_library=ZCU)'
#  results <- worldcat_api_search(sru)
#  
#  # Books (only books) about Ethics (by dewey division 170s or
#  # LC call number subject class "BJ") published in the 19th
#  # century
#  sru <- '($dewey="17*" or $lc_call="bj*") and $year="18*" and
#             $material_type=bks'
#  results <- worldcat_api_search(sru)
#  
#  # Materials on Musicology (by Dewey division 780s) at
#  # the New York Public Library and not held by any
#  # other insitution
#  sru <- '$dewey="78*" and $holding_library=NYP and
#            $library_holdings_group=11'
#  results <- worldcat_api_search(sru)
#  
#  # Search for materials on "Danger Music" published since 2010
#  results <- worldcat_api_search('$keyword="danger music" and $year="2010-"')

## ---- echo=FALSE--------------------------------------------------------------
# Sys.sleep(1)

## ---- eval=FALSE--------------------------------------------------------------
#  sru <- '$title+=+"Common Lisp"'
#  results <- worldcat_api_search(sru)
#  results[1:3, .(total_wc_results, title)]
#  #>    total_wc_results                   title
#  #>              <char>                  <char>
#  #> 1:              367           Common Lisp /
#  #> 2:              367 Practical Common Lisp /
#  #> 3:              367           Common LISP /

## ---- echo=FALSE--------------------------------------------------------------
# Sys.sleep(1)

## ---- eval=FALSE--------------------------------------------------------------
#  sru <- '$title = "Common Lisp"'
#  results <- worldcat_api_search(sru)
#  results[1:3, .(total_wc_results, title)]
#  #>    total_wc_results                   title
#  #>              <char>                  <char>
#  #> 1:              367           Common Lisp /
#  #> 2:              367 Practical Common Lisp /
#  #> 3:              367           Common LISP /

## ---- echo=FALSE--------------------------------------------------------------
# Sys.sleep(1)

## ---- eval=FALSE--------------------------------------------------------------
#  results <- worldcat_api_search('$title exact "Common Lisp"')
#  results[1:3, .(total_wc_results, title)]
#  #>    total_wc_results         title
#  #>              <char>        <char>
#  #> 1:               37 Common Lisp /
#  #> 2:               37 Common LISP /
#  #> 3:               37 Common LISP /

## ---- echo=FALSE--------------------------------------------------------------
# Sys.sleep(1)

## ---- eval=FALSE--------------------------------------------------------------
#  results <- worldcat_api_search('$title any "Common Lisp"')
#  results[1:3, .(total_wc_results, title)]
#  #>    total_wc_results                                                 title
#  #>              <char>                                                <char>
#  #> 1:           351777 An Inquiry into the Human Mind on the Principles o...
#  #> 2:           351777                            The book of common prayer.
#  #> 3:           351777                        Dictionary of Phrase and Fable

## ---- echo=FALSE--------------------------------------------------------------
# Sys.sleep(1)

## ---- eval=FALSE--------------------------------------------------------------
#  results <- worldcat_api_search('$title = Common or $title = "Lisp"')
#  results[1:3, .(total_wc_results, title)]
#  #>    total_wc_results                                                 title
#  #>              <char>                                                <char>
#  #> 1:           351777 An Inquiry into the Human Mind on the Principles o...
#  #> 2:           351777                            The book of common prayer.
#  #> 3:           351777                        Dictionary of Phrase and Fable

## ---- echo=FALSE--------------------------------------------------------------
# Sys.sleep(1)

## ---- eval=FALSE--------------------------------------------------------------
#  results <- worldcat_api_search('$title exact "Finnegans Wake"')
#  results[1:3, .(total_wc_results, title, query)]
#  #>    total_wc_results            title                         query
#  #>              <char>           <char>                        <char>
#  #> 1:              761 Finnegans wake / srw.ti exact "Finnegans Wake"
#  #> 2:              761   Finnegans Wake srw.ti exact "Finnegans Wake"
#  #> 3:              761   Finnegans wake srw.ti exact "Finnegans Wake"
#  
#  # yields the same results as
#  
#  results <- worldcat_api_search('$title exact "Finnegan\'s Wake"')
#  results[1:3, .(total_wc_results, title, query)]
#  #>    total_wc_results            title                         query
#  #>              <char>           <char>                        <char>
#  #> 1:              761 Finnegans wake / srw.ti exact "Finnegan's Wake"
#  #> 2:              761   Finnegans Wake srw.ti exact "Finnegan's Wake"
#  #> 3:              761   Finnegans wake srw.ti exact "Finnegan's Wake"
#  

## ---- eval=FALSE--------------------------------------------------------------
#  results <- worldcat_api_search('srw.ti="Data Analysis with r"
#                                    and srw.au=fischetti',
#                                  max_records=Inf)
#  
#  # inspect some of the columns in the first 5 results
#  results[1:5, .(total_wc_results, result_number, oclc,
#                 title, author, pub_date)
#  #>    total_wc_results result_number       oclc                   title
#  #>              <char>         <int>     <char>                  <char>
#  #> 1:               11             1 1005106045 DATA ANALYSIS WITH R -.
#  #> 2:               11             2 1089176194  Data analysis with R :
#  #> 3:               11             3  949229431  Data analysis with R :
#  #> 4:               11             4 1242682069    Data Analysis with R
#  #> 5:               11             5 1242707288    Data Analysis with R
#  #>              author pub_date
#  #>              <char>    <int>
#  #> 1: FISCHETTI, TONY.     2018
#  #> 2: Fischetti, Tony.     2018
#  #> 3: Fischetti, Tony.     2015
#  #> 4:  Fischetti, Tony     2015
#  #> 5:  Fischetti, Tony     2015

## ---- eval=FALSE--------------------------------------------------------------
#  all_the_oclcs <- results[, unique(oclc)]
#  all_the_oclcs
#  #>  [1] "1005106045" "1089176194" "949229431"  "1242682069" "1242707288"
#  #>  [6] "1244405806" "1104264768" "1242685020" "1242707684" "1244406814"
#  #> [11] "1104846312"

## ---- eval=FALSE--------------------------------------------------------------
#  holds <- pblapply(all_the_oclcs,
#                    function(x){
#                      worldcat_api_locations_by_oclc(x,
#                        include.bib.info=FALSE)
#                      })

## ---- eval=FALSE--------------------------------------------------------------
#  all_holdings_dt <- rbindlist(holds)
#  all_holdings_dt[1:3]
#  #>          oclc institution_identifier            institution_name copies
#  #>        <char>                 <char>                      <char> <char>
#  #> 1: 1005106045                    FEM        The Ferguson Library      1
#  #> 2: 1005106045                    YDX        YBP Library Services      1
#  #> 3: 1005106045                    DUQ Duquesne University Library      1
#  
#  all_holdings_dt[, .(institution_name)]
#  #>                                            institution_name
#  #>                                                      <char>
#  #>    1:                                  The Ferguson Library
#  #>    2:                                  YBP Library Services
#  #>    3:                           Duquesne University Library
#  #>    4:                                    Centennial College
#  #>    5:                                  George Brown College
#  #>   ---
#  #> 1029:        Hochschule Mittweida (FH), Hochschulbibliothek
#  #> 1030:                                           Cyberlibris
#  #> 1031:                                           Cyberlibris
#  #> 1032:                                           Cyberlibris
#  #> 1033: Bibliothèque de l'Université du Québec à Trois-Riv...

