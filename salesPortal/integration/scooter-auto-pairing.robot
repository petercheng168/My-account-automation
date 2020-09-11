*** Settings ***
Documentation    Test suite of scooter auto pairing system
Resource    ../init.robot
Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${PAIRING_GROUP_ADMIN}    QA00006
${PAIRING_GROUP_PASS}     Temp4321

*** Test Cases ***
Get all scooter pairing result
    [Tags]    CID:9941
    ${resp} =    Get All Scooter Pairing Result
    ...    start_date=2020-03-16    end_date=${current_date}
    ...    company_id=ygR0XRGd    pairing_id=${None}
    ...    offset=0    limit=20    token=${token}
    Verify All Scooter Pairing Response    ${resp}
    Verify Schema    scooter-auto-pairing.json    GetAllScooterPairingResult    ${resp}

Get scooter pairing result by company_id
    [Tags]    CID:9942
    ${resp} =    Get Scooter Pairing Result Detail
    ...    dms_order_no=${None}    start_date=2020-03-16    end_date=${current_date}
    ...    company_id=ygR0XRGd    department_id=${None}
    ...    allocation_failure_reason=${None}    offset=0    limit=20
    ...    token=${token}
    Verify Scooter Pairing Response By Company    ${resp}
    Verify Schema    scooter-auto-pairing.json    GetScooterPairingResultByCompanyId    ${resp}

*** Keywords ***
Suite Setup
    ${get_token} =    Get SP Token    ${SALES_ACCOUNT}    ${SALES_PASSWORD}
    ${date} =    Evaluate    time.strftime("%Y-%m-%d")    time
    Set Suite Variable    ${token}    ${get_token}
    Set Suite Variable    ${current_date}    ${date}
    Login With Direct Login    ${PAIRING_GROUP_ADMIN}    ${PAIRING_GROUP_PASS}

Test Setup
    Click First Layer Item In Menu    /allocations
    Click Second Layer Item In Menu    /allocations/reservations
    Verify Page URL    ${SALES_PORTAL_URL}/allocations/reservations
