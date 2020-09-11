*** Variable ***
${ENV}    dev

*** Settings ***
Variables         ../env.py
Variables         ../setting.py    ${ENV}

Library           BuiltIn
Library           Collections
Library           DateTime
Library           ImapLibrary
Library           OperatingSystem
Library           Process
Library           RequestsLibrary
Library           String
Library           XML
Library           ${GP_LIB_ROOT}/LibJSONSchema.py
Library           ./lib/LibApiEngineJobStatus.py
Library           ./lib/LibAuth.py

Resource          ${GP_KEYWORD_ROOT}/keywords_common.robot
