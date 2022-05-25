# ITGlueDRSite
Leveraging Powershell Universal to build a DR site for outages.

This is a dashboard page for Powershell Universal (https://ironmansoftware.com/powershell-universal). The purpose of this tool is to grant controlled access for all techs and engineers with the purpose of accessing an IT Glue zipped backup. 

This assumes that you already have a PowerShell Universal server running and configured with best practices. You will be able to copy the dashboard code into a new Dashboard within the User Interfaces tab creating the website.

![image](https://user-images.githubusercontent.com/16283759/170350887-07229173-7399-4b83-b661-005af6c335d1.png)

I have setup two API Endpoints linked to the ITGDRSite that enables the use of a POST command to both Enable the site and Disable the site.

![image](https://user-images.githubusercontent.com/16283759/170351072-9f89ae76-b3e9-4172-bfee-f35fe7887856.png)

This is an active project and plan to continue improving it until IT Glue devs build a better solution. One thing to note, this is only pulling passwords in. No other information is avaliable right now but I do plan on adding it in later. I'm also working on finding a way to get the 2FA codes to export during a backup, they current do not so any 2FA codes will not be avaliable at this time. That is a limitation within ITGlues backup feature.
