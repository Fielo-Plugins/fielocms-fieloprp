# FieloPRP and FieloELR Instalation Guide

## 1. Installing Packages

We recomend using the following package versions:

| Package | Version | URL |
| --- | --- | --- |
| **FieloPLT** | **2.27.3** | /packaging/installPackage.apexp?p0=04t50000000M8P0 |
| **FieloCMS** | **1.75** | /packaging/installPackage.apexp?p0=04t36000000kNgP |
| **FieloELR** | **1.19** | /packaging/installPackage.apexp?p0=04t6A000000rgTn |
| **FieloPRP** | **1.5** | /packaging/installPackage.apexp?p0=04t46000001pj8g |

Install them in the following sequence:

1. **FieloPLT**
2. **FieloCMS**
3. **FieloELR**
4. **FieloPRP**

When you finish the installation of them all, you will be ready to go to the next section

## 2. Plugins Installation

Use the following combination of repositories/branches to configure your environment:

| Repository | Branch |
| --- | --- |
|[FieloCMS-FieloPLT](https://github.com/Fielo-Plugins/fielocms-fieloplt)| tag: v2.0.1 |
|[FieloCMS-FieloELR](https://github.com/Fielo-Plugins/fielocms-fieloelr)| master |
|[FieloCMS-FieloPRP](https://github.com/Fielo-Plugins/fielocms-fieloprp)| master |

Deploy them in the following order:

1. **FieloCMS-FieloPLT**
2. **FieloCMS-FieloELR**
3. **FieloCMS-FieloPRP**

After deploying all of them into your org follow the Official Documentation Guide that will guide you through all the org configuration such as:
 - Site Configuration
 - Customer Portal Configuration
 - Profile Configuration
 - and so on...
 
Here is the link to the Official Documentation:

> [Fielo PLT & CMS packages](https://documentation.fielo.com/docs/fielo-platform-cms-packages)

**_NOTE_**: Remember that the official documentation is for the PLT and CMS only. There are some sections that ask you to add permissions or set object attributes in order to enable them to the CMS. Do not forget to do the same for the ELR and PRP objects!!!

Here's a little help. These are the objects for each package that aren't in the Official Documentation:

_**FieloELR**_
- **Answer**
- **Answer Options**
- **Course**
- **Course Dependency**
- **Course Status**
- **Module**
- **Module Dependency**
- **Module Response**
- **Question**
- **Question Response**

_**FieloPRP**_
- **Invoice**
- **Invoice Item**
- **Product2** \*\*\*

\*\*\*: Depending on your implementation, another product object must replace the Product2 object

> **_TIP_**: The administrator user of the Org may not have access to some objects of the plugins because the plugin repositories don't deploy the user profile. For example, there is a section that asks you to create 2 segments with a specific RecordType. Two things may happen: the RecordType doesn't exist or you don't have access to it. Try creating the record types or editing your profile.

![Add Image](Source/Add%20RecordType.png?raw=true) <!-- .element height="50%" width="50%" -->

## 3. Libraries

After you followed all the steps from the Official Document and the notes and the tips of this tutorial, you can activate the Libraries of the Packages.
To do so, just go to:

> **Fielo Platform** App > **Libraries** Tab > In Each Library > _Activate_

**NOTE**: The FieloELR library has an issue. It uses Models in order to make easier for the users to create Courses from pre-defined templates. So, before you activate it, go to the Models Object

> **Setup** \> **Create** \> **Objects** \> **Model** (FieloPLT) > **FieloPLT\_\_Type\_\_c** Field

Add the value **Course** to the picklist values.

That should make you able to activate the FieloELR Library.

## 4. Plugins

In order to activate the required plugins go to:

> **Fielo CMS** App > **Plugins** Tab > **Actions** Button

For each plugin hit activate. In the following order:

- FieloCMS
- PlatformPlugin
- ElrPlugin
- PrpPlugin

## 4. Fielo Theme

### 4.1 Download the Theme

There is a repository that holds some styling templates for the CMS. Just go to:

> [Fielo Themes Latest Release](https://github.com/Fielo-Themes/origin/releases/latest)

And download the Zip file.

### 4.2 Upload the Theme into Salesforce

Back to your Salesforce Org, go to:

> **Setup** > **Develop** > **Static Resources**

Create a new static resource with this configuration

| Field | Value |
| --- | --- |
| Name | FieloCMS_Theme_Origin |
| File | File downloaded in step 4.1 |
| Cache Control | Public |

## 5. Create Your Site

Go to:

> **Fielo CMS** App > **Sites** Tab

By the first time in this page you will be asked to create a new Site Layout. We recommend using the _Create It_ link.

There you will choose your Site Name, Look & Feel and Template.

We recomend the following:

- **Look & Feel - Themes**: The only one available
- **Template**: Header + Footer

Then, edit your site and choose **Fielo** as your **Salesforce Site**.

After that, still in the Sites tab, create some pages. We suggest creating the following pages from its models:

- **FieloPLT**
  - Home
  - Contact Us
  - F.A.Q.s
  - Login & Register
  - My Profile

- **FieloELR**
  - Courses
  - Course Detail
  - Module Detail
  - Module Response Detail
  - My Courses

- **FieloPRP**
  - My Invoices
  - Invoice Detail
  - Invoice Upload Settings
  - Invoice Upload
  
### 5.1 FieloELR Implementation Guide

:warning: (_not working_)

### 5.2 FieloPRP Implementation Guide

After creating the suggested pages from step 5, one should do the following configuration. Go to:

> **My Invoices** Page > **My Invoices** Component

In the Record View Section chose **Internal Page**. For the **Detail component** choose **Invoice Detail > Invoice Record** and for the **Detail Parameter** choose **Id**

Then go to:

> **Invoice Upload** Page > **Invoice Upload** Widget

In the **Invoice Upload** section you should set the following:

| Field | Value | Description |
| --- | --- | --- |
| Redirect Page | Invoice Detail | |
| Main Source Component | Invoice Record | Description: Invoice Record Src |
| Secondary Source Component | Invoice Items | Desctiption: Invoice Items Src |
| Custom Detail Parameter | id |  |
| Submit Mode | Submit |  |
| Has Details	| True |  |
| Product Source Component | Product List |  |

**NOTE**: If you are not able to see any of this fields go to the Component object configuration or to your profile configuration and check the field's permissions.

Now go to:

> **Sites** Tab > **Main** Navigation

There is a button called **Add Existing Page**. With that, add the following pages:

- Home
- My Profile
- Contact Us
- F.A.Q.s
- Login & Register
- My Invoices
- Invoice Upload

## 6. Program Configuration CMS

In the Programs tab go to:

> Tools > Settings > "**Program > View**" settings

If the field isn't in the classic layout edit the layout and add the field "**Standard Actions**", hit save. In the **Program > View** page settings add the value **View** to the field **Standard Actions** and save.

![Add Image](Source/Add%20View%20Action.png?raw=true) <!-- .element height="50%" width="50%" -->

After that, go back to the Programs tab and go to:

> Tools > View

If they are not in the layout add the fields **Register Step 2 Page**, **Site URL**, **Site User Profile** and **User Creation Class** to the layout and set them as follows:

| Field | Value | Description |
| --- | --- | --- |
| Register Step 2 Page | Register 2 | |
| Site URL | <_site\_url_> | The Site URL from the site configured for this CMS |
| Site User Profile | Fielo Member Site |  |
| User Creation Class | UserCreationFielo |  |

Example:

![Program Site Config](Source/ProgramSiteConfig.gif?raw=true)

By now your Site should be working. There are few steps more to be 100% functional.

## 7. Add tabs to Fielo Platform App

Go to:

> Setup > Create > Apps > Fielo Platform > Edit

Add Invoices to the **Selected Tabs**

![Fielo Platform Tabs](Source/FieloPlatformAppConfig.gif)

## 8. Create a Member to access the Site

First, we must create the Account that will hold the members.

Go to:

> All tabs > Accounts

Just create an Account and fill all the required fields.

Then go to Members tab and hit New

Fill the fields in the form, put your email and the Account created in the previous instruction.

This should create the member and also creates a contact under the previous created account.

Before creating the user for the Member, first we must set a **Role** for the **current user** in order to be able to create other users.

Under your name click on **My settings** and then go to:

> Personal > Advanced User Details

Hit *edit* and choose a Role for you. (It doesn't matter which one you choose)

Click save.

Now go to the Account. In the Account Detail you will see a related list with a contact with the same configuration of member you just created. 

Click on the contact name.

In the Contact Detail go to **Manage External User** and click on **Enable Customer User**.

Set the following configuration:

| Field | Value |
| --- | --- |
| User License | Authenticated Website |
| Profile | Fielo Member Site |

Hit save.

In the new user detail, save somewhere the User Id *(you can get it in the URL)*.

Now go to the member again and with the help of any plugin or through the developer console or through the classic salesforce view update the member field whose apiname is **FieloPLT\_\_User\_\_c**.

Now go to your CMS Portal and go to the tab "**LOGIN & REGISTER**".

If you are not able to see the login section do the following:

In the backend go to:

> Fielo CMS App > Sites Tab > Login & Register Component

Remove the component Login and add the Login component which configuration has only three fields (Title, CSS Classname and Order)

After that if the CMS asks you for authentication go to the Member Profile and to the Site Public settings and add the Login Class to the allowed Apex Classes.

:construction: :warning: **_Work In Progress! This Document isn't ready yet!!!_** :warning: :construction:
