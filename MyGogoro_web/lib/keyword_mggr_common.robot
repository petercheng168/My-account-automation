*** Keywords ***

# -------- Verify Element --------
Check element is Visible
    [Documentation]    Check element is Visible form dashboard
    # ${Draft contract card} =    Set Variable     You still have an incomplete Service subscription, please continue to complete the subscription
    # Run Keyword If      ${Draft contract card} == 'true'
    # ELSE              log


    Assign Id To Element    //*[@id="app"]/div[2]/div/div[2]       PlanCard
    Assign Id To Element    //*[@id="app"]/div[2]/div/div[3]      Bill_typeCard
    Assign Id To Element    //*[@id="app"]/div[2]/aside     SideMenu
    Wait Until Element Is Visible  PlanCard   timeout=50
    Wait Until Element Is Visible  Bill_typeCard   timeout=50
    Wait Until Element Is Visible  SideMenu   timeout=50

    