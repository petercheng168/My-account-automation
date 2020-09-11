*** Settings ***
Documentation    Test suite of inventory reserve setting
Resource    ../init.robot
Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Setup    Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${PAIRING_GROUP_ADMIN}    QA00006
${PAIRING_GROUP_PASS}     Temp4321
${RESERVE_INPUT_NUM}      5
${BCK}                    BCK
${ROW}                    1
${SKU_FIELD}              2
${COLOR_FIELD}            4

*** Test Cases ***
Change inventory reserve number
    [Tags]    CID:9933
    ${origin_resp} =    Get Scooter Model Inventory Reserve Number    ${ROW}
    Change Inventory Reserve Number    ${ROW}    ${RESERVE_INPUT_NUM}
    Verify Assign Row Of Scooter Model Inventory Reserve Number    ${ROW}    ${RESERVE_INPUT_NUM}
    [Teardown]    Change Inventory Reserve Number To Origin    ${ROW}    ${origin_resp}

SKU code search
    [Tags]    CID:9934
    Input Code For SKU Searchbox    ${BCK}
    Verify SKU Of Assign Row By SKU Search Result    ${ROW}    ${SKU_FIELD}
    Verify Color Of Assign Row By SKU Search Result    ${ROW}    ${COLOR_FIELD}
    [Teardown]    Click Gogoro Logo

*** Keywords ***
Change Inventory Reserve Number To Origin
    [Arguments]    ${row}    ${origin_num}
    Click Quantity Setting
    Input Reserve Number    quantity    ${origin_num}
    Click Quantity Setting Confirm
    ${current_num} =    Get Scooter Model Inventory Reserve Number    ${row}
    Should Be Equal As Strings    ${current_num}    ${origin_num}
    Click Gogoro Logo

Suite Setup
    Login With Direct Login    ${PAIRING_GROUP_ADMIN}    ${PAIRING_GROUP_PASS}

Test Setup
    Click First Layer Item In Menu    /allocations
    Click Second Layer Item In Menu    /allocations/reservations
    Verify Page URL    ${SALES_PORTAL_URL}/allocations/reservations
