*** Settings ***
Documentation    Test suite of apply ach from bank for an es-bill which has es_contract_autopay_config
Resource    ../../init.robot

Force Tags    PaymentGateway - ACH - ACH Writeoff Apply
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Ach writeoff - empty - without authorization token and writeoffDate
    ${resp} =    Ach Writeoff    ${EMPTY}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Ach writeoff - empty - without auth
    ${resp} =    Ach Writeoff    ${date}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Ach writeoff - invalid - with with incorrect date
    ${resp} =    Ach Writeoff    40000101    ${auth}
    Verify Schema    ach.json    achWriteOff    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Contain    ${resp.json()['ResultMessage']}    Get ach auth result file failed, fileName: ACHR01_904_54387162_40000101_1

Ach writeoff - valid - with correct information
    [Setup]    Generate ACH R01 Download File    ${upload_zip_file}    ${upload_file}    ${download_zip_file}    ${download_file}
    ${resp} =    Ach Writeoff    ${date}    ${auth}
    Verify Schema    ach.json    achWriteOff    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    0
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    ACH write off success.
    [Teardown]    Remove Local File    ${upload_zip_file}    ${download_zip_file}    ${download_file}

*** Keywords ***
Generate ACH R01 Download File
    [Documentation]    Generate ACH RO1 download zip file
    [Arguments]    ${upload_zip_file}    ${upload_file}    ${download_zip_file}    ${download_file}
    Payment Gateway Test Data Setup    2
    Es Contract Autopay Config Post    ${es_contract_id}    ${User.first_name}    ${account_num}    8120023    ${User.profile_id}    3
    Ach Writeoff Apply    ${Bill.from_time}    ${Bill.to_time}    ${auth}
    Wait Until Keyword Succeeds    10sec    5sec    Get Logs    Upload fileName: ${upload_zip_file} successfully
    Open Connection    ${PAYMENT_GATEWAY_SFTP_ADDRESS}
    Login    ${PAYMENT_GATEWAY_SFTP_ACCOUNT}    ${PAYMENT_GATEWAY_SFTP_PASSWORD}
    SSHLibrary.Get File    /home/rootadmin/upload/${upload_zip_file}
    Unzip File    ${PROJECT_ROOT}/${upload_zip_file}    ${None}    54387162
    ACH R01 Content List
    Replace ACH P01 File    ${PROJECT_ROOT}/${upload_file}    ${PROJECT_ROOT}/${download_file}    ${replace_list}
    Zip File    ${PROJECT_ROOT}/${download_file}    ${PROJECT_ROOT}/${download_zip_file}    54387162
    Put File    ${PROJECT_ROOT}/${download_zip_file}    /home/rootadmin/download

Remove Local File
    [Documentation]    Remove the local ACH file
    [Arguments]    ${upload_zip_file}    ${download_zip_file}    ${download_file}
    Remove File    ${PROJECT_ROOT}/${upload_zip_file}
    Remove File    ${PROJECT_ROOT}/${download_zip_file}
    Remove File    ${PROJECT_ROOT}/${download_file}
    Close All Connections

ACH R01 Content List
    ${replace_list} =    Create List    ${User.profile_id}    ${Bill.bank_code1}    00
    Set Suite Variable    ${replace_list}

Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    ${account_num} =    Generate Random String    10    [NUMBERS]
    ${date} =    Get Current Date    increment=-15 days    result_format=%Y%m%d
    Set Suite Variable    ${auth}
    Set Suite Variable    ${account_num}
    Set Suite Variable    ${date}
    Set Suite Variable    ${upload_zip_file}    ACHP01_904_54387162_${date}_1.ZIP
    Set Suite Variable    ${upload_file}    ACHP01_904_54387162_${date}_1.TXT
    Set Suite Variable    ${download_zip_file}    ACHR01_904_54387162_${date}_1.ZIP
    Set Suite Variable    ${download_file}    ACHR01_904_54387162_${date}_1.TXT