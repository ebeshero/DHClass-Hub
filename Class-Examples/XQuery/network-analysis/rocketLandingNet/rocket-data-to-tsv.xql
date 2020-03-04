xquery version "3.1";
declare variable $ThisFileContent := string-join(
let $rocketColl := collection('/db/rocket/')
let $launchDateTimes := $rocketColl//launch/@sDateTime/string()
let $launchYears := $launchDateTimes ! tokenize(., '-')[1]
let $distinctYears := $launchYears => distinct-values()
for $y in $distinctYears
let $launchBases := $rocketColl//launch[@sDateTime ! substring-before(., '-') = $y]/preceding-sibling::launchPad/@sBase/string()
let $distinctLaunchBases := $launchBases => distinct-values()
for $lch in $distinctLaunchBases
let $landPads := $rocketColl//launch[@sDateTime ! substring-before(., '-') = $y][preceding-sibling::launchPad/@sBase = $lch]/following-sibling::landPad/@eBase/string()
let $distinctLandings := $landPads => distinct-values()
for $lnd in $distinctLandings
order by $y
return string-join(($y(:source node:), "year"(:source node attribute:), $lch(:edge connector shared context:), $lnd(:target node:), "landing pad"(:target node attribute:)), "&#x9;"), "&#10;");

let $filename := "rocketLandingNetwork.tsv"
let $doc-db-uri := xmldb:store("/db/2020_ClassExamples", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/2020_ClassExamples/rocketLandingNetwork.tsv :) 
 