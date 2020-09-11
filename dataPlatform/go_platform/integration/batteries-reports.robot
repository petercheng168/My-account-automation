*** Settings ***
Documentation    Test suite of batteries/swap-logs
Resource    ../init.robot

Force Tags    Batteries    Reports
Test Setup    Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
batteries-reports - get - get batteries reports with battery_sn_list to query without create_time_from and create_time_to
    [Setup]    Test Setup
    ${resp} =     Batteries Reports Get    ${None}    ${BatteriesReport.battery_sn}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()["data"][0]["login_user"]}    ${BatteriesReport.login_user}
    Verify Response Contains Expected    ${resp.json()["data"][0]["battery_sn"]}    ${BatteriesReport.battery_sn}
    Verify Schema    batteries-reports.json    batteriesReportsGet    ${resp.json()}

batteries-reports - get - get batteries reports with create_time_to equal to response time
    [Setup]    Test Setup
    ${resp} =     Batteries Reports Get    ${BatteriesReport.login_user}    ${BatteriesReport.battery_sn}    ${0}    ${BatteriesReport.time}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()["data"][0]["login_user"]}    ${BatteriesReport.login_user}
    Verify Response Contains Expected    ${resp.json()["data"][0]["battery_sn"]}    ${BatteriesReport.battery_sn}
    Verify Schema    batteries-reports.json    batteriesReportsGet    ${resp.json()}

batteries-reports - get - get batteries reports with users to query without create_time_from and create_time_to
    [Setup]    Test Setup
    ${resp} =     Batteries Reports Get    ${BatteriesReport.login_user}    ${None}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()["data"][0]["login_user"]}    ${BatteriesReport.login_user}
    Verify Response Contains Expected    ${resp.json()["data"][0]["battery_sn"]}    ${BatteriesReport.battery_sn}
    Verify Schema    batteries-reports.json    batteriesReportsGet    ${resp.json()}

batteries-reports - get - get batteries reports without limit and order in pagination_criteria
    [Setup]    Test Setup
    ${resp} =     Batteries Reports Get    ${BatteriesReport.login_user}    ${BatteriesReport.battery_sn}    ${0}    ${current_timestamp}
    Verify Status Code As Expected    ${resp}    200
    Verify Response Contains Expected    ${resp.json()["data"][0]["login_user"]}    ${BatteriesReport.login_user}
    Verify Response Contains Expected    ${resp.json()["data"][0]["battery_sn"]}    ${BatteriesReport.battery_sn}
    Verify Schema    batteries-reports.json    batteriesReportsGet    ${resp.json()}

*** Keywords ***
Setup Test Variables
    ${battery_sn} =    Generate Random String    4    [STRINGS]
    ${login_user} =    Generate Random String    4    [STRINGS]
    ${expect_battery_sn} =    Generate Random String    8    [STRINGS]
    Set Test Variable    ${expect_battery_sn}
    Set Test Variable    ${BatteriesReport}    ${BatteriesReports('${battery_sn}', '${login_user}')}

Test Setup
    Setup Test Variables
    Batteries Reports Post    ${BatteriesReport.time}    ${BatteriesReport.login_user}    ${BatteriesReport.battery_sn}\
    ...    ${BatteriesReport.cmd_id}    ${BatteriesReport.cmd_val}    ${BatteriesReport.log_path}    ${BatteriesReport.description}
    ${current_timestamp} =    Evaluate    int(time.time())   time
    Set Test Variable    ${current_timestamp}