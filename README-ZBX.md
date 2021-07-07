## Prerequisites
- Have a [Google Account](https://accounts.google.com)
- [Get your Viber Account authentication token](https://partners.viber.com/account/create-bot-account) 

### 1. Download [SurveyChatBot](SurveyChatBot.xlsx), [keyboardGenerator](keyboardGenerator.gs) and [script](script.gs).

### 2. Upload or import spreadsheet (SurveyChatBot.xlsx) to [Google Docs](https://sheet.new).

### 3. Under the **`parameters`** sheet, edit the following field:

- Access Token - Use the [Access Token](https://developers.viber.com/docs/faq/#authentication-tokens) which you got during the Public [Account creation](https://partners.viber.com/account/create-bot-account).

### 4. Under the **`questions`** sheet, you can delete rows starting from 2 or just leave one question to identify user (eg.: _text_, _What's your surname_?)

### 5. Open the Script Editor

Open the **`Tools`** > **`<> Script editor`**

### 6. Upload .gs files.

a) Copy content of files and paste to new script. Rename. Create new **`+`** > **`Script`**. Repeat for another .gs file.

OR

b) Swtich to legacy mode and drug&drop file to editor (make sure you deleted default "function myFunction() {    }".  Repeat for another file.

### 7. Publish the script as a Web App - **`Deploy`** > **`New Deployment`**

![type](https://user-images.githubusercontent.com/17404606/124802762-fd08d100-df60-11eb-8755-951c965e5ede.png)

> **Note:** You **must** select the `Anyone` option for the "Who has access" dropdown or form responses will not be added to the spreadsheet!

### 8. Authorize the script to access your Google Sheet data on Google - Click **`Authorize access`**. Then under **`advanced`** click **`Go to...`**, And **`Allow`**.

**`Copy`** the web app URL to your clipboard / note pad.

### 9. Set the WebHook on Viber
You need to send POST request to Viber API.

a) In Linux: 
``curl -s -X post https://chatapi.viber.com/pa/set_webhook -d '{"auth_token":"paste-your-token","url":"paste-your-web-app-URL-from-the-previous-step"}'``

b) In Windows:
`curl -s -X post https://chatapi.viber.com/pa/set_webhook -d "{\"auth_token\":\"paste-your-token\",\"url\":\"paste-your-web-app-URL-from-the-previous-step\"}"`

c) In Firefox: **`F12`**, **`Network`**, go to [this page](https://chatapi.viber.com/pa/set_webhook), select request with file "set_webhook", **`edit and send again`**, type *POST* as method, delete headers, put this in text: `{"auth_token":"paste-your-token","url":"paste-your-web-app-URL-from-the-previous-step"}` and **`send`**. Check new request > **`reply`**. 

If "ok" - share bot & collect user ids.
If not "ok" - see [Error codes](https://developers.viber.com/docs/api/rest-bot-api/#error-codes).

### 10. Download [Viber.sh](Viber.sh) on zabbix server. //not ready
Move it to `/usr/local/share/zabbix/alertscripts` (default, may be defined at `zabbix_server.conf`).

Make executeble: `chmod +x /usr/local/share/zabbix/alertscripts/Viber.sh`

You can test it by executing: `/usr/local/share/zabbix/alertscripts/Viber.sh viberid test test your-auth-token`

### 11. Download [media_viber](media_viber.xml). //not ready
Go to **`Administration`** > **`Media types`**, and import .xml.

Script parameters:
{ALERT.SENDTO}, {ALERT.SUBJECT}, {ALERT.MESSAGE} and your-auth-token.

### 12. Go to **`Administration`** > **`Users`** and under media paste viber id from spreadsheet.  
