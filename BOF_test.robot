*** Settings ***
Library    Browser
Test Timeout    60 seconds
Suite Setup    Login To System
Suite Teardown    Close Browser

*** Variables ***
${URL}           https://sit-uplifestyle-admin.thailife.com
${USERNAME}      saranyapong.tar@thailife.com
${PASSWORD}      P@ssword1

*** Test Cases ***

Test Content Management - Manage Feeds
    Click Menu If Needed    Content Management    Manage Feeds
    Click    text=Manage Feeds
    Wait For Elements State    xpath=//div[text()="Manage Feeds"]    visible    timeout=10s
    ${text}=    Get Text    xpath=//div[text()="Manage Feeds"]
    Log    Found Heading: ${text}
    Should Be Equal As Strings    ${text}    Manage Feeds

Test Content Management - Manage Banner
    Click Menu If Needed    Content Management    Manage Banner
    Click    text=Manage Banner
    Wait For Elements State    xpath=//div[text()="Manage Banner"]    visible    timeout=10s
    ${text}=    Get Text    xpath=//div[text()="Manage Banner"]
    Log    Found Heading: ${text}
    Should Be Equal As Strings    ${text}    Manage Banner

Test Content Management - Manage Quote
    Click Menu If Needed    Content Management    Manage Quote
    Click    text=Manage Quote
    Wait For Elements State    xpath=//div[text()="Manage Quote"]    visible    timeout=10s
    ${text}=    Get Text    xpath=//div[text()="Manage Quote"]
    Log    Found Heading: ${text}
    Should Be Equal As Strings    ${text}    Manage Quote

Test Content Management - Manage Popup
    Click Menu If Needed    Content Management    Manage Popup
    Click    text=Manage Popup
    Wait For Elements State    xpath=//div[text()="Manage Popup"]    visible    timeout=10s
    ${text}=    Get Text    xpath=//div[text()="Manage Popup"]
    Log    Found Heading: ${text}
    Should Be Equal As Strings    ${text}    Manage Popup

Test Log Monitoring - Admin Activity Log
    Click Menu If Needed    Log Monitoring    Admin Activity Log
    Click    text=Admin Activity Log
    Wait For Elements State    xpath=//div[text()="Admin Activity Log"]    visible    timeout=10s
    ${text}=    Get Text    xpath=//div[text()="Admin Activity Log"]
    Log    Found Heading: ${text}
    Should Be Equal As Strings    ${text}    Admin Activity Log

Test Customer Management - Application User Info
    Click Menu If Needed    Customer Management    Application User Information
    Click    text=Application User Information
    Wait For Elements State    xpath=//div[text()="Application User Info"]    visible    timeout=10s
    ${text}=    Get Text    xpath=//div[text()="Application User Info"]
    Log    Found Heading: ${text}
    Should Be Equal As Strings    ${text}    Application User Info

Test System Configuration - Manage Role & Permission
    Click Menu If Needed    System Configuration    Manage Role & Permission
    Click    text=Manage Role & Permission
    Wait For Elements State    xpath=//div[text()="Manage Roles and Permissions"]    visible    timeout=10s
    ${text}=    Get Text    xpath=//div[text()="Manage Roles and Permissions"]
    Log    Found Heading: ${text}
    Should Be Equal As Strings    ${text}    Manage Roles and Permissions

*** Keywords ***
Login To System
    New Browser    chromium    headless=False
    New Context    locale=en-US
    New Page    ${URL}
    Set Browser Timeout    60 seconds
    Wait For Elements State    text=Welcome Back    visible    timeout=30s
    Click    text=Sign in >> nth=1
    Sleep    2s

    ${pick_account}=    Run Keyword And Return Status    
    ...    Wait For Elements State    text=Pick an account    visible    timeout=5s
    Run Keyword If    ${pick_account}    Click    text=Saranyapong Tarama

    ${email_field}=    Run Keyword And Return Status    
    ...    Wait For Elements State    input[type="email"]    visible    timeout=5s
    Run Keyword If    ${email_field}    Fill Text    input[type="email"]    ${USERNAME}
    Run Keyword If    ${email_field}    Click    text=Next

    ${password_field}=    Run Keyword And Return Status    
    ...    Wait For Elements State    input[type="password"]    visible    timeout=8s
    Run Keyword If    ${password_field}    Fill Text    input[type="password"]    ${PASSWORD}
    Run Keyword If    ${password_field}    Click    css=input[value="Sign in"]

    ${stay_signed}=    Run Keyword And Return Status    
    ...    Wait For Elements State    text=Stay signed in?    visible    timeout=5s
    Run Keyword If    ${stay_signed}    Click    text=Yes

    Wait For Elements State    text=UP Lifestyle Backoffice    visible    timeout=30s

Click Menu If Needed
    [Arguments]    ${menu_name}    ${submenu_item}
    ${submenu_visible}=    Run Keyword And Return Status    
    ...    Wait For Elements State    text=${submenu_item}    visible    timeout=3s
    Run Keyword If    not ${submenu_visible}    Click    text=${menu_name}
    Run Keyword If    not ${submenu_visible}    Sleep    1s
