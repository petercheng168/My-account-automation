*** Keywords ***
# -------- Gogoro Keywords --------
Set Firmware ID
    ${param11} =    Create Dictionary    category=Firmware ID    key=ECU                value=N/A
    ${param12} =    Create Dictionary    category=Firmware ID    key=MCU                value=N/A
    ${param13} =    Create Dictionary    category=Firmware ID    key=LCD                value=N/A
    ${param14} =    Create Dictionary    category=Firmware ID    key=LCD_PATTERN        value=N/A
    ${param15} =    Create Dictionary    category=Firmware ID    key=BT2540             value=N/A
    ${param16} =    Create Dictionary    category=Firmware ID    key=BT2564             value=N/A
    ${param17} =    Create Dictionary    category=Firmware ID    key=ECU_NORDIC         value=N/A
    ${param18} =    Create Dictionary    category=Firmware ID    key=TOUCHPAD           value=N/A
    ${param19} =    Create Dictionary    category=Firmware ID    key=ON_BOARD_CHARGE    value=N/A
    ${params_firmware_id} =    Create List    ${param11}  ${param12}  ${param13}  ${param14}  ${param15}  ${param16}  ${param17}  ${param18}  ${param19}
    Set Test Variable    ${params_firmware_id}

Set Initial Shipping Firmware Ver for GDS
    ${param21} =    Create Dictionary    category=Initial Shipping Firmware Ver for GDS    key=BT2540          value=N/A
    ${param22} =    Create Dictionary    category=Initial Shipping Firmware Ver for GDS    key=BT2564          value=N/A
    ${param23} =    Create Dictionary    category=Initial Shipping Firmware Ver for GDS    key=ECU_Recovery    value=N/A
    ${param24} =    Create Dictionary    category=Initial Shipping Firmware Ver for GDS    key=ECU_Offical     value=N/A
    ${param25} =    Create Dictionary    category=Initial Shipping Firmware Ver for GDS    key=KEYFOB          value=N/A
    ${param26} =    Create Dictionary    category=Initial Shipping Firmware Ver for GDS    key=MCU             value=N/A
    ${param27} =    Create Dictionary    category=Initial Shipping Firmware Ver for GDS    key=MCU_PARAM       value=N/A
    ${param28} =    Create Dictionary    category=Initial Shipping Firmware Ver for GDS    key=ECU_NORDIC      value=N/A
    ${param29} =    Create Dictionary    category=Initial Shipping Firmware Ver for GDS    key=LCD             value=N/A
    ${param2A} =    Create Dictionary    category=Initial Shipping Firmware Ver for GDS    key=LCD_PATTERN     value=N/A
    ${params_initial_shipping_firmware_ver_for_GDS} =    Create List    ${param21}  ${param22}  ${param23}  ${param24}  ${param25}  ${param26}  ${param27}  ${param28}  ${param29}  ${param2A}
    Set Test Variable    ${params_initial_shipping_firmware_ver_for_GDS}

Set Front Lights threshold values
    ${param31} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsAssist_LowerBound        value=N/A
    ${param32} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsAssist_UpperBound        value=N/A
    ${param33} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsDayRun_LowerBound        value=N/A
    ${param34} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsDayRun_UpperBound        value=N/A
    ${param35} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsHighBeam0_LowerBound     value=N/A
    ${param36} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsHighBeam0_UpperBound     value=N/A
    ${param37} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsHighBeam1_LowerBound     value=N/A
    ${param38} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsHighBeam1_UpperBound     value=N/A
    ${param39} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsLeftWinker_LowerBound    value=N/A
    ${param3A} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsLeftWinker_UpperBound    value=N/A
    ${param3B} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsLowBeam0_LowerBound      value=N/A
    ${param3C} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsLowBeam0_UpperBound      value=N/A
    ${param3D} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsLowBeam1_LowerBound      value=N/A
    ${param3E} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsLowBeam1_UpperBound      value=N/A
    ${param3F} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsRightWinker_LowerBound   value=N/A
    ${param3G} =    Create Dictionary    category=Front Lights threshold values    key=LightCalibrationParams_FrontLightsRightWinker_UpperBound   value=N/A
    ${params_front_lights_threshold_values} =    Create List    ${param31}  ${param32}  ${param33}  ${param34}  ${param35}  ${param36}  ${param37}  ${param38}  ${param39}  ${param3A} 
                                                         ...    ${param3B}  ${param3C}  ${param3D}  ${param3E}  ${param3F}  ${param3G}
    Set Test Variable    ${params_front_lights_threshold_values}

Set Tail Lights threshold values
    ${param41} =     Create Dictionary    category=Tail Lights threshold values    key=LightCalibrationParams_TailLightsBottomBrake_LowerBound     value=N/A  
    ${param42} =     Create Dictionary    category=Tail Lights threshold values    key=LightCalibrationParams_TailLightsBottomBrake_UpperBound     value=N/A  
    ${param43} =     Create Dictionary    category=Tail Lights threshold values    key=LightCalibrationParams_TailLightsBrake_LowerBound           value=N/A 
    ${param44} =     Create Dictionary    category=Tail Lights threshold values    key=LightCalibrationParams_TailLightsBrake_UpperBound           value=N/A 
    ${param45} =     Create Dictionary    category=Tail Lights threshold values    key=LightCalibrationParams_TailLightsDayRun_LowerBound          value=N/A
    ${param46} =     Create Dictionary    category=Tail Lights threshold values    key=LightCalibrationParams_TailLightsDayRun_UpperBound          value=N/A 
    ${param47} =     Create Dictionary    category=Tail Lights threshold values    key=LightCalibrationParams_TailLightsID_LowerBound              value=N/A 
    ${param48} =     Create Dictionary    category=Tail Lights threshold values    key=LightCalibrationParams_TailLightsID_UpperBound              value=N/A  
    ${param49} =     Create Dictionary    category=Tail Lights threshold values    key=LightCalibrationParams_TailLightsLeftWinker_LowerBound      value=N/A  
    ${param4A} =     Create Dictionary    category=Tail Lights threshold values    key=LightCalibrationParams_TailLightsLeftWinker_UpperBound      value=N/A  
    ${param4B} =     Create Dictionary    category=Tail Lights threshold values    key=LightCalibrationParams_TailLightsRightWinker_LowerBound     value=N/A    
    ${param4C} =     Create Dictionary    category=Tail Lights threshold values    key=LightCalibrationParams_TailLightsRightWinker_UpperBound     value=N/A
    ${params_tail_lights_threshold_values} =    Create List    ${param41}  ${param42}  ${param43}  ${param44}  ${param45}  ${param46}  ${param47}  ${param48}  ${param49}  ${param4A}
                                                        ...    ${param4B}  ${param4C}
    Set Test Variable    ${params_tail_lights_threshold_values}

Set Throttle threshold values
    # for BX, PX, FX
    ${param51} =     Create Dictionary    category=Throttle threshold values    key=ThrottleCalibrationParams_Throttle_FullLowerBound     value=N/A
    ${param52} =     Create Dictionary    category=Throttle threshold values    key=ThrottleCalibrationParams_Throttle_FullUpperBound     value=N/A  
    ${param53} =     Create Dictionary    category=Throttle threshold values    key=ThrottleCalibrationParams_Throttle_ReleaseLowerBound  value=N/A  
    ${param54} =     Create Dictionary    category=Throttle threshold values    key=ThrottleCalibrationParams_Throttle_ReleaseUpperBound  value=N/A
    ${param55} =     Create Dictionary    category=Throttle threshold values    key=ThrottleCalibrationParams_Throttle_LowOffset          value=N/A 
    # for AX
    ${param61} =     Create Dictionary    category=Throttle threshold values    key=ThrottleCalibrationParams_Throttle0_FullLowerBound       value=N/A
    ${param62} =     Create Dictionary    category=Throttle threshold values    key=ThrottleCalibrationParams_Throttle0_FullUpperBound       value=N/A
    ${param63} =     Create Dictionary    category=Throttle threshold values    key=ThrottleCalibrationParams_Throttle0_ReleaseLowerBound    value=N/A  
    ${param64} =     Create Dictionary    category=Throttle threshold values    key=ThrottleCalibrationParams_Throttle0_ReleaseUpperBound    value=N/A  
    ${param65} =     Create Dictionary    category=Throttle threshold values    key=ThrottleCalibrationParams_Throttle0_LowOffset            value=N/A  
    ${param66} =     Create Dictionary    category=Throttle threshold values    key=ThrottleCalibrationParams_Throttle1_FullLowerBound       value=N/A
    ${param67} =     Create Dictionary    category=Throttle threshold values    key=ThrottleCalibrationParams_Throttle1_FullUpperBound       value=N/A
    ${param68} =     Create Dictionary    category=Throttle threshold values    key=ThrottleCalibrationParams_Throttle1_ReleaseLowerBound    value=N/A
    ${param69} =     Create Dictionary    category=Throttle threshold values    key=ThrottleCalibrationParams_Throttle1_ReleaseUpperBound    value=N/A 
    ${params_throttle_threshold_values} =    Create List    ${param51}  ${param52}  ${param53}  ${param54}  ${param55}
                                                     ...    ${param61}  ${param62}  ${param63}  ${param64}  ${param65}  ${param66}  ${param67}  ${param68}  ${param69}
    Set Test Variable    ${params_throttle_threshold_values}

Set WinkerDiag
    ${param71} =    Create Dictionary    category=WinkerDiag    key=LightCalibrationParams_LeftWinkerLight_LowerBound    value=N/A
    ${param72} =    Create Dictionary    category=WinkerDiag    key=LightCalibrationParams_LeftWinkerLight_UpperBound    value=N/A 
    ${param73} =    Create Dictionary    category=WinkerDiag    key=LightCalibrationParams_RightWinkerLight_LowerBound   value=N/A  
    ${param74} =    Create Dictionary    category=WinkerDiag    key=LightCalibrationParams_RightWinkerLight_UpperBound   value=N/A
    ${params_WinkerDiag} =    Create List    ${param71}  ${param72}  ${param73}  ${param74}
    Set Test Variable    ${params_WinkerDiag}

Set GDS
    ${param81} =     Create Dictionary     category=GDS    key=PowerID                    value=N/A
    ${param82} =     Create Dictionary     category=GDS    key=GearRatio                  value=N/A 
    ${param83} =     Create Dictionary     category=GDS    key=HasKeyfob                  value=N/A 
    ${param84} =     Create Dictionary     category=GDS    key=IsSupportNFC               value=N/A    
    ${param85} =     Create Dictionary     category=GDS    key=ModelSeries                value=N/A   
    ${param86} =     Create Dictionary     category=GDS    key=PartnerCustomizationFlag   value=N/A                
    ${param87} =     Create Dictionary     category=GDS    key=ECUModelId                 value=N/A  
    ${param88} =     Create Dictionary     category=GDS    key=HeadlightDelay             value=N/A      
    ${param89} =     Create Dictionary     category=GDS    key=RegenLevel                 value=N/A  
    ${param8A} =     Create Dictionary     category=GDS    key=TableID                    value=N/A
    ${param8B} =     Create Dictionary     category=GDS    key=HWID                       value=N/A
    ${param8C} =     Create Dictionary     category=GDS    key=ABSParameter               value=N/A    
    ${param8D} =     Create Dictionary     category=GDS    key=DashboardPatternColor      value=N/A             
    ${param8E} =     Create Dictionary     category=GDS    key=MyfGoshareMode             value=N/A      
    ${param8F} =     Create Dictionary     category=GDS    key=OnBoardChargeValue         value=N/A          
    ${param8G} =     Create Dictionary     category=GDS    key=TireSize                   value=N/A
    ${param8H} =     Create Dictionary     category=GDS    key=TmpsPressureLowerBound     value=N/A
    ${params_gds} =    Create List    ${param81}  ${param82}  ${param83}  ${param84}  ${param85}  ${param86}  ${param87}  ${param88}  ${param89}  ${param8A}
                               ...    ${param8B}  ${param8C}  ${param8D}  ${param8E}  ${param8F}  ${param8G}  ${param8H}
    Set Test Variable    ${params_gds}

Set AppFeatures
    ${param91} =    Create Dictionary    category=AppFeatures    key=AppFeatureBits               value=0xFFFE37     
    ${param92} =    Create Dictionary    category=AppFeatures    key=LightPattern                 value=N/A     
    ${param93} =    Create Dictionary    category=AppFeatures    key=SoundPattern                 value=N/A     
    ${param94} =    Create Dictionary    category=AppFeatures    key=BreathingLight               value=N/A       
    ${param95} =    Create Dictionary    category=AppFeatures    key=DashboardNighttimeColor      value=N/A                
    ${param96} =    Create Dictionary    category=AppFeatures    key=Regen                        value=N/A
    ${param97} =    Create Dictionary    category=AppFeatures    key=LowSpeed                     value=N/A
    ${param98} =    Create Dictionary    category=AppFeatures    key=Light                        value=N/A
    ${param99} =    Create Dictionary    category=AppFeatures    key=OverSpeed                    value=N/A  
    ${param9A} =    Create Dictionary    category=AppFeatures    key=TireSize                     value=N/A 
    ${param9B} =    Create Dictionary    category=AppFeatures    key=TurnAssistLight              value=N/A        
    ${param9C} =    Create Dictionary    category=AppFeatures    key=ResumeTrunkState             value=N/A         
    ${param9D} =    Create Dictionary    category=AppFeatures    key=TPMS                         value=N/A
    ${param9E} =    Create Dictionary    category=AppFeatures    key=AutoLockDelay                value=N/A      
    ${param9F} =    Create Dictionary    category=AppFeatures    key=HeadLightButton              value=N/A        
    ${param9G} =    Create Dictionary    category=AppFeatures    key=BT2564                       value=N/A
    ${param9H} =    Create Dictionary    category=AppFeatures    key=KeyFob                       value=N/A
    ${param9I} =    Create Dictionary    category=AppFeatures    key=LightModule                  value=N/A 
    ${param9J} =    Create Dictionary    category=AppFeatures    key=LockUnlock                   value=N/A   
    ${param9K} =    Create Dictionary    category=AppFeatures    key=SecurityBoost                value=N/A     
    ${param9L} =    Create Dictionary    category=AppFeatures    key=OnboardCharger               value=N/A      
    ${param9M} =    Create Dictionary    category=AppFeatures    key=EfficiencyControl            value=N/A          
    ${param9N} =    Create Dictionary    category=AppFeatures    key=Proximity                    value=N/A  
    ${param9O} =    Create Dictionary    category=AppFeatures    key=CoPilot                      value=N/A
    ${param9P} =    Create Dictionary    category=AppFeatures    key=FindMyScooter                value=N/A      
    ${param9Q} =    Create Dictionary    category=AppFeatures    key=TimeBasedSilentMode          value=N/A            
    ${param9R} =    Create Dictionary    category=AppFeatures    key=EnhanceSafetyNotification    value=N/A
    ${params_app_features} =    Create List    ${param91}  ${param92}  ${param93}  ${param94}  ${param95}  ${param96}  ${param97}  ${param98}  ${param99}  ${param9A}
                                        ...    ${param9B}  ${param9C}  ${param9D}  ${param9E}  ${param9F}  ${param9G}  ${param9H}  ${param9I}  ${param9J}  ${param9K}
                                        ...    ${param9L}  ${param9M}  ${param9N}  ${param9O}  ${param9P}  ${param9Q}  ${param9R}
    Set Test Variable    ${params_app_features}

Setup Params
    Set Firmware ID
    Set Initial Shipping Firmware Ver for GDS
    Set Front Lights threshold values
    Set Tail Lights threshold values
    Set Throttle threshold values
    Set WinkerDiag
    Set GDS
    Set AppFeatures
    ${params} =    Combine Lists    ${params_firmware_id}    
                             ...    ${params_initial_shipping_firmware_ver_for_GDS}
                             ...    ${params_front_lights_threshold_values}
                             ...    ${params_tail_lights_threshold_values}
                             ...    ${params_throttle_threshold_values}
                             ...    ${params_WinkerDiag}
                             ...    ${params_gds}
                             ...    ${params_app_features}
    Set Test Variable    ${params}
    