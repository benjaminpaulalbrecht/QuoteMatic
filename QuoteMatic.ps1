# QuoteMatic.ps1 
# Experiment in Powershell Module Design 



. (Resolve-Path -Path 'ScrapLogger.ps1' -Verbose ) 

$quoteUrl = "http://subfusion.net/cgi-bin/quote.pl?quote=cookie&number=1" 

function Get-Quote {
    param (
        [string]$quoteUrl
    )
    
    try {
        
        $quote = (Invoke-WebRequest -Method GET $quoteUrl) 
    }
    catch {
        Scrap -message "$_.Error" -loglevel "Error"
        Exit
    }
    
    $extractedQuote = ($quote.ParsedHtml.getElementsByTagName("body") | Select-Object -Property outerText).outerText 
    Scrap -message $extractedQuote -loglevel "Info"
    
}
