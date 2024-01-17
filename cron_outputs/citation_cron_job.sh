#!/bin/bash

# Path to wget
wget_path='/opt/homebrew/Cellar/wget/1.21.4/bin/'


### Papers to citation metrics from

# FHD/eppsilon
paper_url[0]=https://ui.adsabs.harvard.edu/abs/2019PASA...36...26B/metrics

# Limit paper
paper_url[1]=https://ui.adsabs.harvard.edu/abs/2019ApJ...884....1B/metrics

###

i=0
for url in "${paper_url[@]}"
do
    # Get html output of the citation metrics
    ${wget_path}wget $url -P /Users/nicholebarry/MWA/nicholebarry.github.io/cron_outputs/

    # Parse the output to grab lines regarding citation metric
    # Citation count shows up 5 lines after "Total citations"
    lines=$(grep -A 5 "Total citations" /Users/nicholebarry/MWA/nicholebarry.github.io/cron_outputs/metrics)  

    # Grab the last ten characters of this output
    # Should contain whitespace and the actual citation number
    citation[$i]=$(echo ${lines: -10} | xargs) 

    rm /Users/nicholebarry/MWA/nicholebarry.github.io/cron_outputs/metrics

    i=$((i + 1))
done


printf '%s\n' "${citation[@]}" > '/Users/nicholebarry/MWA/nicholebarry.github.io/cron_outputs/citations.txt'




