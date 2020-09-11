*** Settings ***
Documentation    API baseline of batteries

Variables       ../../../env.py
Variables       ${PROJECT_ROOT}/setting.py    dev
Library         ${GP_API_ROOT}/LibBatteries.py

Resource        ${DP_ROOT}/standard_library_init.robot

Resource        ${PROJECT_ROOT}/lib/keywords_common.robot
Resource        ${GP_KEYWORD_ROOT}/keywords_common.robot

Force Tags      Batteries
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
batteries - get - valid - get batteries with different guid on guid list
    ${guid_list} =    Create List    b8d2f2a6-885a-47f3-8c64-0756be05b48f    8f11d9fb-2d8f-4091-ae08-fbec25022763
    ${resp} =    Batteries Get    guid_list=${guid_list}
    Verify Status Code As Expected        ${resp}                                      200
    Verify Response Contains Expected     ${resp.json()['total_count']}	               2
    Verify Response Contains Expected     ${resp.json()['data'][0]['battery_guid']}    8f11d9fb-2d8f-4091-ae08-fbec25022763
    Verify Response Contains Expected     ${resp.json()['data'][1]['battery_guid']}    b8d2f2a6-885a-47f3-8c64-0756be05b48f

batteries - get - valid - get batteries with duplicated guid in guid_list
    ${guid_list} =    Create List    b8d2f2a6-885a-47f3-8c64-0756be05b48f    b8d2f2a6-885a-47f3-8c64-0756be05b48f
    ${resp} =    Batteries Get    guid_list=${guid_list}
    Verify Status Code As Expected        ${resp}                                      200
    Verify Response Contains Expected     ${resp.json()['total_count']}	               1
    Verify Response Contains Expected     ${resp.json()['data'][0]['battery_guid']}    b8d2f2a6-885a-47f3-8c64-0756be05b48f

batteries - get - valid - get batteries with guid list
    ${resp} =    Batteries Get    guid=b8d2f2a6-885a-47f3-8c64-0756be05b48f
    Verify Status Code As Expected        ${resp}                                      200
    Verify Response Contains Expected     ${resp.json()['total_count']}	               1
    Verify Response Contains Expected     ${resp.json()['data'][0]['battery_guid']}	   b8d2f2a6-885a-47f3-8c64-0756be05b48f

batteries - get - valid - get batteries with guid and guid_list should ignore guid_list
    ${guid_list} =    Create List    b8d2f2a6-885a-47f3-8c64-0756be05b48f
    ${resp} =    Batteries Get    guid=8f11d9fb-2d8f-4091-ae08-fbec25022763    guid_list=${guid_list}
    Verify Status Code As Expected        ${resp}                                      200
    Verify Response Contains Expected     ${resp.json()['total_count']}                1
    Verify Response Contains Expected     ${resp.json()['data'][0]['battery_guid']}    8f11d9fb-2d8f-4091-ae08-fbec25022763
