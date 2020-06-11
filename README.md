# Oxygen Feedback Integration
Sample project that that illustrates how to integrate Oxygen Feedback in WebHelp Responsive output.

Published output: https://oxygenxml.github.io/oxygen-feedback-integration/

## Adding Oxygen Feedback to WebHelp Responsive Generated Output

To install **Oxygen Feedback** in your WebHelp output generated using a transformation from a command line \(using the **Oxygen XML WebHelp** plugin or **Oxygen Publishing Engine**\), use this procedure:

### Prerequisites

-   You must have a licensed version of **Oxygen XML WebHelp** or **Oxygen Publishing Engine**.
-   To install and manage Oxygen Feedback, you will need to choose a subscription plan during the installation procedure. To see the subscription plans prior to installing the product, go to: [https://www.oxygenxml.com/oxygen\_feedback/buy\_feedback.html](https://www.oxygenxml.com/oxygen_feedback/buy_feedback.html).
**Note:** If your subscription expires or if the number of page views allowed by your plan is exceeded for a particular month, you will receive a notification and the comments component will be disabled until the subscription is renewed/upgraded or until the end of the month \(in the case of exceeding the page views limit\).

### Installation Procedure

1.  Log in to your Feedback account from the *login page* \([https://feedback.oxygenxml.com/login](https://feedback.oxygenxml.com/login)\). You can click on **Log in with Google** or **Log in with Facebook** to create an account using your Google or Facebook credentials or click the **Sign Up** tab to create an account using your name and email address.

    **Step Result:** If this is your first time logging in and you have not yet created a site configuration, you are directed to a Welcome page. Otherwise, you are directed to the **Dashboard** page.

2.  Click the **Add your first site** button to [create a site configuration](https://www.oxygenxml.com/doc/versions/1.2/ug-feedback/topics/ofb-creating-site.html#ofb-creating-site) \(if you are on the **Dashboard** page, click the **Add site** link in the top-right corner of the [**Sites** pane](https://www.oxygenxml.com/doc/versions/1.2/ug-feedback/topics/ofb-dashboard.html#ofb-dashboard__sites-pane)\). If you have not already selected a subscription plan, you will be directed to a page where you can choose from several options.
3.  In the **Settings** page, enter a **Name** and **Description** for the site configuration. Some optional settings can be adjusted according to your needs. For more details, see the [Settings Page](https://www.oxygenxml.com/doc/versions/1.2/ug-feedback/topics/ofb-creating-site.html#ofb-site-settings-page) topic. Click **Continue**.
4.  In the **Version** page, you must specify a version and the base URL from your website where the WebHelp output is deployed. The **Name** field is where you specify the version name or identifier. This is helpful if there will be multiple versions for your output. For example, if your published output is documentation for a product that has multiple released versions, each version probably has its own published documentation. In this case, each published version requires a different configuration since the version and base URL would be different for each of them.

    The **Site base URL** field is where you specify the base URL for the website where you publish your output. For WebHelp output, for example, it is the URL where your WebHelp output is deployed. Comments will only be displayed on pages within the hierarchy of the specified base URL. For more details, see the [Version Page](https://www.oxygenxml.com/doc/versions/1.2/ug-feedback/topics/ofb-creating-site.html#ofb-site-initial-version) topic. Click **Continue**.

5.  In the **Installation** page, choose the **Install Feedback in WebHelp output generated from a command line** option.
6.  Create an XML file \(for example, `feedback-fragment.xml`\) on disk with the content generated in the **Installation** page in the admin UI.
7.  In the Putblishing Template Decriptor file \(.opt\), use the `webhelp.fragment.feedback` HTML fragment to specify the path to the file created in the previous step. For example:

    ```xml
    <html-fragments>
      <fragment file="feedback-fragment.xml" placeholder="webhelp.fragment.feedback"/>
    </html-fragments>
    ```

## Automating DITA to WebHelp Responsive Output with Travis CI

This procedure assumes you have a DITA project hosted on a GitHub public or private repository.

The goal of this tutorial is to help you set up a Travis continuous integration job that automatically publishes your DITA project to [GitHub pages](https://pages.github.com/) after every commit. The published website will contain a feedback link on each page that would allow a contributor to easily suggest changes to the documentation by creating a pull request on GitHub with just a few clicks.

### Enable the Travis CI Build 

1.  [Sign in to Travis CI](https://travis-ci.org/) with your GitHub account and accept the GitHub [access permissions confirmation](https://docs.travis-ci.com/user/github-oauth-scopes).
2.  Once you are signed in, and you have synchronized your GitHub repositories, go to your [profile page](https://travis-ci.org/profile) and enable Travis CI for the repository you want to build.

### Configure the Travis CI Build in your GitHub Project

1.  Checkout your GitHub project locally.
2.  Copy the .travis folder from this project to the root directory of your project.
3.  In the root of your GitHub project, add a file called .travis.yml with the following content:

    ```
    language: dita
    install:
    - echo "Installed"
    script:
    - sh .travis/publish.sh
    after_success:
    - sh .travis/deploy.sh
    env:
        global:
        - DITAMAP=dita/garage/garage.ditamap
        - DITAVAL=dita/garage/filter.ditaval
        - OPT_DIR=publishing/material/
        - OPT_FILE=material.opt
        - ANT_OPTS=-Xmx1024M
        - OUT_DIR=output
        - TEMP_DIR=temp
    before_install:
    - chmod +x .travis/publish.sh
    - chmod +x .travis/deploy.sh
    
    ```
4.  Create a GitHub personal access token by following [this procedure](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line).
5.  [Define an environment variable in the repository settings](https://docs.travis-ci.com/user/environment-variables/#Defining-Variables-in-Repository-Settings) that has the name `GH_TOKEN` and the value equal with the GitHub personal access token created earlier.

### Register Your License Key 

1.  Edit your .gitignore file \(or create it if it does not already exist\) and add the following line:

    ```
    licenseKey.txt
    ```

2.  Copy your WebHelp license to the root of your GitHub project in a file called licenseKey.txt. **Important:** The licenseKey.txt file should not be committed to GitHub as it contains a license key that is issued only to you.
3.  [Encrypt the license key file](https://docs.travis-ci.com/user/encrypting-files/#Automated-Encryption) and **add** it to the .travis.yml configuration file. This ensures that only the Travis CI server will be able to decrypt it during the build process.

### Commit to GitHub 

1.  Commit the following files and folders and push the commit to GitHub:

    ```
    git add .gitignore licenseKey.txt.enc .travis.yml .travis/
    git commit -m "Set up the Travis CI publishing system"
    git push
                        
    ```

2.  Create a `gh-pages` branch in your GitHub project where the WebHelp Responsive output will be published. You can follow the procedure [here](https://help.github.com/en/github/working-with-github-pages/creating-a-github-pages-site).




