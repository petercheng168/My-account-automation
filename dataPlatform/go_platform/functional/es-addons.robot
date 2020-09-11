*** Settings ***
Documentation    API baseline of es-addons

Variables         ../../../env.py
Variables         ${PROJECT_ROOT}/setting.py   dev
Library           ${GP_API_ROOT}/LibEsAddons.py

Resource          ${DP_ROOT}/standard_library_init.robot

Resource          ${PROJECT_ROOT}/lib/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot

Force Tags      Es-Addons
Suite Setup     Suite Setup
Test Setup      Test Setup
Test Timeout    ${TEST_TIMEOUT}

*** Test Cases ***
es-addon - add - invalid - create es_addon with invalid required fields
    [Tags]    FET
    [Template]   Verify Es Addons Create With Invalid Fields
    #   402010006    addon_name=${addon_name}  price=249  payment_frequency=1  other_price_type=1  other_price=0  country_code=TW  status=1  published=1  valid_time_from=${valid_time_from}  free_terms_type=1  free_terms=2  addon_type=2
    402010006  [addData[0].addonName],256,0]; default message [size must be between 0 and 256]      addon_name=${addon_name_257}  price=249  payment_frequency=1  other_price_type=1  other_price=0  country_code=TW  status=1  published=1  valid_time_from=${valid_time_from}  free_terms_type=1  free_terms=2  addon_type=2
    402010006  [addData[0].paymentFrequency],2]; default message [must be less than or equal to 2]  addon_name=${addon_name}      price=249  payment_frequency=3  other_price_type=1  other_price=0  country_code=TW  status=1  published=1  valid_time_from=${valid_time_from}  free_terms_type=1  free_terms=2  addon_type=2
    402010006  [addData[0].otherPriceType],1]; default message [must be less than or equal to 1]    addon_name=${addon_name}      price=249  payment_frequency=1  other_price_type=2  other_price=0  country_code=TW  status=1  published=1  valid_time_from=${valid_time_from}  free_terms_type=1  free_terms=2  addon_type=2
    402010006  [addData[0].status],1]; default message [must be less than or equal to 1]            addon_name=${addon_name}      price=249  payment_frequency=1  other_price_type=1  other_price=0  country_code=TW  status=2  published=1  valid_time_from=${valid_time_from}  free_terms_type=1  free_terms=2  addon_type=2
    402010006  [addData[0].published],1]; default message [must be less than or equal to 1]         addon_name=${addon_name}      price=249  payment_frequency=1  other_price_type=1  other_price=0  country_code=TW  status=1  published=2  valid_time_from=${valid_time_from}  free_terms_type=1  free_terms=2  addon_type=2
    402010006  [addData[0].freeTermsType],2]; default message [must be less than or equal to 2]     addon_name=${addon_name}      price=249  payment_frequency=1  other_price_type=1  other_price=0  country_code=TW  status=1  published=1  valid_time_from=${valid_time_from}  free_terms_type=3  free_terms=2  addon_type=2
    402010006  [addData[0].addonType],2]; default message [must be less than or equal to 2]         addon_name=${addon_name}      price=249  payment_frequency=1  other_price_type=1  other_price=0  country_code=TW  status=1  published=1  valid_time_from=${valid_time_from}  free_terms_type=1  free_terms=2  addon_type=3

es-addon - add - invalid - create es_addon with null required fields
    [Tags]    FET
    [Template]   Verify Es Addons Create With Invalid Fields
    402010006  [addData[0].addonName]]; default message [must not be null]]          addon_name=${None}        price=249      payment_frequency=1        other_price_type=1        other_price=0        country_code=TW       status=1        published=1        valid_time_from=${valid_time_from}  free_terms_type=1        free_terms=2        addon_type=2
    402010006  [addData[0].price]]; default message [must not be null]]              addon_name=${addon_name}  price=${None}  payment_frequency=1        other_price_type=1        other_price=0        country_code=TW       status=1        published=1        valid_time_from=${valid_time_from}  free_terms_type=1        free_terms=2        addon_type=2
    402010006  [addData[0].paymentFrequency]]; default message [must not be null]]   addon_name=${addon_name}  price=249      payment_frequency=${None}  other_price_type=1        other_price=0        country_code=TW       status=1        published=1        valid_time_from=${valid_time_from}  free_terms_type=1        free_terms=2        addon_type=2
    402010006  [addData[0].otherPriceType]]; default message [must not be null]]     addon_name=${addon_name}  price=249      payment_frequency=1        other_price_type=${None}  other_price=0        country_code=TW       status=1        published=1        valid_time_from=${valid_time_from}  free_terms_type=1        free_terms=2        addon_type=2
    402010006  [addData[0].otherPrice]]; default message [must not be null]]         addon_name=${addon_name}  price=249      payment_frequency=1        other_price_type=1        other_price=${None}  country_code=TW       status=1        published=1        valid_time_from=${valid_time_from}  free_terms_type=1        free_terms=2        addon_type=2
    402010006  [addData[0].countryCode]]; default message [must not be null]]        addon_name=${addon_name}  price=249      payment_frequency=1        other_price_type=1        other_price=0        country_code=${None}  status=1        published=1        valid_time_from=${valid_time_from}  free_terms_type=1        free_terms=2        addon_type=2
    402010006  [addData[0].status]]; default message [must not be null]]             addon_name=${addon_name}  price=249      payment_frequency=1        other_price_type=1        other_price=0        country_code=TW       status=${None}  published=1        valid_time_from=${valid_time_from}  free_terms_type=1        free_terms=2        addon_type=2
    402010006  [addData[0].published]]; default message [must not be null]]          addon_name=${addon_name}  price=249      payment_frequency=1        other_price_type=1        other_price=0        country_code=TW       status=1        published=${None}  valid_time_from=${valid_time_from}  free_terms_type=1        free_terms=2        addon_type=2
    402010006  [addData[0].validTimeFrom]]; default message [must not be null]]      addon_name=${addon_name}  price=249      payment_frequency=1        other_price_type=1        other_price=0        country_code=TW       status=1        published=1        valid_time_from=${None}             free_terms_type=1        free_terms=2        addon_type=2
    402010006  [addData[0].freeTermsType]]; default message [must not be null]]      addon_name=${addon_name}  price=249      payment_frequency=1        other_price_type=1        other_price=0        country_code=TW       status=1        published=1        valid_time_from=${valid_time_from}  free_terms_type=${None}  free_terms=2        addon_type=2
    402010006  [addData[0].freeTerms]]; default message [must not be null]]          addon_name=${addon_name}  price=249      payment_frequency=1        other_price_type=1        other_price=0        country_code=TW       status=1        published=1        valid_time_from=${valid_time_from}  free_terms_type=1        free_terms=${None}  addon_type=2
    402010006  [addData[0].addonType]]; default message [must not be null]]          addon_name=${addon_name}  price=249      payment_frequency=1        other_price_type=1        other_price=0        country_code=TW       status=1        published=1        valid_time_from=${valid_time_from}  free_terms_type=1        free_terms=2        addon_type=${None}

es-addon - add - valid - create es_addon with correct value
    ${resp} =  Es Addons Add
    ...  addon_name=${addon_name}   price=249       payment_frequency=1
    ...  other_price_type=1     other_price=0   country_code=TW
    ...  status=1               published=1     valid_time_from=${valid_time_from}
    ...  free_terms_type=1      free_terms=2    addon_type=2
    ...  addon_code=${addon_code}  valid_time_to=${valid_time_to}

    ${resp_get} =  Es Addons Get   addon_name=${addon_name}
    Verify Status Code As Expected        ${resp}    200
    Verify Status Code As Expected        ${resp_get}    200
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['addon_name']}	${addon_name}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['price']}	249.0
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['payment_frequency']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['other_price_type']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['other_price']}	0.0
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['country_code']}	TW
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['status']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['published']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['valid_time_from']}	${valid_time_from}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['free_terms_type']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['free_terms']}	2
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['addon_type']}	2
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['addon_code']}	${addon_code}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['valid_time_to']}	${valid_time_to}

es-addon - add - valid - create es_addon with required fields
    ${resp} =  Es Addons Add
    ...  addon_name=${addon_name}   price=249       payment_frequency=1
    ...  other_price_type=1     other_price=0   country_code=TW
    ...  status=1               published=1     valid_time_from=${valid_time_from}
    ...  free_terms_type=1      free_terms=2    addon_type=2

    ${resp_get} =  Es Addons Get   addon_name=${addon_name}
    Verify Status Code As Expected        ${resp}    200
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['addon_name']}	${addon_name}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['price']}	249.0
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['payment_frequency']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['other_price_type']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['other_price']}	0.0
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['country_code']}	TW
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['status']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['published']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['valid_time_from']}	${valid_time_from}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['free_terms_type']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['free_terms']}	2
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['addon_type']}	2

# Update

es-addon - update - invalid - update es_addon with invalid required fields
    [Tags]    FET
    [Template]   Verify Es Addons Update With Invalid Fields
    402010006  [updateData[0].addonName],256,0]; default message [size must be between 0 and 256]      addon_id=hashed_id  addon_name=${addon_name_257}  price=300  payment_frequency=2  other_price_type=1  other_price=20  country_code=JP  status=0  published=1  valid_time_from=123  free_terms_type=2  free_terms=3   addon_type=2
    402010006  [updateData[0].paymentFrequency],2]; default message [must be less than or equal to 2]  addon_id=hashed_id  addon_name=Name_Update        price=300  payment_frequency=3  other_price_type=1  other_price=20  country_code=JP  status=0  published=1  valid_time_from=123  free_terms_type=2  free_terms=3   addon_type=2
    402010006  [updateData[0].otherPriceType],1]; default message [must be less than or equal to 1]    addon_id=hashed_id  addon_name=Name_Update        price=300  payment_frequency=2  other_price_type=2  other_price=20  country_code=JP  status=0  published=1  valid_time_from=123  free_terms_type=2  free_terms=3   addon_type=2
    402010006  [must be greater than or equal to 0]                                                    addon_id=hashed_id  addon_name=Name_Update        price=300  payment_frequency=2  other_price_type=1  other_price=-1  country_code=JP  status=0  published=1  valid_time_from=123  free_terms_type=2  free_terms=3   addon_type=2
    402010006  [updateData[0].countryCode]]; default message [must not be null]                        addon_id=hashed_id  addon_name=Name_Update        price=300  payment_frequency=2  other_price_type=1  other_price=20  country_code=GE  status=0  published=1  valid_time_from=123  free_terms_type=2  free_terms=3   addon_type=2
    402010006  [updateData[0].status],1]; default message [must be less than or equal to 1]            addon_id=hashed_id  addon_name=Name_Update        price=300  payment_frequency=2  other_price_type=1  other_price=20  country_code=JP  status=2  published=1  valid_time_from=123  free_terms_type=2  free_terms=3   addon_type=2
    402010006  [updateData[0].published],1]; default message [must be less than or equal to 1]         addon_id=hashed_id  addon_name=Name_Update        price=300  payment_frequency=2  other_price_type=1  other_price=20  country_code=JP  status=0  published=2  valid_time_from=123  free_terms_type=2  free_terms=3   addon_type=2
    402010006  [updateData[0].validTimeFrom],0]; default message [must be greater than or equal to 0]  addon_id=hashed_id  addon_name=Name_Update        price=300  payment_frequency=2  other_price_type=1  other_price=20  country_code=JP  status=0  published=1  valid_time_from=-1   free_terms_type=2  free_terms=3   addon_type=2
    402010006  [updateData[0].freeTermsType],2]; default message [must be less than or equal to 2]     addon_id=hashed_id  addon_name=Name_Update        price=300  payment_frequency=2  other_price_type=1  other_price=20  country_code=JP  status=0  published=1  valid_time_from=123  free_terms_type=3  free_terms=3   addon_type=2
    402010006  [updateData[0].freeTerms],0]; default message [must be greater than or equal to 0]      addon_id=hashed_id  addon_name=Name_Update        price=300  payment_frequency=2  other_price_type=1  other_price=20  country_code=JP  status=0  published=1  valid_time_from=123  free_terms_type=2  free_terms=-1  addon_type=2
    402010006  [updateData[0].addonType],2]; default message [must be less than or equal to 2]         addon_id=hashed_id  addon_name=Name_Update        price=300  payment_frequency=2  other_price_type=1  other_price=20  country_code=JP  status=0  published=1  valid_time_from=123  free_terms_type=2  free_terms=3   addon_type=3


es-addon - update - invalid - update es_addon with null required fields
    [Tags]    FET
    [Template]   Verify Es Addons Update With Invalid Fields
#    402010006  addon_id=hashed_id  addon_name=Name_Update  price=300  payment_frequency=2  other_price_type=1  other_price=20  country_code=JP  status=0  published=1  valid_time_from=123  free_terms_type=2  free_terms=3  addon_type=2
    402010006  [updateData[0].addonId]]; default message [must not be null]           addon_id=${None}  addon_name=Name_Update  price=300      payment_frequency=2        other_price_type=1        other_price=20       country_code=JP       status=0        published=1        valid_time_from=123      free_terms_type=2        free_terms=3        addon_type=2
    402010006  [updateData[0].addonName]]; default message [must not be null]         addon_id=hashed_id  addon_name=${None}      price=300      payment_frequency=2        other_price_type=1        other_price=20       country_code=JP       status=0        published=1        valid_time_from=123      free_terms_type=2        free_terms=3        addon_type=2
    402010006  [updateData[0].price]]; default message [must not be null]             addon_id=hashed_id  addon_name=Name_Update  price=${None}  payment_frequency=2        other_price_type=1        other_price=20       country_code=JP       status=0        published=1        valid_time_from=123      free_terms_type=2        free_terms=3        addon_type=2
    402010006  [updateData[0].paymentFrequency]]; default message [must not be null]  addon_id=hashed_id  addon_name=Name_Update  price=300      payment_frequency=${None}  other_price_type=1        other_price=20       country_code=JP       status=0        published=1        valid_time_from=123      free_terms_type=2        free_terms=3        addon_type=2
    402010006  [updateData[0].otherPriceType]]; default message [must not be null]    addon_id=hashed_id  addon_name=Name_Update  price=300      payment_frequency=2        other_price_type=${None}  other_price=20       country_code=JP       status=0        published=1        valid_time_from=123      free_terms_type=2        free_terms=3        addon_type=2
    402010006  [updateData[0].otherPrice]]; default message [must not be null]        addon_id=hashed_id  addon_name=Name_Update  price=300      payment_frequency=2        other_price_type=1        other_price=${None}  country_code=JP       status=0        published=1        valid_time_from=123      free_terms_type=2        free_terms=3        addon_type=2
    402010006  [updateData[0].countryCode]]; default message [must not be null]       addon_id=hashed_id  addon_name=Name_Update  price=300      payment_frequency=2        other_price_type=1        other_price=20       country_code=${None}  status=0        published=1        valid_time_from=123      free_terms_type=2        free_terms=3        addon_type=2
    402010006  [updateData[0].status]]; default message [must not be null]            addon_id=hashed_id  addon_name=Name_Update  price=300      payment_frequency=2        other_price_type=1        other_price=20       country_code=JP       status=${None}  published=1        valid_time_from=123      free_terms_type=2        free_terms=3        addon_type=2
    402010006  [updateData[0].published]]; default message [must not be null]         addon_id=hashed_id  addon_name=Name_Update  price=300      payment_frequency=2        other_price_type=1        other_price=20       country_code=JP       status=0        published=${None}  valid_time_from=123      free_terms_type=2        free_terms=3        addon_type=2
    402010006  [updateData[0].validTimeFrom]]; default message [must not be null]     addon_id=hashed_id  addon_name=Name_Update  price=300      payment_frequency=2        other_price_type=1        other_price=20       country_code=JP       status=0        published=1        valid_time_from=${None}  free_terms_type=2        free_terms=3        addon_type=2
    402010006  [updateData[0].freeTermsType]]; default message [must not be null]     addon_id=hashed_id  addon_name=Name_Update  price=300      payment_frequency=2        other_price_type=1        other_price=20       country_code=JP       status=0        published=1        valid_time_from=123      free_terms_type=${None}  free_terms=3        addon_type=2
    402010006  [updateData[0].freeTerms]]; default message [must not be null]         addon_id=hashed_id  addon_name=Name_Update  price=300      payment_frequency=2        other_price_type=1        other_price=20       country_code=JP       status=0        published=1        valid_time_from=123      free_terms_type=2        free_terms=${None}  addon_type=2
    402010006  [updateData[0].addonType]]; default message [must not be null]         addon_id=hashed_id  addon_name=Name_Update  price=300      payment_frequency=2        other_price_type=1        other_price=20       country_code=JP       status=0        published=1        valid_time_from=123      free_terms_type=2        free_terms=3        addon_type=${None}

es-addon - update - valid - update es_addon with correct value
    ${resp_create} =  Es Addons Add
    ...  addon_name=${addon_name}   price=249       payment_frequency=1
    ...  other_price_type=1     other_price=0   country_code=TW
    ...  status=1               published=0     valid_time_from=${valid_time_from}
    ...  free_terms_type=1      free_terms=2    addon_type=1

    ${resp_update} =  Es Addons Update
    ...  addon_id=${resp_create.json()['data'][0]['addon_id']}  addon_name=Name_Update  price=300
    ...  payment_frequency=2  other_price_type=1  other_price=20
    ...  country_code=JP  status=0  published=1
    ...  valid_time_from=123  free_terms_type=2  free_terms=3
    ...  addon_type=2  addon_code=${addon_code}  valid_time_to=456

    ${resp_get} =  Es Addons Get   addon_id=${resp_create.json()['data'][0]['addon_id']}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['addon_name']}	Name_Update
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['price']}	300.0
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['payment_frequency']}  2
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['other_price_type']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['other_price']}	20.0
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['country_code']}	JP
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['status']}	0
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['published']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['valid_time_from']}	123
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['free_terms_type']}	2
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['free_terms']}	3
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['addon_type']}	2
    ## Optional Field
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['addon_code']}	${addon_code}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['valid_time_to']}	456

es-addon - update - valid - update es_addon with required fields
    ${resp_create} =  Es Addons Add
    ...  addon_name=${addon_name}   price=249       payment_frequency=1
    ...  other_price_type=1     other_price=0   country_code=TW
    ...  status=1               published=0     valid_time_from=${valid_time_from}
    ...  free_terms_type=1      free_terms=2    addon_type=1

    ${resp_update} =  Es Addons Update
    ...  addon_id=${resp_create.json()['data'][0]['addon_id']}  addon_name=Name_Update  price=300
    ...  payment_frequency=2  other_price_type=1  other_price=20
    ...  country_code=JP  status=0  published=1
    ...  valid_time_from=123  free_terms_type=2  free_terms=3
    ...  addon_type=2

    ${resp_get} =  Es Addons Get   addon_id=${resp_create.json()['data'][0]['addon_id']}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['addon_name']}	Name_Update
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['price']}	300.0
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['payment_frequency']}  2
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['other_price_type']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['other_price']}	20.0
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['country_code']}	JP
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['status']}	0
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['published']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['valid_time_from']}	123
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['free_terms_type']}	2
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['free_terms']}	3
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['addon_type']}	2

# Get
es-addon - get - valid - get es_addon with correct value
    ${resp_create} =  Es Addons Add
    ...  addon_name=${addon_name}   price=249       payment_frequency=1
    ...  other_price_type=1     other_price=20.0   country_code=TW
    ...  status=1               published=1     valid_time_from=2556147691
    ...  free_terms_type=1      free_terms=2    addon_type=2
    ...  addon_code=${addon_code}  valid_time_to=2556147692

    ${resp_get_by_id} =  Es Addons Get   addon_id=${resp_create.json()['data'][0]['addon_id']}

    Verify Response Data Length Expected  ${resp_get_by_id.json()['data']}   1
    Verify Response Contains Expected     ${resp_get_by_id.json()['data'][0]['addon_name']}   ${addon_name}
    Verify Response Contains Expected     ${resp_get_by_id.json()['data'][0]['price']}   249.0
    Verify Response Contains Expected     ${resp_get_by_id.json()['data'][0]['payment_frequency']}   1
    Verify Response Contains Expected     ${resp_get_by_id.json()['data'][0]['other_price_type']}   1
    Verify Response Contains Expected     ${resp_get_by_id.json()['data'][0]['other_price']}   20.0
    Verify Response Contains Expected     ${resp_get_by_id.json()['data'][0]['country_code']}   TW
    Verify Response Contains Expected     ${resp_get_by_id.json()['data'][0]['status']}   1
    Verify Response Contains Expected     ${resp_get_by_id.json()['data'][0]['published']}   1
    Verify Response Contains Expected     ${resp_get_by_id.json()['data'][0]['valid_time_from']}   2556147691
    Verify Response Contains Expected     ${resp_get_by_id.json()['data'][0]['free_terms_type']}   1
    Verify Response Contains Expected     ${resp_get_by_id.json()['data'][0]['free_terms']}   2
    Verify Response Contains Expected     ${resp_get_by_id.json()['data'][0]['addon_type']}   2
    Verify Response Contains Expected     ${resp_get_by_id.json()['data'][0]['addon_code']}	  ${addon_code}
    Verify Response Contains Expected     ${resp_get_by_id.json()['data'][0]['valid_time_to']}   2556147692

    # TODO
#    ${resp_get_succeed} =  Es Addons Get   valid_time_from=2556147691   valid_time_to=2556147692   published=1   status=1
#
#    Verify Response Data Length Expected  ${resp_get_succeed.json()['data']}   1
#    Verify Response Contains Expected     ${resp_get_succeed.json()['data'][0]['addon_name']}   ${addon_name}
#    Verify Response Contains Expected     ${resp_get_succeed.json()['data'][0]['price']}   249.0
#    Verify Response Contains Expected     ${resp_get_succeed.json()['data'][0]['payment_frequency']}   1
#    Verify Response Contains Expected     ${resp_get_succeed.json()['data'][0]['other_price_type']}   1
#    Verify Response Contains Expected     ${resp_get_succeed.json()['data'][0]['other_price']}   20.0
#    Verify Response Contains Expected     ${resp_get_succeed.json()['data'][0]['country_code']}   TW
#    Verify Response Contains Expected     ${resp_get_succeed.json()['data'][0]['status']}   1
#    Verify Response Contains Expected     ${resp_get_succeed.json()['data'][0]['published']}   1
#    Verify Response Contains Expected     ${resp_get_succeed.json()['data'][0]['valid_time_from']}   2556147691
#    Verify Response Contains Expected     ${resp_get_succeed.json()['data'][0]['free_terms_type']}   1
#    Verify Response Contains Expected     ${resp_get_succeed.json()['data'][0]['free_terms']}   2
#    Verify Response Contains Expected     ${resp_get_succeed.json()['data'][0]['addon_type']}   2
#    Verify Response Contains Expected     ${resp_get_succeed.json()['data'][0]['addon_code']}       ${addon_code}
#    Verify Response Contains Expected     ${resp_get_succeed.json()['data'][0]['valid_time_to']}   2556147692

*** Keywords ***
Suite Setup
    ${addon_name_257} =     Generate Random String    257    [UPPER]
    Set Suite Variable    ${addon_name_257}

Test Setup
    ${addon_code} =     Generate Random String    10    [UPPER][NUMBERS]
    ${addon_name} =     Generate Random String    10    [UPPER]
    ${valid_time_from} =    Evaluate    int(time.time())   time
    ${valid_time_to} =   Evaluate    int(time.time() + 8400)    time

    Set Test Variable    ${addon_code}
    Set Test Variable    ${addon_name}
    Set Test Variable    ${valid_time_from}
    Set Test Variable    ${valid_time_to}

Verify Es Addons Create With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =   Es Addons Add   &{fields}
    Verify Status Code As Expected       ${resp}    200
    Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}

Verify Es Addons Create With Valid Fields
    [Arguments]    &{fields}
    ${resp} =  Es Addons Add
    ...  addon_name=${addon_name}   price=249       payment_frequency=1
    ...  other_price_type=1     other_price=0   country_code=TW
    ...  status=1               published=1     valid_time_from=${valid_time_from}
    ...  free_terms_type=1      free_terms=2    addon_type=2
    ...  &{fields}

    ${resp_get} =  Es Addons Get   addon_name=${addon_name}
    Verify Status Code As Expected        ${resp}    200
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['addon_name']}	${addon_name}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['price']}	249.0
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['payment_frequency']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['other_price_type']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['other_price']}	0.0
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['country_code']}	TW
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['status']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['published']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['valid_time_from']}	${valid_time_from}
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['free_terms_type']}	1
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['free_terms']}	2
    Verify Response Contains Expected     ${resp_get.json()['data'][0]['addon_type']}	2

Verify Es Addons Update With Invalid Fields
    [Arguments]    ${additional_code}    ${err_msg}    &{fields}
    ${resp} =   Es Addons Update   &{fields}
    Verify Status Code As Expected       ${resp}    200
    Verify GoPlatform Error Message      ${resp}    ${additional_code}    ${err_msg}