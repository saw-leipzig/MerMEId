xquery version "1.0" encoding "UTF-8";
module namespace list="http://kb.dk/this/getlist-sources";

declare namespace fn="http://www.w3.org/2005/xpath-functions";
declare namespace m="http://www.music-encoding.org/ns/mei";
declare namespace ft="http://exist-db.org/xquery/lucene";

declare function list:getlist (
	$coll  as xs:string,
	$query as xs:string) as node()* 
{

	let $list  := 
	if($coll) then 
	if($query) then
	for $doc in collection("/db/dcm")/m:mei[m:meiHead/m:fileDesc/m:seriesStmt/m:identifier/string()=$coll and fn:string-length(m:meiHead/m:fileDesc/m:sourceDesc/m:source/m:titleStmt/m:title[1]/string())>0 and ft:query(.,$query)] 

	order by $doc//m:workDesc/m:work[@analog="frbr:work"]/m:titleStmt/m:respStmt/m:persName[1]/string(),$doc//m:workDesc/m:work[@analog="frbr:work"]/m:titleStmt/m:title[1]/string()
	return $doc 
	else
	for $doc in collection("/db/dcm")/m:mei[m:meiHead/m:fileDesc/m:seriesStmt/m:identifier/string()=$coll and fn:string-length(m:meiHead/m:fileDesc/m:sourceDesc/m:source/m:titleStmt/m:title[1]/string())>0 ] 
	order by $doc//m:workDesc/m:work[@analog="frbr:work"]/m:titleStmt/m:respStmt/m:persName[1]/string(),$doc//m:workDesc/m:work[@analog="frbr:work"]/m:titleStmt/m:title[1]/string()

	return $doc 
        else
	if($query) then
        for $doc in collection("/db/dcm")/m:mei[ft:query(.,$query) and fn:string-length(m:meiHead/m:fileDesc/m:sourceDesc/m:source/m:titleStmt/m:title[1]/string())>0 ]
	order by $doc//m:workDesc/m:work[@analog="frbr:work"]/m:titleStmt/m:respStmt/m:persName[1]/string(),$doc//m:workDesc/m:work[@analog="frbr:work"]/m:titleStmt/m:title[1]/string()
	return $doc
        else
        for $doc in collection("/db/dcm")/m:mei[fn:string-length(m:meiHead/m:fileDesc/m:sourceDesc/m:source/m:titleStmt/m:title[1]/string())>0]
	order by $doc//m:workDesc/m:work[@analog="frbr:work"]/m:titleStmt/m:respStmt/m:persName[1]/string(),$doc//m:workDesc/m:work[@analog="frbr:work"]/m:titleStmt/m:title[1]/string()
	return $doc
	
	return $list

};

