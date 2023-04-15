# Fast Google Dorks Scan Axiom Edition

This work is based on an idea for bypassing Google's spam protection

# Usage example:

## Create your axiom instances
`axiom-fleet "kole-" -i 5`

## Send the FGDS.sh to instances and give execution permission
`axiom-exec "wget YOUR-SERVER/FGDS.sh && chmod +x FGDS.sh"`

## Add the fgds.json to your modules
`mv fgds.json .axiom/modules`

## We are ready to start, choose predefined dorks, or use yours on target
`axiom-scan payloads.txt -m fgds --target hackerone.com -o fgds_results.txt`

