*** Settings ***
Documentation    API baseline of contract-user

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Variables		  ${GP_LIB_ROOT}/DataPlatformObject.py

Library			  ${GP_API_ROOT}/LibContractUsers.py

Resource          ${DP_ROOT}/standard_library_init.robot
Resource    	  ../init.robot

Resource          ${PROJECT_ROOT}/lib/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot
Resource		  ${GP_KEYWORD_ROOT}/keywords_users.robot

Force Tags      Contract-Users
Test Setup      Test Setup
# Suite Setup     Suite Setup
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${user_type}          3
${user_status}        1
${gender_business}    O
${257_string}         6yIWmiEvy8yCZFbwlXF2Bzi7opJ2bbBWWuy0tCgENjObiQ7lmklrAXa8eXMYJfap02Tli84JFZIzJmHL4mZ5QdpUjxikx1nXdVYetj5IdBis1CwnwzGUPYgBjTdIBVD3fxy1mHpOBMgL98FOtWL2cmQte4wOy0PsAvcgxrld7j7eJ1A86AyHLbptR7SvgOe0ytKLAICMI849WKUlWQl1eVsxnpiqrm0wRbFDBtRU9hykYDKciiJSsjc2Bw2HWbK5j
${31_string}          4CwRphdF3gyM1qkyFF8Yhm47PTPUbFH

*** Test Cases ***
contract-users - add - create contract user with required fields
    ${resp} =    Contract Users Post    name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}
    ...    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}
    ...    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}
    ...    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    ${get_resp} =    Contract Users Get    user_id=${resp.json()['data'][0]['user_id']}    request_data_type=${2}
    Verify Status Code As Expected       ${resp}                                     200
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['first_name']}     ${User.first_name}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['gender']}    ${User.gender}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['profile_id']}    ${User.profile_id}

contract-users - add - create contract user with required fields (Business Account)
    ${resp} =    Contract Users Post    name=${User.first_name}    last_name=${None}    user_type=${user_type}    gender=${gender_business}
    ...    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}
    ...    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}
    ...    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    ${get_resp} =    Contract Users Get    user_id=${resp.json()['data'][0]['user_id']}    request_data_type=${2}
    Verify Status Code As Expected       ${resp}                                     200
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['first_name']}     ${User.first_name}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['gender']}    ${gender_business}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['profile_id']}    ${User.profile_id}

contract-users - add - create contract user with correct fields
    ${resp} =    Contract Users Post    name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}
    ...    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}
    ...    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}
    ...    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    ...    invoice_address=${User.invoice_address}    invoice_district=${User.invoice_district}    invoice_city=${User.invoice_city}    invoice_zip=${User.invoice_zip}
    ${get_resp} =    Contract Users Get    user_id=${resp.json()['data'][0]['user_id']}    request_data_type=${2}
    Verify Status Code As Expected       ${resp}                                     200
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['first_name']}     ${User.first_name}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['gender']}    ${User.gender}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['profile_id']}    ${User.profile_id}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['contact_address']}    ${User.contact_address}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['invoice_address']}    ${User.invoice_address}

contract-users - add - create contract user with null required fields
    [Tags]    FET
    [Template]    Verify Contract Users Post With Invalid Fields
    402010006    [addData.name]]; default message [must not be null]            name=${None}               last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    last_name can not be null                                      name=${User.first_name}    last_name=${None}              user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.userType]]; default message [must not be null]        name=${User.first_name}    last_name=${User.last_name}    user_type=${None}         gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.gender]]; default message [must not be null]          name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${None}           birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.birthday]]; default message [must not be null]        name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${None}             email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.email]]; default message [must not be null]           name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${None}          country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.countryCode]]; default message [must not be null]     name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${None}                 mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.mobilePhone1]]; default message [must not be null]    name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${None}           profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.profileId]]; default message [must not be null]       name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${None}               status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.status]]; default message [must not be null]          name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${None}           contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    604040002    ERROR: contact_address cannot be null                          name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${None}                    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    604040002    ERROR: contact_district cannot be null                         name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${None}                     contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    604040002    ERROR: contact_city cannot be null                             name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${None}                 contact_zip=${User.contact_zip}
    604040002    ERROR: contact_zip cannot be null                              name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${None}

contract-users - add - create contract user with invalid required fields
    [Tags]    FET
    [Template]    Verify Contract Users Post With Invalid Fields
    402010006    [addData.userType],2]; default message [must be greater than or equal to 2]          name=${User.first_name}    last_name=${User.last_name}    user_type=${1}            gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.userType],4]; default message [must be less than or equal to 4]             name=${User.first_name}    last_name=${User.last_name}    user_type=${5}            gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    604040002    ERROR: invalid gender                                                                name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=A                 birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.countryCode],2,0]; default message [size must be between 0 and 2]           name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=TWA                     mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.status],0]; default message [must be greater than or equal to 0]            name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${-1}             contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    status value is invalid                                                              name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${2}              contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    status value is invalid                                                              name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${9}              contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.status],10]; default message [must be less than or equal to 10]             name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${11}             contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.contactAddress],256,0]; default message [size must be between 0 and 256]    name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${257_string}              contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.contactDistrict],30,0]; default message [size must be between 0 and 30]     name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${31_string}                contact_city=${User.contact_city}    contact_zip=${User.contact_zip}
    402010006    [addData.contactCity],30,0]; default message [size must be between 0 and 30]         name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${31_string}            contact_zip=${User.contact_zip}
    402010006    [addData.contactZip],30,0]; default message [size must be between 0 and 30]          name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${31_string}

contract-users - add - create contract user with invalid non-required fields
    [Tags]    FET
    [Template]    Verify Contract Users Post With Invalid Fields
    402010006    [addData.invoiceAddress],256,0]; default message [size must be between 0 and 256]    name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}    invoice_address=${257_string}              invoice_district=${User.invoice_district}    invoice_city=${User.invoice_city}    invoice_zip=${User.invoice_zip}
    402010006    [addData.invoiceDistrict],30,0]; default message [size must be between 0 and 30]     name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}    invoice_address=${User.invoice_address}    invoice_district=${31_string}                invoice_city=${User.invoice_city}    invoice_zip=${User.invoice_zip}
    402010006    [addData.invoiceCity],30,0]; default message [size must be between 0 and 30]         name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}    invoice_address=${User.invoice_address}    invoice_district=${User.invoice_district}    invoice_city=${31_string}            invoice_zip=${User.invoice_zip}
    402010006    [addData.invoiceZip],20,0]; default message [size must be between 0 and 20]          name=${User.first_name}    last_name=${User.last_name}    user_type=${user_type}    gender=${User.gender}    birthday=${User.birthday}    email=${User.email}    country_code=${User.country_code}    mobile_phone1=${User.mobile}    profile_id=${User.profile_id}    status=${user_status}    contact_address=${User.contact_address}    contact_district=${User.contact_district}    contact_city=${User.contact_city}    contact_zip=${User.contact_zip}    invoice_address=${User.invoice_address}    invoice_district=${User.invoice_district}    invoice_city=${User.invoice_city}    invoice_zip=${31_string}

contract-users - update - update contract user with required fields
    [Setup]    Contract Users Create Setup
    ${resp} =    Contract Users Update    user_id=${contract_user_id}    name=SWQA
    ${get_resp} =    Contract Users Get    user_id=${contract_user_id}
    Verify Status Code As Expected       ${resp}                                         200
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['first_name']}     SWQA

contract-users - update - update contract user with correct fields
    [Setup]    Contract Users Create Setup
    ${resp} =    Contract Users Update    user_id=${contract_user_id}    name=${new_name}    user_type=${None}    gender=F    country_code=US    profile_id=${profile_id}    invoice_address=${invoice_address}    invoice_district=${invoice_district}    invoice_city=${invoice_city}
    ${get_resp} =    Contract Users Get    user_id=${contract_user_id}    request_data_type=${2}
    Verify Status Code As Expected       ${resp}                                             200
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['first_name']}         ${new_name}
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['gender']}             F
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['country_code']}       US
    Verify Response Contains Expected    ${get_resp.json()['data'][0]['invoice_address']}    ${invoice_address}

contract-users - update - update contract user with null required fields
    [Tags]    FET
    [Setup]    Contract Users Create Setup
    ${resp} =    Contract Users Update    user_id=${None}
    Verify Status Code As Expected       ${resp}    200
    Verify GoPlatform Error Message      ${resp}    402010006    [updateData.userId]]; default message [must not be null]

contract-users - update - update contract user with invalid fields
    [Tags]    FET
    [Setup]    Contract Users Create Setup
    [Template]    Verify Contract Users Update With Invalid Fields
    402010006    [updateData.userType],2]; default message [must be greater than or equal to 2]          user_type=${1}
    402010006    [updateData.userType],4]; default message [must be less than or equal to 4]             user_type=${5}
    402010006    [updateData.gender],2,0]; default message [size must be between 0 and 2]                gender=${invalid_len_str_3}
    402010006    [updateData.countryCode],2,0]; default message [size must be between 0 and 2]           country_code=${invalid_len_str_3}
    402010006    [updateData.invoiceAddress],256,0]; default message [size must be between 0 and 256]    invoice_address=${invalid_len_str_257}
    402010006    [updateData.invoiceDistrict],30,0]; default message [size must be between 0 and 30]     invoice_district=${invalid_len_str_31}
    402010006    [updateData.invoiceCity],30,0]; default message [size must be between 0 and 30]         invoice_city=${invalid_len_str_31}

*** Keywords ***
Test Setup
    ${new_name} =           Generate SWQA Random String    4
    ${invoice_address} =    Generate SWQA Random String    15
    ${invoice_city} =       Generate SWQA Random String    3
    ${invoice_district} =   Generate SWQA Random String    3
    ${profile_id} =         Generate SWQA Random String    10
    ${invalid_len_str_3} =           Generate SWQA Random String    3
    ${invalid_len_str_257} =         Generate SWQA Random String    257
    ${invalid_len_str_31} =          Generate SWQA Random String    31
    Set Test Variable    ${new_name}
    Set Test Variable    ${invoice_address}
    Set Test Variable    ${invoice_city}
    Set Test Variable    ${invoice_district}
    Set Test Variable    ${profile_id}
    Set Test Variable    ${invalid_len_str_3}
    Set Test Variable    ${invalid_len_str_257}
    Set Test Variable    ${invalid_len_str_31}
    Set Test Variable    ${User}    ${Users()}

Contract Users Create Setup
    Test Setup
    ${contract_user_id} =    Create Contract User    ${User}
    Set Test Variable    ${contract_user_id}

Update Contract Users With Required Fields
    [Arguments]    ${user_id}=${contract_user_id}    &{fields}
    ${resp} =    Contract Users Update    ${user_id}    &{fields}
    Verify Status Code As Expected    ${resp}    200
    [Return]    ${resp}

Verify Contract Users Post With Invalid Fields
	[Arguments]    ${additional_code}    ${err_msg}    &{fields}
	${resp} =    Contract Users Post    &{fields}
	Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}

Verify Contract Users Update With Invalid Fields
	[Arguments]    ${additional_code}    ${err_msg}    &{fields}
	${resp} =    Update Contract Users With Required Fields    &{fields}
	Verify Status Code As Expected       ${resp}    200
	Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}