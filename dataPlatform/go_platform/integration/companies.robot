*** Settings ***
Documentation    Test suite of company
Resource    ../init.robot

Force Tags    Companies
Test Setup    Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
companies - get - get companies via company_id
    [Setup]    Test Setup    ${1}
    ${resp} =    Companies Get
    ...    ${Company.company_id}    ${None}    ${None}
    ...    ${None}    ${None}    account=${CIPHER_SUPER_ACCOUNT}
    Verify Status Code As Expected     ${resp}                      200
    Verify Company Data As Expected    ${resp.json()["data"][0]}    ${Company}
    Verify Schema    company.json    companiesGet    ${resp.json()}

companies - update - update not activated companies via company_code
    [Setup]    Test Setup    ${0}
    ${resp} =    Companies Update    ${None}    ${Company.company_code}
    ...    ${expect_company_name}    ${expect_brand_name}
    ...    ${expect_address}    ${expect_zip_code}    ${expect_country_code}
    ...    ${expect_status}
    ${resp_get_company} =    Companies Get    ${Company.company_id}    ${None}    ${None}    ${None}    ${None}    account=${CIPHER_SUPER_ACCOUNT}
    Verify Status Code As Expected     ${resp}    200
    Verify Company Data As Expected    ${resp_get_company.json()["data"][0]}    ${Company}    ${expect_company_name}    ${expect_brand_name}
    ...    ${expect_address}    ${expect_zip_code}    ${expect_country_code}    ${expect_status}

companies - update - update not activated companies via company_id
    [Setup]    Test Setup    ${0}
    ${resp} =    Companies Update    ${Company.company_id}    ${None}    ${expect_company_name}    ${expect_brand_name}
    ...    ${expect_address}    ${expect_zip_code}    ${expect_country_code}    ${expect_status}
    ${resp_get_company} =    Companies Get    ${Company.company_id}    ${None}    ${None}    ${None}    ${None}    account=${CIPHER_SUPER_ACCOUNT}
    Verify Status Code As Expected     ${resp}    200
    Verify Company Data As Expected    ${resp_get_company.json()["data"][0]}    ${Company}    ${expect_company_name}    ${expect_brand_name}
    ...    ${expect_address}    ${expect_zip_code}    ${expect_country_code}    ${expect_status}

*** Keywords ***
Test Setup
    [Arguments]    ${status}
    ${expect_company_name} =    Generate Random String    8    [STRINGS]
    ${expect_brand_name} =      Generate Random String    8    [STRINGS]
    ${expect_address} =         Generate Random String    8    [STRINGS]
    ${expect_zip_code} =        Generate Random String    3    [NUMBERS]
    Set Test Variable    ${expect_company_name}
    Set Test Variable    ${expect_brand_name}
    Set Test Variable    ${expect_address}
    Set Test Variable    ${expect_zip_code}
    Set Test Variable    ${expect_country_code}    US
    Set Test Variable    ${expect_status}    ${1}
    Set Test Variable    ${Company}    ${Companies(${status})}
    ${Company.company_id} =    Create Companies    ${Company}
