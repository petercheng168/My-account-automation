*** Settings ***
Documentation    Test suite of priority setting
Resource    ../init.robot
Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Setup    Test Setup
Test Teardown    Click Gogoro Logo
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${ALLOCATION}             自動配車
${INPUT_CHANNEL}          Gogoro Taiwan Sales And Services
${INPUT_NUMBER}           P2006P00236
${INPUT_STORE}            土城裕民店
${PAIRING_GROUP_ADMIN}    QA00006
${PAIRING_GROUP_PASS}     Temp4321

*** Test Cases ***
Error order number inquiry
    [Tags]    CID:9939
    Input Text For Order Number Inquiry    ${random_string}
    Verify Error Order Number Inquiry Results

Order condition inquiry
    [Tags]    CID:9940
    Click Filter Icon
    Query Condition Setting    ${INPUT_CHANNEL}    ${INPUT_STORE}
    Verify Order Condition Inquiry Results    ${INPUT_NUMBER}    ${INPUT_CHANNEL}    ${INPUT_STORE}

Order number inquiry
    [Tags]    CID:9938
    Input Text For Order Number Inquiry    ${INPUT_NUMBER}
    Verify Order Number Inquiry Results    ${INPUT_NUMBER}    ${INPUT_CHANNEL}    ${INPUT_STORE}

*** Keywords ***
Suite Setup
    ${get_token} =    Get SP Token    ${SALES_ACCOUNT}    ${SALES_PASSWORD}
    ${date} =    Evaluate    time.strftime("%Y-%m-%d")    time
    Set Suite Variable    ${token}    ${get_token}
    Set Suite Variable    ${current_date}    ${date}
    Login With Direct Login    ${PAIRING_GROUP_ADMIN}    ${PAIRING_GROUP_PASS}

Test Setup
    ${random_string} =    Generate Random String    11    [NUMBERS]
    Set Test Variable    ${random_string}
    Click First Layer Item In Menu    /allocations
    Click Second Layer Item In Menu    /allocations/orders
    Verify Page URL    ${SALES_PORTAL_URL}/allocations/orders
