*** Settings ***
Documentation    Test suite of pairing warehouse setting
Resource    ../init.robot
Force Tags    SalesPortal
Suite Setup    Suite Setup
Suite Teardown    Close All Browsers
Test Setup    Test Setup
Test Teardown    Click Gogoro Logo
Test Timeout    ${TEST_TIMEOUT}

*** Variables ***
${PAIRING_GROUP_ADMIN}    QA00006
${PAIRING_GROUP_PASS}    Temp4321

*** Test Cases ***
Area and belong and store search result
    [Tags]    CID:9943
    [Template]    Verify Area And Belong And Store Search Result
    北    Gogoro門市                    土城裕民店
    北    Gogoro門市                    中壢復興店
    北    Gogoro門市                    新竹北大店
    北    Gogoro門市                    松山饒河店
    北    Gogoro門市                    板橋館前店
    北    Gogoro門市                    新莊幸福店
    北    Gogoro門市                    南崁中正店
    北    Gogoro門市                    師大和平店
    北    Gogoro門市                    桃園藝文店
    北    Gogoro門市                    松山 Citylink 店
    北    Gogoro門市                    永和中正店
    北    Gogoro門市                    內湖CityLink店
    北    Gogoro門市                    士林文林店
    北    Gogoro門市                    光華八德店
    北    Gogoro門市                    萬華中華店
    北    Gogoro門市                    桃園八德店
    北    Gogoro門市                    三重正義店
    北    Gogoro門市                    桃園中正店
    北    Gogoro門市                    圓山承德店
    北    服務中心                      新莊中正服務中心
    北    服務中心                      桃園復興服務中心
    北    服務中心                      基隆忠二服務中心
    北    服務中心                      土城明德服務中心
    北    服務中心                      頭份自強服務中心
    北    服務中心                      蘆洲三民服務中心
    北    服務中心                      內湖民權服務中心
    北    交車中心                      板橋廣權交車中心
    北    交車中心                      新竹林森交車中心
    北    交車中心                      平鎮延平交車中心
    北    交車中心                      北桃永安交車中心
    中    Gogoro門市                    台中中港門市
    中    Gogoro門市                    台中三民店
    中    Gogoro門市                    豐原中正店
    中    Gogoro門市                    大里東榮店
    中    服務中心                      大里德芳服務中心
    中    服務中心                      豐原中山服務中心
    中    服務中心                      台中柳川服務中心
    中    交車中心                      台中站前交車中心
    南    Gogoro門市                    左營博愛店
    南    Gogoro門市                    高雄岡山店
    南    Gogoro門市                    永康中華店
    南    Gogoro門市                    鳳山青年店
    南    Gogoro門市                    台南公園店
    南    Gogoro門市                    高雄中山店
    南    服務中心                      永康中山南服務中心
    南    交車中心                      高雄中正交車中心
    東    榮江股份有限公司新月綠能分公司    宜蘭中山店
    東    榮江股份有限公司新月綠能分公司    宜蘭新月店
    東    茁壯創能股份有限公司            台東新生門市
    東    長乘有限公司                   羅東中正店
    東    花蓮綠動車業                   花蓮中華店

Area and store search result
    [Tags]    CID:9944
    [Template]    Verify Area And Store Search Result
    北    新店民權店
    北    基隆義一門市
    北    文山木新門市
    北    新莊中正服務中心
    北    桃園復興服務中心
    北    基隆忠二服務中心
    北    土城明德服務中心
    北    頭份自強服務中心
    北    蘆洲三民服務中心
    北    內湖民權服務中心
    北    板橋廣權交車中心
    北    新竹林森交車中心
    北    平鎮延平交車中心
    北    北桃永安交車中心
    北    三重集成廠
    北    中和員山店
    北    三重集賢店
    北    泰山明志店
    北    文山木新店
    北    天母忠誠店
    北    淡水鼻頭門市
    北    樹林三俊店
    北    三峽復興店
    北    中壢復興店
    北    新竹北大店
    北    松山饒河店
    北    板橋館前店
    北    新莊幸福店
    北    南崁中正店
    北    師大和平店
    北    桃園藝文店
    北    松山 Citylink 店
    北    永和中正店
    北    內湖CityLink店
    北    土城裕民店
    北    士林文林店
    北    光華八德店
    北    萬華中華店
    北    桃園八德店
    北    三重正義店
    北    桃園中正店
    北    圓山承德店
    北    新竹東勝門市
    北    竹北中正東店
    北    龍潭中正門市
    北    新豐學府門市
    北    中壢環中東店
    北    頭份自強門市
    中    台中中港門市
    中    鹿港民族門市
    中    員林中山店
    中    台中三民店
    中    豐原中正店
    中    大里東榮店
    中    斗六明德北店
    中    虎尾光復門市
    中    彰化中山店
    中    南區建成店
    中    大里德芳服務中心
    中    豐原中山服務中心
    中    台中柳川服務中心
    中    南屯五權西門市
    中    北屯中清店
    中    西區英才店
    中    東勢豐勢門市
    中    台中站前交車中心
    中    太平樹德店
    中    沙鹿中山門市
    中    草屯太平店
    南    左營博愛店
    南    高雄岡山店
    南    永康中華店
    南    鳳山青年店
    南    台南公園店
    南    高雄中山店
    南    永康中山南服務中心
    南    三民九如二店
    南    鳳山五甲店
    南    嘉義興業東店
    南    朴子山通店
    南    馬公同和門市
    南    安南安和店
    南    善化大成店
    南    高雄中正交車中心
    南    安平中華店
    南    東區崇德店
    南    台南新營店
    南    小港漢民店
    南    屏東公園店
    南    茁壯交車中心
    南    楠梓益群店
    南    屏東潮州店
    南    三民建工店
    南    東港光復店
    南    鼓山青海店
    南    苓雅三多店
    南    仁武仁雄店
    東    宜蘭中山店
    東    宜蘭新月店
    東    台東新生門市
    東    羅東中正店
    東    花蓮中華店

Search of store
    [Tags]    CID:9937
    Input Text For Store Name    土城裕民店
    Verify Store Filter    土城裕民店

*** Keywords ***
Suite Setup
    Login With Direct Login    ${PAIRING_GROUP_ADMIN}    ${PAIRING_GROUP_PASS}

Test Setup
    Click First Layer Item In Menu    /allocations
    Click Second Layer Item In Menu    /allocations/warehouses
    Verify Page URL    ${SALES_PORTAL_URL}/allocations/warehouses

Test Teardown Remove Pairing Setting
    Remove Pairing Belong
    Remove Pairing Area
    Remove Text For Store Name

Verify Area And Belong And Store Search Result
    [Arguments]    ${area}    ${belong}    ${store}
    Select Pairing Area    ${area}
    Select Pairing Belong    ${belong}
    Input Text For Store Name  ${store}
    Verify Store Filter    ${store}
    [Teardown]    Test Teardown Remove Pairing Setting

Verify Area And Store Search Result
    [Arguments]    ${area}    ${store}
    Select Pairing Area    ${area}
    Input Text For Store Name    ${store}
    Verify Store Filter    ${store}
