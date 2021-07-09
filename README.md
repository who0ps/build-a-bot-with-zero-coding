# If you want to build bot just to send alerts from Zabbix, [read this](README-ZBX.md).

# Build a Bot with Zero Coding

Most bot tutorials are for people who can code, so if you don’t have developers or staff with extra time on their hands your custom needs may not be met. Building a bot requires technical resources, such as servers to run the logic, storage to store data points and developers, well, to code. Until now. In this tutorial, we’ll show how you can build a survey bot right from a Google Sheet.

## Why?

Instead of using a server to run your bot logic (which is actually easy, but it requires maintenance), use Google as your hosting environment on your behalf and use Google Sheets to keep track of the survey answers!

![Animation flow](https://github.com/devrelv/blog/blob/master/google_sheet_flow.gif?raw=true)

### Code running on a spreadsheet?
Google Apps Script is a JavaScript-based scripting language that lets you add functionality to your Google Apps. It is a cloud‑based language that integrates with all other Google services, including Gmail, Google Drive, Calendar, Google Forms, Sheets and more. Apps Script is incredibly versatile. It allows you to:

- Add custom menus, dialogs, and sidebars to Google Docs, Sheets and Forms
- Write custom functions for Google Sheets. Like fetch extra data from external services or even plot some sophisticated charts
- Publish web apps — either standalone or embedded in Google Sites
- Interact with other Google services, including AdSense, Analytics, Calendar, Drive, Gmail and Maps

## Prerequisites
- Have a [Google Account](https://accounts.google.com)
- [Get your Viber Account authentication token](https://partners.viber.com/account/create-bot-account) 

## How?

### 1. Download [SurveyChatBot](SurveyChatBot.xlsx), [keyboardGenerator](keyboardGenerator.gs) and [script](script.gs).

### 2. Upload or import spreadsheet (SurveyChatBot.xlsx) to [Google Docs](https://sheet.new).

### 3. Under the **`parameters`** sheet, edit the following fields:

- Access Token - Use the [Access Token](https://developers.viber.com/docs/faq/#authentication-tokens) which you got during the Public [Account creation](https://partners.viber.com/account/create-bot-account).
- Bot Name - Be creative!
- Bot Avatar URL - URL of the survey avatar. Avatar size should be no more than 100 kb. Recommended 720x720
- Welcome to survey message - This is the welcome message which the user will receive from the survey bot
- Welcome start button - Call on the user to begin interacting with the bot
- End survey message - This is the message the bot will send at the end of the survey. It is generally a “Thank you” message
- Do not understand message - This message will be sent if the user enters invalid input (a picture, sticker, etc.)
- Should keyboard use random colors - Should the bot use random colors for different survey answer options or not. Acceptable values are `true` or `false`
- Default keyboard option color - In case you choose not to use random color, you can set the default color here. Please use `Color Hex` [format](http://www.color-hex.com//") only. For example `#999999`

This is the difference between a keyboard with specific colors versus one generated with random colors:

![diffs](https://user-images.githubusercontent.com/17404606/124808509-b2d71e00-df67-11eb-9858-10f6d03d083f.png)

### 4. Under the **`questions`** sheet, edit your questions:

#### Question types
Our survey bot supports three (3) different types of questions: `range`, `keyboard` and `text`:

- `range` -  Asks the user to enter a valid value from a custom range. It makes sense to provide a range when the user needs to score something.

	![range](https://user-images.githubusercontent.com/17404606/124808598-cda99280-df67-11eb-9201-f201ada09452.png)
- `keyboard` - Show case different selection options via the Viber's keyboard.

	![keyboard](https://user-images.githubusercontent.com/17404606/124808710-edd95180-df67-11eb-88a1-7aaeb2048fdc.png)

- `text` - Free text input.

	![text](https://user-images.githubusercontent.com/17404606/124808794-0d707a00-df68-11eb-9959-a552bda0f96a.png)


#### Editing questions
Each row in the spreadsheet equals to a survey question and ordered by sequence. Hence the first row (after the header) will contain the first question, while the 7th row will contain the seventh question.

**Adding a `range` question**

- Under the `type` column write `range`
- Under the `question` column write your question. Best practice is to mention the actual valid range.
- Under the `extras` column write the acceptable values, separated by semicolons. For example `0;1;2;3`.

**Adding a `keyboard` question**

- Under the `type` column write `keyboard`
- Under the `question` column write your question.
- Under the `extras` column write the options, separated by semicolons. For example `Yes;No`.

**Adding a `text` question**

- Under the `type` column write `text`
- Under the `question` column write your question.

### 5. Open the Script Editor

Open the **`Tools`** > **`<> Script editor`**

### 6. Upload .gs files.

a) Copy content of files and paste to new script. Rename. Create new **`+`** > **`Script`**. Repeat for another .gs file.

OR

b) Swtich to legacy mode and drug&drop file to editor (make sure you deleted default "function myFunction() {    }".  Repeat for another file.

### 7. Publish the script as a Web App

![deploy](https://user-images.githubusercontent.com/17404606/124802649-e06c9900-df60-11eb-98c7-8882a40fcfe9.png)

![type](https://user-images.githubusercontent.com/17404606/124802762-fd08d100-df60-11eb-8755-951c965e5ede.png)

> **Note:** You **must** select the `Anyone` option for the "Who has access" dropdown or form responses will not be added to the spreadsheet!

### 8. Authorize the script to access your Google Sheet data on Google - Click **`Authorize access`**

Then under **`advanced`** click **`Go to...`**

![secure](https://user-images.githubusercontent.com/17404606/124810403-f599f580-df69-11eb-9d8c-5e1cb56c92b1.png)

And **`Allow`**:

![allow](https://user-images.githubusercontent.com/17404606/124810777-680ad580-df6a-11eb-8b6b-07b9d042089c.png)

> \*You will get Security alert email from Google, but this is ok - its your own APP.

**`Copy`** the web app URL to your clipboard / note pad.
Then Click **`Done`**.

![copy](https://user-images.githubusercontent.com/17404606/124811072-bd46e700-df6a-11eb-8f60-b3055d703467.png)

### 9. Set the WebHook on Viber
You need to send POST request to Viber API.

a) In Linux: 
``curl -s -X post https://chatapi.viber.com/pa/set_webhook -d '{"auth_token":"paste-your-token","url":"paste-your-web-app-URL-from-the-previous-step"}'``

b) In Windows: **`Win+R`**, *cmd*:
`curl -s -X post https://chatapi.viber.com/pa/set_webhook -d "{\"auth_token\":\"paste-your-token\",\"url\":\"paste-your-web-app-URL-from-the-previous-step\"}"`

c) In Firefox: **`F12`**, **`Network`**, go to [this page](https://chatapi.viber.com/pa/set_webhook), select request with file "set_webhook", **`edit and send again`**, type *POST* as method, delete headers, put this in text: `{"auth_token":"paste-your-token","url":"paste-your-web-app-URL-from-the-previous-step"}` and **`send`**. Check new request > **`reply`**. 

If you get "ok" - **Done**. That's it. You just created your very own survey chat bot! Your survey answers will populate on the **`answers`** sheet.
If not "ok" - see [Error codes](https://developers.viber.com/docs/api/rest-bot-api/#error-codes).

![done](https://user-images.githubusercontent.com/17404606/124811565-44945a80-df6b-11eb-902f-9686a89125d6.png)

### If you want new bot on same accounts - open spreadsheet at Google docs. Click **`File`** > **`Make a copy`** and do steps: 3,4,5,7,8,9.

## Want more?
Feel free to customize the code, add more question types, improve the flow or even accept pictures as valid input!

## How to report bugs
If you find any issues with this sample, please open an [issue on GitHub](https://github.com/who0ps/build-a-bot-with-zero-coding/issues/new) or [to original repo](https://github.com/Viber/build-a-bot-with-zero-coding/issues/new).

## Background reading

+ [Google Apps Scripts Basics](https://developers.google.com/apps-script)
+ [Simple Mail Merge using Google Sheets](https://developers.google.com/apps-script/articles/mail_merge)
