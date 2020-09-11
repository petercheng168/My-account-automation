*** Settings ***
Documentation    Test suite for getting Billing engine status scenario
Resource    ../init.robot

Force Tags    BillingWeb   BillingEngine
Test Timeout    ${TEST_TIMEOUT}

*** Test Case ***
Get billing engine job status
    ${resp} =    Api Engine Job Status Get
    Verify Status Code As Expected    ${resp}    200
    Verify Schema    ../../../billingWeb/res/schema/api-engine-job-status.json    GetJobStatus    ${resp.json()}

*** Keywords ***