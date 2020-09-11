*** Settings ***
Documentation    Test suite of get ACH result from FTP
Resource    ../../init.robot

Force Tags    PaymentGateway - Scheduler - Get ACH Writeoff Result
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Get ACH write-off result - valid - with correct information
    [Setup]    Generate ACH R01 Download File    ${upload_zip_file}    ${upload_file}    ${download_zip_file}    ${download_file}
    ${resp} =    Get ACH Write Off Result    ${auth}
    Verify Schema    scheduler.json    getACHWriteOffResult    ${resp.json()}    200
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['code']}    0
    Should Be Equal As Strings    ${resp.json()['message']}    Accept write off request successfully, write off result: [{"code":0,"filename":"${download_zip_file}","message":"ACH write off success, filename: ${download_zip_file}"}]
    [Teardown]    Remove Local File    ${upload_zip_file}    ${download_zip_file}    ${download_file}

*** Keywords ***
Generate ACH R01 Download File
    [Documentation]    Generate ACH RO1 download zip file
    [Arguments]    ${upload_zip_file}    ${upload_file}    ${download_zip_file}    ${download_file}
    Payment Gateway Test Data Setup    2    5    new_user
    Add Wallets    ${user_id}    1    9af15b336e6a9619928537df30b2e6a2376569fcf9d7e773eccede65606529a0    ${0}    TWD    ${auth}
    Add Automated Clearing Houses    ${user_id}    ${User.first_name}    ${account_num}    8120000    ${User.profile_id}A
    ...    ${User.profile_id}    ${transaction_id}    3    ${auth}
    Apply ACH Write Off    ${auth}
    Sleep    5
    Open Connection    ${PAYMENT_GATEWAY_SFTP_ADDRESS}
    Login    ${PAYMENT_GATEWAY_SFTP_ACCOUNT}    ${PAYMENT_GATEWAY_SFTP_PASSWORD}
    SSHLibrary.Get File    /home/rootadmin/ach/upload/${upload_zip_file}
    Unzip File    ${PROJECT_ROOT}/${upload_zip_file}    ${None}    54387162
    Replace ACH File    ${PROJECT_ROOT}/${upload_file}    ${PROJECT_ROOT}/${download_file}    ACHP01=ACHR01
    Zip File    ${PROJECT_ROOT}/${download_file}    ${PROJECT_ROOT}/${download_zip_file}    54387162
    Put File    ${PROJECT_ROOT}/${download_zip_file}    /home/rootadmin/ach/download/
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
    ${transaction_id} =    Evaluate    str(int(time.time()))   time
    ${date} =    Get Current Date    result_format=%Y%m%d
    Set Suite Variable    ${auth}
    Set Suite Variable    ${account_num}
    Set Suite Variable    ${transaction_id}
    Set Suite Variable    ${date}
    Set Suite Variable    ${upload_zip_file}    ACHP01_904_54387162_${date}_1.ZIP
    Set Suite Variable    ${upload_file}    ACHP01_904_54387162_${date}_1.TXT
    Set Suite Variable    ${download_zip_file}    ACHR01_904_54387162_${date}_1.ZIP
    Set Suite Variable    ${download_file}    ACHR01_904_54387162_${date}_1.TXT