*** Settings ***
Documentation    Test suite of cosc contract users histories
Resource    ../init.robot

Force Tags    Cosc    Cosc-Contract-Users-Histories
Suite Setup    Setup Es Contract Variable
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
cosc-contract-users-histories - get - GSS - get contract user history
    [Setup]    Setup GSS Scooter
    ${resp} =    Cosc Contract Users Histories Get    2    ${contract_user_id}
    Verify Status Code As Expected                  ${resp}    200
    Verify Contract User Information As Expected    ${resp}    ${contract_user_id}    ${User}
    Verify Schema    contract-user.json    contractUsersHistories    ${resp.json()}

cosc-contract-users-histories - get - GSS - get contract user history after update
    [Setup]    Setup GSS Scooter
    Contract Users Update    ${contract_user_id}    ${new_name}    ${None}    F    US    profile_id=${profile_id}    invoice_address=${invoice_address}    invoice_district=${invoice_district}    invoice_city=${invoice_city}
    ${resp} =    Cosc Contract Users Histories Get    2    ${contract_user_id}
    Verify Status Code As Expected                  ${resp}    200
    Verify Contract User Information As Expected    ${resp}    ${contract_user_id}    ${User}    F    US    ${new_name}    ${profile_id}    ${invoice_address}    ${invoice_district}    ${invoice_city}
    Verify Schema    contract-user.json    contractUsersHistories    ${resp.json()}

cosc-contract-users-histories - get - GSS - get contract user history with update_time_from and update_time_to value are zero
    [Setup]    Setup GSS Scooter
    ${resp} =    Cosc Contract Users Histories Get    2    ${contract_user_id}    ${0}    ${0}
    Verify Status Code As Expected       ${resp}    200
    Verify Response Contains Expected    ${resp.json()['data']}    []

cosc-contract-users-histories - get - GDK - get contract user history
    [Setup]    Setup Yamaha Scooter
    ${resp} =    Cosc Contract Users Histories Get    2    ${contract_user_id}
    Verify Status Code As Expected                  ${resp}    200
    Verify Contract User Information As Expected    ${resp}    ${contract_user_id}    ${User}
    Verify Schema    contract-user.json    contractUsersHistories    ${resp.json()}

cosc-contract-users-histories - get - GDK - get contract user history after update
    [Setup]    Setup Yamaha Scooter
    Contract Users Update    ${contract_user_id}    ${new_name}    ${None}    F    US    profile_id=${profile_id}    invoice_address=${invoice_address}    invoice_district=${invoice_district}    invoice_city=${invoice_city}
    ${resp} =    Cosc Contract Users Histories Get    2    ${contract_user_id}
    Verify Status Code As Expected                  ${resp}    200
    Verify Contract User Information As Expected    ${resp}    ${contract_user_id}    ${User}    F    US    ${new_name}    ${profile_id}    ${invoice_address}    ${invoice_district}    ${invoice_city}
    Verify Schema    contract-user.json    contractUsersHistories    ${resp.json()}

cosc-contract-users-histories - get - GDK - get contract user history with update_time_from and update_time_to value are zero
    [Setup]    Setup Yamaha Scooter
    ${resp} =    Cosc Contract Users Histories Get    2    ${contract_user_id}    ${0}    ${0}
    Verify Status Code As Expected       ${resp}                   200
    Verify Response Contains Expected    ${resp.json()['data']}    []

*** Keywords ***
Setup Es Contract Variable
    ${es_plan_id} =    Get Latest Published Activate Es Plan Id
    Set Suite Variable    ${EsContract}    ${EsContracts('${es_plan_id}')}

Setup GSS Scooter
    Setup Update Variable
    Setup Test Object Variable    1500    AZ2
    ${User.user_id} =    Create User    ${User}
    ${Scooter.scooter_id} =    Create Scooters    ${Scooter}
    ${Order.order_id}    ${Order.owner_id} =    Create Order    VEH_SALE_CR    ${Order.order_no}    I    ${User.user_id}    30001
    ${EsContract.es_contract_id} =    Create Es Contracts    ${Order.order_id}    ${User.user_id}    1    ${Order.owner_id}    1    ${Order.owner_id}    ${EsContract.es_plan_id}    ${EsContract.start_date}    1    1    2
    Set Test Variable    ${contract_user_id}    ${Order.owner_id}

Setup Test Object Variable
    [Arguments]    ${brand_company_code}    ${model_code}
    ${order_number} =    Generate Random String    8    [NUMBERS]
    ${password} =    Encode Password Get    Gogoro123
    Set Test Variable    ${Order}    ${Orders('P0${order_number}')}
    Set Test Variable    ${Scooter}    ${Scooters('${brand_company_code}', '${model_code}')}
    Set Test Variable    ${User}    ${Users('${password.text}')}

Setup Update Variable
    ${new_name} =           Generate Random String    4     [STRINGS]
    ${invoice_address} =    Generate Random String    15    [STRINGS]
    ${invoice_city} =       Generate Random String    3     [STRINGS]
    ${invoice_district} =   Generate Random String    3     [STRINGS]
    ${profile_id} =         Generate Random String    10    [STRINGS]
    Set Test Variable    ${new_name}
    Set Test Variable    ${invoice_address}
    Set Test Variable    ${invoice_city}
    Set Test Variable    ${invoice_district}
    Set Test Variable    ${profile_id}

Setup Yamaha Scooter
    Setup Update Variable
    Setup Test Object Variable    B22318608    BUS
    ${User.user_id} =        Create User    ${User}
    ${contract_user_id} =    Create Contract User    ${User}
    ${scooter_id} =          Create Scooters    ${Scooter}
    ${Order.order_id}    ${Order.owner_id} =    Set Variable    ${None}    ${contract_user_id}
    ${EsContract.es_contract_id} =    Create Es Contracts    ${Order.order_id}    ${User.user_id}    1    ${Order.owner_id}    1    ${Order.owner_id}    ${EsContract.es_plan_id}    ${EsContract.start_date}    1    1    2
    Es Contracts Update Scooters    ${EsContract.es_contract_id}    ${EsContract.es_plan_id}    2    1    ${scooter_id}
    Set Test Variable     ${contract_user_id}    ${Order.owner_id}