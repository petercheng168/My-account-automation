*** Settings ***
Documentation    Test suite of cosc contract users histories   
Resource    ../init.robot

Force Tags    Cosc Cosc-Contract-Users-Histories
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
cosc-contract-users-histories - get - invalid - get cosc-contract-users-histories with invalid fields
    [Setup]    Setup Test Object Variable    1500    AZ2
    [Tags]    FET
    [Template]    Verify Cosc Contract Users Histories Post With Invalid Fields
    402010004    user ids, user pids and user emails can not all be empty    request_data_type=2    user_ids=[]
    402010006    must be greater than or equal to    request_data_type=0
    402010006    must be less than or equal to    request_data_type=3
    402010006    update_time_to can not be less than update_time_from    request_data_type=1    user_ids=${contract_user_id}   update_time_from=${1576663155}    update_time_to=${1576663153}    

*** Keywords ***
# -------- Setup Keywords --------
Setup Test Object Variable
    [Arguments]    ${brand_company_code}    ${model_code}
    ${password} =    Encode Password Get    Gogoro123
    Set Test Variable    ${User}    ${Users('${password.text}')}
    ${contract_user_id} =    Create Contract User    ${User}
    Set Test Variable    ${contract_user_id}

# -------- Verify Keywords --------
Verify Cosc Contract Users Histories Post With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =    Cosc Contract Users Histories Get    &{fields}
    Verify Status Code As Expected    ${resp}    200
    Verify GoPlatform Error Message    ${resp}    ${additional_code}    ${err_msg}





