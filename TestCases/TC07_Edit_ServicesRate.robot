*** Settings ***
Library        SeleniumLibrary
Library        ExcelLibrary
Library        Collections
Library        ScreenCapLibrary

*** Test Cases ***
TC07
    Begin Webpage
    #อัดวีดีโอ ค่อยเปิดตอนจะอัดจริงๆ
    # Start Video Recording    name=C:/Users/Admin/Desktop/Testdata/TC07_EditServicesRate  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    C:/Users/Admin/Desktop/Testdata/TC07_EditServicesRate.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status}    Set Variable If    "${excel.cell(${i},2).value}" == "None"    ${EMPTY}    ${excel.cell(${i},2).value}
        IF    "${status}" == "Y"
            ${tdid}        Set Variable If    "${excel.cell(${i},1).value}" == "None"    ${EMPTY}    ${excel.cell(${i},1).value}    
            Log To Console   ${tdid}
            ${button}    Set Variable If    "${excel.cell(${i},3).value}" == "None"    ${EMPTY}    ${excel.cell(${i},3).value}
            ${serviceName}    Set Variable If    "${excel.cell(${i},4).value}" == "None"    ${EMPTY}    ${excel.cell(${i},4).value}
            ${serviceCost}    Set Variable If    "${excel.cell(${i},5).value}" == "None"    ${EMPTY}    ${excel.cell(${i},5).value}
            ${EXP}         Set Variable       ${excel.cell(${i},6).value}
 
            # ${Error}       Set Variable if    '${Status}' == 'FAIL'    No Error    Error    
            # ${Suggestion}       Set Variable if    '${Error}' == 'Error' or '${Status}' == 'FAIL'       ควรมีการแจ้งเตือนให้ผู้ใช้งาน "${eclin.cell(${i},6).value}"     -
            Begin Webpage
            Click Element    //a[contains(text(),'Login')]
            Input Text    //input[@id='username']    Emp03
            Input Text    //input[@id='password']    123456
            Sleep    5s
            Click Button    //button[contains(text(),'Login')]
            Click Element    //a[contains(text(),'รายการบริการ')]
            # คลิกรายการที่จะแก้ไข
            
                Click Element    (//a[@class="btn btn-info"])[${button}]
                Input Text    //input[@id='serviceName']    ${serviceName}
                Input Text    //input[@id='serviceCost']    ${serviceCost}
                Sleep    5s
                Click Button    //button[contains(text(),'แก้ไขบริการ')]
                
                ${ACTUAL_RESULT}    Get Text    //h2[contains(text(),'รายการบริการ')]  #เช็คerorr

                IF    "${ACTUAL_RESULT}" == "${EXP}"
                    Write Excel Cell    ${i}    7    value= ${ACTUAL_RESULT}    sheet_name=TestData
                    Write Excel Cell    ${i}    8    value=PASS    sheet_name=TestData
                    Write Excel Cell    ${i}    9    value=No Error    sheet_name=TestData
                    Write Excel Cell    ${i}    10   value= -    sheet_name=TestData

                ELSE
                    Take Screenshot    name=C:/Users/Admin/Desktop/PicErorr/TC07_Edit_ServicesRate${tdid}_Fail.png
                    Write Excel Cell    ${i}    7    value= ${ACTUAL_RESULT}    sheet_name=TestData
                    Write Excel Cell    ${i}    8    value=FAIL    sheet_name=TestData
                    Write Excel Cell    ${i}    9    value=Error   sheet_name=TestData
                    Write Excel Cell    ${i}    10   value=ควรแจ้งเตือนผู้ใช้ว่า"${EXP}"    sheet_name=TestData
                END
          Sleep    5s
            Close All Browsers
        END
    END
    Save Excel Document    C:/Users/Admin/Desktop/ResultsData/TD07_EditServicesRate.xlsx
    # Stop Video Recording

*** Keywords ***
Begin Webpage
    Open Browser            http://localhost:8081/CoffeeProject/openHome      chrome    executable_path=D:/chromedriver.exe
    Maximize Browser Window
    