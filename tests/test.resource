*** Settings ***
Documentation     A resource file with reusable keywords and variables.
Library           OperatingSystem
Library           Process
Library           RPA.Browser.Selenium

*** Variables ***
${SERVER}         localhost:7272
${BROWSER}        %{TEST_BROWSER=Firefox}
${DELAY}          0
${VALID USER}     demo
${VALID PASSWORD}    mode
${LOGIN URL}      http://${SERVER}/
${WELCOME URL}    http://${SERVER}/welcome.html
${ERROR URL}      http://${SERVER}/error.html

*** Keywords ***
Test Setup Actions
    Start Process  python  demoapp/server.py
    Log Variables
    Log Environment Variables
    Open Browser To Login Page

*** Keywords ***
Test Teardown Actions
    Close Browser
    Terminate All Processes

Open Browser To Login Page
    IF  $BROWSER=='Any'
        Open Available Browser    ${LOGIN URL}
    ELSE
        Open Browser    ${LOGIN URL}    ${BROWSER}
    END
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    Login Page

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    username_field    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password_field    ${password}

Submit Credentials
    Click Button    login_button

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Title Should Be    Welcome Page
