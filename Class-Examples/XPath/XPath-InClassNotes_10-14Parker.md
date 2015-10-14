Download this file: [**1888-08-04.xml**](https://raw.githubusercontent.com/RJP43/CitySlaveGirls-ChicagoDailyTimes1888/master/OriginalArticles_XML/1888-08-04.xml)  

**HOW WOULD YOU FIND ALL OF THE WAGES  DESCRIBED IN THIS ARTICLE:**  

`//num[@type='wage']`  

**CREATE A LIST OF THESE WAGES SEPARATED BY A SEMICOLON**  

`string-join((//num[@type='wage']), "; ")` 

**USING THE `contains()` FUNCTION:**    

`//num` - 16 Results returning all of the `<num>` elements  
`//num[contains(., "cent") or contains(., "cents") or contains(., "$")]` - 15 Results returning all of the `<num>` elements containing the text "cent", "cents", or "$"   
`//num[@type="wage"][contains(., "cent") or contains(., "cents") or contains(., "$")]` - 11 Results returning all of  `<num>` elements with the `type="wage"` attribute    


**CREATE A LIST OF ALL THE CONNOTATIONS USED BY THE `<femVoice>` ELEMENT SEPARATED BY A SEMICOLON:**  

`string-join((distinct-values(//femVoice/@connotation)), "; ")`    

**CREATE A LIST OF ALL THE VALUES OF THE `@who` ATTRIBUTES ON THE `<mascVoice>` ELEMENTS SEPARATED BY ASTERISK:**    

`string-join((distinct-values(//mascVoice/@who)), "* ")`  

**WHAT IS THE DIFFERENCE:**   

`string-join((distinct-values(//mascVoice[@who="employer"][@connotation])), "*****")`    
  
`string-join((distinct-values(//mascVoice[@who="employer"]/@connotation)), "*****")`   
  
**WHAT IF WE ARE INTERESTED IN FINDING OUT HOW MANY TIMES NELSON SPEAKS IN THIS ARTICLE A.K.A. `<nellVoice>` ELEMENTS AND WE WANT TO KNOW THE DIFFERENT LENGTHS OF HER SPEECHES:**  

`//nellVoice[@connotation="sarcasmWit"]/string-length()`

WE GET 8 RESULTS  EACH WITH A NUMBER (of text characters) VARYING FROM AS LOW AS 42 TO AS HIGH AS 266 

**HOW CAN WE FIND HER LONGEST SPEECH? HOW CAN WE FIND HER SHORTEST SPEECH**

*LONGEST*  

3 STEPS:    
  1.  `max(//nellVoice[@connotation="sarcasmWit"]/string-length())`  This gives the value of the speech's length `(266)` but how do we get the actual speech?  
  2. `//nellVoice[@connotation="sarcasmWit"][string-length() = max(//nellVoice[@connotation="sarcasmWit"]/string-length())]`  
  3. `//nellVoice[@connotation="sarcasmWit"][string-length() = max(//nellVoice[@connotation="sarcasmWit"]/string-length())]/string-length()`   This tests to make sure you are getting the longest one and getting the same result as step 1 `(266)`  
  
*SHORTEST*  

AGAIN 3 STEPS:   
  1.  `min(//nellVoice[@connotation="sarcasmWit"]/string-length())`  This gives the value of the speech's length `(42)` but how do we get the actual speech?  
  2. `//nellVoice[@connotation="sarcasmWit"][string-length() = min(//nellVoice[@connotation="sarcasmWit"]/string-length())]`  
  3. `//nellVoice[@connotation="sarcasmWit"][string-length() = min(//nellVoice[@connotation="sarcasmWit"]/string-length())]/string-length()`   This tests to make sure you are getting the longest one and getting the same result as step 1 `(242)`  







