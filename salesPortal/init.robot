*** Variable ***
${ENV}    pa

*** Settings ***
Variables         ../env.py
Variables         ../setting.py    ${ENV}
Variables         ../setting_sales.py    ${ENV}

Library           BuiltIn
Library           Collections
Library           DateTime
Library           ImapLibrary
Library           OperatingSystem
Library           SeleniumLibrary    screenshot_root_directory=./path
Library           String

# GP API Python Library
Resource          ${GP_ROOT}/gp_library_init.robot

Library           ../dms/lib/LibScooterOutbound.py
Library           ../dms/lib/LibStoreAgreementSign.py
Library           ../lib/LibMail.py
Library           ../lib/LibPerformanceTime.py

Resource          ${GP_KEYWORD_ROOT}/keywords_company_employees.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_departments.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_es_contracts.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_es_plans.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_orders.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_promotions.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_scooters.robot
Resource          ../lib/keywords_common.robot

# SP Keyword Library
Resource          ./sp_keywords_init.robot
