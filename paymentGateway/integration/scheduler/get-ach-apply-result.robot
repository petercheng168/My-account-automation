*** Settings ***
Documentation    Test suite of get ACH apply result from SFTP
Resource    ../../init.robot

Force Tags    PaymentGateway - Scheduler - Get ACH Apply Result
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Get ACH Apply Result - valid - with correct informations
    [Setup]    Generate ACH R02 Download File    ${upload_zip_file}    ${upload_file}    ${download_zip_file}    ${download_file}
    ${resp} =    Get ACH Apply Result    ${auth}
    Verify Schema    scheduler.json    getACHApplyResult    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['code']}    0
    Should Be Equal As Strings    ${resp.json()['message']}     ACH apply result operation successful
    [Teardown]    Remove Local File    ${upload_zip_file}    ${download_zip_file}    ${download_file}

*** Keywords ***
Generate ACH P02 Upload File
    Payment Gateway Test Data Setup    2    5    new_user
    Add Wallets    ${user_id}    1    9af15b336e6a9619928537df30b2e6a2376569fcf9d7e773eccede65606529a0    ${0}    TWD    ${auth}
    Add Automated Clearing Houses    ${user_id}    ${User.first_name}    ${account_num}    8120000    ${User.profile_id}A
    ...    ${User.profile_id}    ${transaction_id}    3    ${auth}
    Set Suite Variable    ${pay_source_account_id}    ${user_id}
    ACH Async Transaction Binds    ${transaction_id}    ${transaction_type}    ${pay_source_account_id}
    ...    ${pay_target_account_id}    ${pay_source_type}    ${pay_target_type}    ${auth}
    Sleep    5

Generate ACH R02 Download File
    [Documentation]    Generate ACH R02 download zip file
    [Arguments]    ${upload_zip_file}    ${upload_file}    ${download_zip_file}    ${download_file}
    Generate ACH P02 Upload File
    Open Connection    ${PAYMENT_GATEWAY_SFTP_ADDRESS}
    Login    ${PAYMENT_GATEWAY_SFTP_ACCOUNT}    ${PAYMENT_GATEWAY_SFTP_PASSWORD}
    Wait Until Keyword Succeeds    10sec    5sec    SSHLibrary.Get File    /home/rootadmin/ach/upload/${upload_zip_file}
    Unzip File    ${PROJECT_ROOT}/${upload_zip_file}    ${None}    54387162
    Replace ACH File    ${PROJECT_ROOT}/${upload_file}    ${PROJECT_ROOT}/${download_file}    ACHP02=ACHR02    N 00000000=R0
    Zip File    ${PROJECT_ROOT}/${download_file}    ${PROJECT_ROOT}/${download_zip_file}    54387162
    Put File    ${PROJECT_ROOT}/${download_zip_file}    /home/rootadmin/ach/download
    Sleep    5

Remove Local File
    [Documentation]    Remove the local ACH file
    [Arguments]    ${upload_zip_file}    ${download_zip_file}    ${download_file}
    Remove File    ${PROJECT_ROOT}/${upload_zip_file}
    Remove File    ${PROJECT_ROOT}/${download_zip_file}
    Remove File    ${PROJECT_ROOT}/${download_file}
    Close All Connections

Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    ${account_num} =    Generate Random String    10    [NUMBERS]
    ${current_date} =    Get Current Date    result_format=%Y%m%d
    ${transaction_id} =    Evaluate    str(int(time.time()))   time
    Set Suite Variable    ${account_num}
    Set Suite Variable    ${auth}
    Set Suite Variable    ${transaction_id}
    Set Suite Variable    ${transaction_type}    ${200}
    Set Suite Variable    ${account_num}
    Set Suite Variable    ${current_date}
    Set Suite Variable    ${upload_zip_file}    ACHP02_904_54387162_${current_date}.ZIP
    Set Suite Variable    ${upload_file}    ACHP02_904_54387162_${current_date}.TXT
    Set Suite Variable    ${download_zip_file}    ACHR02_904_54387162_${current_date}.ZIP
    Set Suite Variable    ${download_file}    ACHR02_904_54387162_${current_date}.TXT
    Set Suite Variable    ${pay_target_account_id}    1
    Set Suite Variable    ${pay_source_type}    ${1}
    Set Suite Variable    ${pay_target_type}    ${2}