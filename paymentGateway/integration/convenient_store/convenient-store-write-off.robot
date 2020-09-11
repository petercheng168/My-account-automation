*** Settings ***
Documentation    Test suite of Get conveninet store write-off file from Taishin and send the write-off request to write-off service
Resource    ../../init.robot

Force Tags    PaymentGateway - Convenient Store - Convenient Store Write Off
Suite Setup    Suite Setup
Test Teardown    Remove File And Close Connection
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Convenient store write off - empty - without authorization token and fileName
    [Setup]   Generate ES Bill And Convenient Store File    1
    ${resp} =    Write Off Convenient Store    ${EMPTY}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

Convenient store write off - empty - without authorization token
    [Setup]    Generate ES Bill And Convenient Store File    1
    ${resp} =    Write Off Convenient Store    ${file_name}    ${EMPTY}
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}    Unauthorized

# 200_code_0 : no file name
Convenient store write off - empty - without fileName
    [Setup]    Generate ES Bill And Convenient Store File    1
    ${resp} =    Write Off Convenient Store    ${EMPTY}    ${auth}
    Verify Schema    convenient_store.json    getConvenientStoreWriteoff    ${resp.json()}    200_code_0
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    There is no file: ${SPACE}to writeOff

# 200_code_1 : file name not duplicate, bills not exist
Convenient store write off - invalid - with incorrect information: non-exist virtual account
    [Setup]    Generate ES Bill And Convenient Store File    0
    ${resp} =    Write Off Convenient Store    ${file_name}    ${auth}
    Verify Schema    convenient_store.json    getConvenientStoreWriteoff    ${resp.json()}    200_code_1
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    1
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    0
    Should Be Equal As Strings    ${resp.json()['ResultData'][0]['ResultMessage']}    transactionId: ${file_name}_0, virtualAccount: 0000000000000000, Internal Server Error: no bills found

# 200_code_0 : file name duplicate
Convenient store write off - invalid - with incorrect information: duplicate file name
    [Setup]    Generate ES Bill And Convenient Store File    1
    ${resp} =    Write Off Convenient Store    ${duplicate_file_name}    ${auth}
    Verify Schema    convenient_store.json    getConvenientStoreWriteoff    ${resp.json()}    200_code_0
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    0
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    -1
    Should Be Equal As Strings    ${resp.json()['ResultMessage']}    fileName: ${duplicate_file_name}, transaction status already update to 131.

# 200_code_1 : file name non duplicate, bills exist
Convenient store write off - valid - with correct information: new file and bill exist
    [Setup]    Generate ES Bill And Convenient Store File    1
    ${resp} =    Write Off Convenient Store    ${file_name}    ${auth}
    Verify Schema    convenient_store.json    getConvenientStoreWriteoff    ${resp.json()}    200_code_1
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['Code']}    1
    Should Be Equal As Strings    ${resp.json()['ResultCode']}    0
    Should Be Equal As Strings    ${resp.json()['ResultData'][0]['ResultMessage']}    transactionId: ${file_name}_0, virtualAccount: ${Bill.store_code2}, success

*** Keywords ***
Create Convenient Store File
    [Documentation]    Keyword to create convenient store txt file as Taishin Bank format
    [Arguments]    ${flag}
    Run Keyword If    '${flag}' == '1'    Set Test Variable    ${store_code}    ${Bill.store_code2}
    ...    ELSE    Set Test Variable    ${store_code}    0000000000000000
    ${today} =    Get Current Date    result_format=%Y%m%d
    ${tomorrow} =    Get Current Date    increment=1 days    result_format=%Y%m%d
    ${acquired} =    Get Current Date    increment=2 days    result_format=%m%d
    Set Test Variable    ${file_name}    TSBCON54387162${today}
    Set Test Variable    ${duplicate_file_name}    TSBCON6888115867639086
    Set Test Variable    ${content}    ${today}${tomorrow}${store_code}000000060${acquired}7111111 20680100168888
    Create File    ${file_name}    ${content}

Remove Local And SFTP File
    [Documentation]    Keyword for sshlibrary delete remote txt file and local run process remove txt file
    Execute Command    rm ${file_name}
    Remove File    ${CURDIR}/../../../${file_name}

Suite Setup
    ${auth} =    App Cipher Get    account=${null}
    Set Suite Variable    ${auth}

Generate ES Bill And Convenient Store File
    [Arguments]    ${flag}
    Payment Gateway Test Data Setup    1
    Create Convenient Store File    ${flag}
    Upload File To SFTP Server

Remove File And Close Connection
    Remove Local And SFTP File
    Close All Connections

Upload File To SFTP Server
    [Documentation]    Keyword to open sftp connection and put file
    Open Connection    ${PAYMENT_GATEWAY_SFTP_ADDRESS}
    Login    ${PAYMENT_GATEWAY_SFTP_ACCOUNT}    ${PAYMENT_GATEWAY_SFTP_PASSWORD}
    Put File    ${file_name}    /home/rootadmin