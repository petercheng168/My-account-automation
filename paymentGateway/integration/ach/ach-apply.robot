*** Settings ***
Documentation    Test suite of apply ach from bank for an es-bill which has es_contract_autopay_config
Resource    ../../init.robot

Force Tags    PaymentGateway - ACH - ACH Apply
Suite Setup    Suite Setup
Test Setup    Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
ACH apply - empty - without authorization token and informations: apply date and es contract id
    ${resp} =    Ach Apply    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

ACH apply - empty - without authorization token
    ${resp} =    Ach Apply    ${current_date}    ${es_contract_id}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

ACH apply - empty - without apply date
    ${resp} =    Ach Apply    ${EMPTY}    ${es_contract_id}    ${auth}
    Verify Schema    ach.json    achApply    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    Invalid apply_date

ACH apply - empty - without es contract id
    ${resp} =    Ach Apply    ${current_date}    ${EMPTY}    ${auth}
    Verify Schema    ach.json    achApply    ${resp.json()}    400
    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    Invalid es_contract_id

ACH apply - invalid - with incorrect es contract id
    ${resp} =    Ach Apply    ${current_date}    ${incorrect_es_contract_id}    ${auth}
    Verify Schema    ach.json    achApply    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    es-contract id list: ["${incorrect_es_contract_id}"] get data failed, Error: [604040002] GoPlatform :sql exception, detailed message: undefined

ACH apply - valid - with correct information
    ${resp} =    Ach Apply    ${current_date}    ${es_contract_id}    ${auth}
    Verify Schema    ach.json    achApply    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    ACH apply success

*** Keywords ***
Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    ${current_date} =    Get Current Date    result_format=%Y/%m/%d
    Set Suite Variable    ${auth}
    Set Suite Variable    ${current_date}
    Set Suite Variable    ${incorrect_es_contract_id}    m4wP3AEZ

Test Setup
    ${account_num} =    Generate Random String    10    [NUMBERS]
    Set Test Variable    ${account_num}
    Payment Gateway Test Data Setup    2
    Es Contract Autopay Config Post    ${es_contract_id}    ${User.first_name}    ${account_num}    8120023    ${User.profile_id}    3
