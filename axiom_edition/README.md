# Fast Google Dorks Scan Axiom Edition

This work is based on [an idea](https://github.com/IvanGlinkin/Fast-Google-Dorks-Scan/issues/9) for bypassing Google's robot protection

# Usage example:

## Create your axiom instances
`axiom-fleet "kole-" -i 5`

## Send the FGDS.sh to instances and give execution permission to all instances you spin up
`axiom-exec "wget https://raw.githubusercontent.com/cyb3rsalih/Fast-Google-Dorks-Scan/salih/axiom_edition/fgds_axiom.sh && chmod +x fgds_axiom.sh"`

## Add the fgds.json to your modules on your master machine
`mv fgds.json .axiom/modules`

## We are ready to start, choose predefined dorks from payloads/ or use yours on target
`axiom-scan payloads.txt -m fgds --target hackerone.com -o fgds_results.txt` 

You may add  `--rm-when-done` also for destroy instances 
so, for next scan fresh machines with fresh IPs will be ready for scan


# Automate the automation
```
for i in $(cat targets)
do
    axiom-fleet "kole-" -i 5 &&
    axiom-exec "wget https://raw.githubusercontent.com/cyb3rsalih/Fast-Google-Dorks-Scan/salih/axiom_edition/fgds_axiom.sh && chmod +x fgds_axiom.sh" && 
    axiom-scan payloads.txt -m fgds --target $i -o $i_fgds_results.txt --rm-when-done && 
    echo $i finished!!!
done
```
