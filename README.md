# Fast Google Dorks Scan Axiom Edition

This work is based on [an idea](https://github.com/IvanGlinkin/Fast-Google-Dorks-Scan/issues/9) for bypassing Google's robot protection

# Usage example:

## Create your axiom instances
`axiom-fleet "kole-" -i 5`

## Send the FGDS.sh to instances and give execution permission
`axiom-exec "wget https://raw.githubusercontent.com/cyb3rsalih/Fast-Google-Dorks-Scan/salih/FGDS.sh && chmod +x FGDS.sh"`

## Add the fgds.json to your modules
`mv fgds.json .axiom/modules`

## We are ready to start, choose predefined dorks, or use yours on target
`axiom-scan payloads.txt -m fgds --target hackerone.com -o fgds_results.txt`

