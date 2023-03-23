# Dependencies:

* Mysql
* Git
* Terraform
* AzureCLI
* Kubectl

## Nedlastnings guide

Dependencies kan lastes ned ved å kjøre download.ps1 skriptet man finner under Dependencies mappen. Her er det verdt å nevne at innstallasjonen benytter seg av choco og er dermed laget for Windows brukere. Linux brukere må dermed få lastet ned pakkene på eget vis. 

# Fullstendig guide til oppsett av miljøene
Nedenfor har vi satt opp guide med oversikt over hva som må gjøres for å replikere miljøet vårt. Dermed er det viktig at man følger denne guiden ordentlig hvis målet er å fullstendig replikere oppsettet brukt i denne oppgaven. Guiden benytter seg blant annet av Fortanix sin ["Quickstart Guide"](https://support.fortanix.com/hc/en-us/articles/360043484152-Quickstart-Guide). 

* Følg introduksjonvideon som befinner seg øverst i Fortanix sin introduksjons guide. 
* Følg steg 1 i fortanix guiden
* Følg steg 2 i fortanix guiden. Husk å huke av for "This is a test-only deployment". Her er det verdt å merke at brukeren som opprettes må manuelt godkjennes av Fortanix. Dermed så er dette et steg som kan ta en del tid på Fortanix sin side. Men hvis det skulle haste så går det an å fremskyve prosessen ved å kontakte Fortanix direkte.
* Gjør "Container Registry innstillinger"
* Gjør "Bygging av docker image"
* Gjør "Pushing av docker image til Azure Container Registry (CR)"
* Følg steg 3 i fortanix guiden. 

# Container Registry innstillinger

For at fortanix sin "Confidential Computing Manager" (CCM) skal kunne hente og publsisere docker images så er den nødt til å autentiseres. Dette kan oppnås ved hjelp av brukernavn og passord, noe som krever at en endrer på noen innstillinger hos "Container Registry" (CR). Etter opprettelse av resurssen så er en nødt til å gå inn på "Access keys" som befinner seg under "Settings". Videre så må "Admin user" være satt til "Enabled". Når dette er gjort så vil en få tilgang på noen passord som senere skal brukes til å autentisere CCM. Til slutt så burde CR se tilnærmet lik ut som på bilde under.

![alt text](https://github.com/caspett/bachelor_project/blob/main/images/kubdocker.png?raw=true)
# Bygging av docker image

I dette oppsettet så bygger vi et image som vi kaller phpsite og tagger den med v1 for å holde kontroll på versjonen av imaget
```
cd ./docker
docker build -t phpsite:v1 .
```
## Pushing av docker image til Azure Container Registry (CR)
Her autentiserer vi oss for så å dytte dette imaget opp til CR
```
az login
az acr login --name KubDocker
docker tag phpsite:v1 kubdocker.azurecr.io/phpsite:v1
docker push kubdocker.azurecr.io/phpsite:v1
```
# Utrullingsguide av miljø:

## Confidential setup

```
cd confidential/infrastructure
terraform init -backend-config="Conf.tfbackend"
terraform plan -out main.tfplan
terraform apply "main.tfplan"
```

```
cd confidential/deployment
```
Kjør kommandoene i setup.ps1
## Non-Confidential setup
```
cd non-confidential/infrastructure
terraform init -backend-config="nonConf.tfbackend"
terraform plan -out main.tfplan
terraform apply "main.tfplan"
```
**Resurssene bruker litt tid på dukke opp i azure sitt API. Dermed så er det normalt å måtte vente i ett par minutter før deployment delen av prosessen fungerer**
```
cd non-confidential/deployment
terraform init -backend-config="nonConf.tfbackend"
terraform plan -out main.tfplan
terraform apply "main.tfplan"
```

## Opprydning av infrastruktur:

**For å rydde opp i miljøet så kjører man bare følgende kommando ved alle stier hvor man initierte terraform. Dette er da med unntak av deployment delen av det konfidensielle miljøet. Opprydning av den konfidensielle applikasjonen finner man i bunnen av setup.ps1 filen**
```
terraform destroy -auto-approve
```
