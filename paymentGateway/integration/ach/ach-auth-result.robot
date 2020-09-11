*** Settings ***
Documentation    Test suite of get applying ACH result list from Taishin FTP and update the status of auto pay config
Resource    ../../init.robot

Force Tags    PaymentGateway - ACH - ACH Auth Result
Suite Setup    Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
ACH auth result - empty - without authorization token and date
    ${resp} =    Ach Auth Result    ${EMPTY}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

ACH auth result - empty - without authorization token
    ${resp} =    Ach Auth Result    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

# 200_code_0 : no file name
ACH auth result - invalid - with incorrect date
    ${resp} =    Ach Auth Result    ${auth}    4000/01/01
    Verify Schema    ach.json    achAuthResult    ${resp.json()}    200_code_0
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Contain    ${resp.json()['ResultMessage']}    Get ach auth result file failed, fileName: ACHR02_904_54387162_40000101

# 200_code_1 : sftp has 10 working days ago file name
ACH auth result - valid - with correct information: default date
    [Setup]    Generate ACH R02 Download File    ${default_apply_date}    ${default_upload_zip_file}    ${default_upload_file}    ${default_download_zip_file}    ${default_download_file}
    ${resp} =    Ach Auth Result    ${auth}
    Verify Schema    ach.json    achAuthResult    ${resp.json()}    200_code_1
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    0
    Should Be Equal As Strings    ${resp.json()['ResultData'][0]['esContractId']}    ${es_contract_id}
    [Teardown]    Remove Local File    ${default_upload_zip_file}    ${default_download_zip_file}    ${default_download_file}

# 200_code_1 : sftp has recent working days ago file name
ACH auth result - valid - with correct information: recent date
    [Setup]    Generate ACH R02 Download File    ${current_apply_date}    ${recent_upload_zip_file}    ${recent_upload_file}    ${recent_download_zip_file}    ${recent_download_file}
    ${resp} =    Ach Auth Result    ${auth}    ${recent_working_date}
    Verify Schema    ach.json    achAuthResult    ${resp.json()}    200_code_1
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    0
    Should Be Equal As Strings    ${resp.json()['ResultData'][0]['esContractId']}    ${es_contract_id}
    [Teardown]    Remove Local File    ${recent_upload_zip_file}    ${recent_download_zip_file}    ${recent_download_file}

*** Keywords ***
Generate ACH R02 Download File
    [Documentation]    Generate ACH R02 download zip file
    [Arguments]    ${apply_date}    ${upload_zip_file}    ${upload_file}    ${download_zip_file}    ${download_file}
    Payment Gateway Test Data Setup    2
    Es Contract Autopay Config Post    ${es_contract_id}    ${User.first_name}    ${account_num}    8120023    ${User.profile_id}    3
    Ach Apply    ${apply_date}    ${es_contract_id}    ${auth}
    Open Connection    ${PAYMENT_GATEWAY_SFTP_ADDRESS}
    Login    ${PAYMENT_GATEWAY_SFTP_ACCOUNT}    ${PAYMENT_GATEWAY_SFTP_PASSWORD}
    Wait Until Keyword Succeeds    10sec    5sec    SSHLibrary.Get File    /home/rootadmin/upload/${upload_zip_file}
    Unzip File    ${PROJECT_ROOT}/${upload_zip_file}    ${None}    54387162
    Replace ACH P02 File    ${PROJECT_ROOT}/${upload_file}    ${PROJECT_ROOT}/${download_file}    ACHP02=ACHR02    N 00000000=R0
    Zip File    ${PROJECT_ROOT}/${download_file}    ${PROJECT_ROOT}/${download_zip_file}    54387162
    Put File    ${PROJECT_ROOT}/${download_zip_file}    /home/rootadmin/download

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
    ${current_apply_date} =    Get Current Date    result_format=%Y/%m/%d
    ${recent_working_date} =    Get Working Day    ${1}    date_format=%Y%m%d
    ${default_apply_date} =    Get Working Day    ${9}    date_format=%Y/%m/%d
    ${default_working_date} =    Get Working Day    ${10}    date_format=%Y%m%d
    Set Suite Variable    ${auth}
    Set Suite Variable    ${account_num}
    Set Suite Variable    ${current_apply_date}
    Set Suite Variable    ${recent_working_date}
    Set Suite Variable    ${default_apply_date}
    Set Suite Variable    ${default_working_date}
    Set Suite Variable    ${incorrect_date}    4000/01/01
    Set Suite Variable    ${incorrect_es_contract_id}    m4wP3AEZ
    Set Suite Variable    ${default_upload_zip_file}    ACHP02_904_54387162_${default_working_date}.ZIP
    Set Suite Variable    ${default_upload_file}    ACHP02_904_54387162_${default_working_date}.TXT
    Set Suite Variable    ${default_download_zip_file}    ACHR02_904_54387162_${default_working_date}.ZIP
    Set Suite Variable    ${default_download_file}    ACHR02_904_54387162_${default_working_date}.TXT
    Set Suite Variable    ${recent_upload_zip_file}    ACHP02_904_54387162_${recent_working_date}.ZIP
    Set Suite Variable    ${recent_upload_file}    ACHP02_904_54387162_${recent_working_date}.TXT
    Set Suite Variable    ${recent_download_zip_file}    ACHR02_904_54387162_${recent_working_date}.ZIP
    Set Suite Variable    ${recent_download_file}    ACHR02_904_54387162_${recent_working_date}.TXT