*** Settings ***
Documentation    Test suite of es-plans
Resource    ../init.robot

Force Tags    Es-Contracts    Es-Plans
Suite Setup    SuiteSetup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
Get all es plans
    ${resp} =    Es Plans Get    status=1    published=1    valid_time_from=0    valid_time_to=${timestamp}
    Verify Status Code As Expected    ${resp}    200
    Verify Schema    es-plans.json    esPlansGet    ${resp.json()}

*** Keywords ***
SuiteSetup
    ${timestamp} =    Evaluate    int(time.time())   time
    Set Suite Variable    ${timestamp}