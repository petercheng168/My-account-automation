*** Settings ***
Documentation    API baseline / integration of /endpoint

Variables       ../../../env.py
Variables       ${PROJECT_ROOT}/setting.py   dev
Variables       ${GP_LIB_ROOT}/DataPlatformObject.py

Library         ${GP_LIB_ROOT}/LibCommon.py
Library         ${GP_API_ROOT}/LibUsers.py

Resource        ${DP_ROOT}/standard_library_init.robot
Resource        ${PROJECT_ROOT}/lib/keywords_common.robot
Resource        ${GP_KEYWORD_ROOT}/keywords_common.robot

Force Tags      Users
Suite Setup
Test Setup      Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***

*** Test Cases ***
users - add - add users with required fields
    ${resp} =    Users Post
    ...    company_code=${User.company_code}    first_name=${User.first_name}
    ...    gender=${User.gender}
    ...    email=${User.email}
    ...    status=${User.status}
    ...    enable_e_carrier=1
    ...    gogoro_guid=${User.gogoro_guid}
    Verify Status Code As Expected                   ${resp}    200
    Verify Response Json Data Should Contains Key    ${resp}    user_id

users - add - add users with correct fields
    ${resp} =    Users Post
    ...    ${User.company_code}    ${User.first_name}    ${User.gender}
    ...    ${User.email}           ${User.status}
    ...    ${User.enable_e_carrier}
    ...    invoice_address=${User.invoice_address}
    ...    invoice_district=${User.invoice_district}
    ...    invoice_city=${User.invoice_city}
    ...    gogoro_guid=${User.gogoro_guid}
    ...    profile_id=${User.profile_id}
    ...    password=${User.encode_password}
    Verify Status Code As Expected                   ${resp}    200
    Verify Response Json Data Should Contains Key    ${resp}    user_id

users - add - add users with null required fields
    [Tags]    FET
    [Template]    Verify Es Plan Post With Invalid Fields
    402010006    firstName]]; default message [must not be null         first_name=${None}
    402010006    gender]]; default message [must not be null]           gender=${None}
    402010006    email]]; default message [must not be null             email=${None}
    402010006    status]]; default message [must not be null            status=${None}
    402010006    enableECarrier]]; default message [must not be null    enable_e_carrier=${None}
    604040002    Gogoro GUID cannot be NULL.                            gogoro_guid=${None}

users - add - add users with invalid required fields
    [Tags]    FET
    [Template]    Verify Es Plan Post With Invalid Fields
    402010006    size must be between 0 and 40                   first_name=${invalid_len_str_41}
    402010006    gender]]; default message [must not be null]    gender=A
    402010006    gender]]; default message [must not be null]    gender=1
    402010006    size must be between 0 and 256                  email=${invalid_len_str_257}
    402010006    must be greater than or equal to 0              status=-1
    402010006    must be less than or equal to 1                 status=2
    402010006    must be greater than or equal to 0              enable_e_carrier=-1
    402010006    must be less than or equal to 1                 enable_e_carrier=2

users - add - add users with invalid non required fields
    [Tags]    FET
    [Template]    Verify Es Plan Post With Invalid Fields
    402010006    companyCode],20,0]; default message [size must be between 0 and 20         company_code=${invalid_len_str_21}
    402010006    lastName],30,0]; default message [size must be between 0 and 30            last_name=${invalid_len_str_31}
    402010006    nickName],50,0]; default message [size must be between 0 and 50            nick_name=${invalid_len_str_51}
    402010006    [must match "([12]\\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\\d|3[01]))"          birthday=1234
    402010006    contactAddress],256,0]; default message [size must be between 0 and 256    contact_address=${invalid_len_str_257}
    402010006    invoiceAddress],256,0]; default message [size must be between 0 and 256    invoice_address=${invalid_len_str_257}
    402010006    invoiceDistrict],30,0]; default message [size must be between 0 and 30     invoice_district=${invalid_len_str_31}
    402010006    invoiceCity],30,0]; default message [size must be between 0 and 30         invoice_city=${invalid_len_str_31}
    402010006    invoiceZip],20,0]; default message [size must be between 0 and 20          invoice_zip=${invalid_len_str_21}
    402010006    countryCode]]; default message [invalid country_code                       country_code=ABCD
    402010006    countryCode]]; default message [invalid country_code                       country_code=-1
    402010006    mobilePhone1],24,0]; default message [size must be between 0 and 24        mobile_phone1=${invalid_len_str_25}
    402010006    mobilePhone2],24,0]; default message [size must be between 0 and 24        mobile_phone2=${invalid_len_str_25}
    402010006    homePhone1],24,0]; default message [size must be between 0 and 24          home_phone1=${invalid_len_str_25}
    402010006    homePhone2],24,0]; default message [size must be between 0 and 24          home_phone2=${invalid_len_str_25}
    402010006    password],148,1]; default message [size must be between 1 and 148          password=${invalid_len_str_149}
    402010006    occupation],40,0]; default message [size must be between 0 and 40          occupation=${invalid_len_str_41}
    402010006    eulaStatus],1]; default message [must be less than or equal to 1           eula_status=2
    402010006    unit must be in 1 2                                                        unit=-1
    402010006    unit must be in 1 2                                                        unit=3

*** Keywords ***
# --------  Suite Setup    --------
# --------  Test Setup     --------
Test Setup
    Setup User Object
    ${invalid_len_str_21} =     Generate SWQA Random String    21
    ${invalid_len_str_25} =     Generate SWQA Random String    25
    ${invalid_len_str_31} =     Generate SWQA Random String    31
    ${invalid_len_str_41} =     Generate SWQA Random String    41
    ${invalid_len_str_51} =     Generate SWQA Random String    51
    ${invalid_len_str_149} =    Generate SWQA Random String    149
    ${invalid_len_str_257} =    Generate SWQA Random String    257
    Set Test Variable    ${invalid_len_str_21}
    Set Test Variable    ${invalid_len_str_25}
    Set Test Variable    ${invalid_len_str_31}
    Set Test Variable    ${invalid_len_str_41}
    Set Test Variable    ${invalid_len_str_51}
    Set Test Variable    ${invalid_len_str_149}
    Set Test Variable    ${invalid_len_str_257}

# -------- Setup  Keywords --------
Setup User Object
    Set Test Variable    ${User}    ${Users()}

# -------- Gogoro Keywords --------
Create User With Required Fields
    [Arguments]    ${company_code}=${User.company_code}    ${first_name}=${User.first_name}
    ...            ${gender}=${User.gender}                ${email}=${User.email}
    ...            ${status}=${User.status}                ${enable_e_carrier}=1
    ...            ${gogoro_guid}=${User.gogoro_guid}      &{fields}
    ${resp} =    Users Post
    ...    company_code=${company_code}    first_name=${first_name}
    ...    gender=${gender}                email=${email}
    ...    status=${status}                enable_e_carrier=${enable_e_carrier}
    ...    gogoro_guid=${gogoro_guid}      &{fields}
    Verify Status Code As Expected    ${resp}    200
    [Return]    ${resp}

# -------- Verify Keywords --------
Verify Es Plan Post With Invalid Fields
	[Arguments]    ${additional_code}    ${err_msg}    &{fields}
	${resp} =    Create User With Required Fields    &{fields}
	Verify GoPlatform Error Message     ${resp}    ${additional_code}    ${err_msg}