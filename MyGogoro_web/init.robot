*** Variable ***
${ENV}    pa

*** Settings ***
Variables         ../env.py
Variables         ../setting.py    ${ENV}
Variables         ./lib/MyGogoroObject.py

Library           BuiltIn
Library           Collections
Library           DateTime
Library           ImapLibrary
Library           OperatingSystem
Library           Process
Library           RequestsLibrary
Library           String
Library           XML
Library           Selenium2Library
Library           SeleniumScreenshots
Library           ../lib/LibAppCipher.py
Library           ../lib/LibMail.py



Resource          ../MyGogoro_web/lib/keyword_mggr_common.robot
Resource          ../MyGogoro_web/lib/keyword_mggr_login.robot
Resource          ../MyGogoro_web/lib/keyword_mggr_login_forgot_password.robot
Resource          ../MyGogoro_web/lib/keyword_mggr_myplan.robot
Resource          ../MyGogoro_web/lib/keyword_mggr_myprofile.robot
Resource          ../MyGogoro_web/lib/keyword_mggr_register.robot
# Resource          ../MyGogoro_web/lib/keyword_mggr_myprofile_update_email.robot
Resource          ../lib/keywords_common.robot
Resource          ../lib/keywords_app_cipher.robot
Resource          ../paymentGateway/lib/Keywords_common.robot

# Go_platform
Resource          ${GP_KEYWORD_ROOT}/keywords_es_plans.robot


# GP API Python Library
Resource          ${GP_ROOT}/gp_library_init.robot

Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_es_contracts_addons.robot
Resource          ${GP_KEYWORD_ROOT}/keywords_users.robot

Resource          ../lib/keywords_common.robot
Resource          ../lib/keywords_app_cipher.robot

# MGGR API Python Library
Resource          ./mggr_library_init.robot

# MGGR API Keywords Library
Resource          ./mggr_keywords_init.robot