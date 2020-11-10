# QuoteMatic.ps1 
# Experiment in Powershell Module Design 
# todo: create an article about it 
#todo: add args for new url, etc


. (Resolve-Path -Path 'C:\Users\balbrecht\OneDrive - Energy Transfer\Q0FN\ScrapLogger.ps1' -Verbose ) 

#$quoteUrl = "http://subfusion.net/cgi-bin/quote.pl?quote=cookie&number=1" 

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
