*** Settings ***
Library        SeleniumLibrary
Library        ExcelLibrary
Library        Collections
Library        ScreenCapLibrary

*** Test Cases ***
TC01
    
    # Start Video Recording    name=C:/Users/Admin/Desktop/Testdata/TC01_Login  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    C:/Users/Admin/Desktop/Testdata/TC01_Login.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${Execute}    Set Variable If    "${excel.cell(${i},2).value}" == "None"    ${EMPTY}    ${excel.cell(${i},2).value}
        IF    "${Execute}" == "Y"
            ${tdid}        Set Variable If    "${excel.cell(${i},1).value}" == "None"    ${EMPTY}    ${excel.cell(${i},1).value}    
            Log To Console   ${tdid}
            ${user}        Set Variable If    "${excel.cell(${i},3).value}" == "None"    ${EMPTY}    ${excel.cell(${i},3).value}
            ${pass}        Set Variable If    "${excel.cell(${i},4).value}" == "None"    ${EMPTY}    ${excel.cell(${i},4).value}
            ${status}      Set Variable If    "${excel.cell(${i},5).value}" == "None"    ${EMPTY}    ${excel.cell(${i},5).value}
            ${EXP}         Set Variable       ${excel.cell(${i},6).value}
            
            # ${Error}       Set Variable if    '${status}' == 'FAIL'      Error         No Error
            # ${Suggestion}    Set Variable if    '${Error}' == 'Not Found Alert' or '${Status}' == 'FAIL'      ควรมีการแจ้งเตือนให้ผู้ใช้งาน "${excel.cell(${i},6).value}"    -

            Begin Webpage
            Click Element    //a[contains(text(),'Login')]
            Sleep    3s
            Input Text    //input[@id='username']    ${user}
            Input Text    //input[@id='password']    ${pass}
            Sleep    3s
            Click Button    //button[contains(text(),'Login')]
            # Sleep    3s
            
            IF  "${status}" == "User"
            
            ${ACTUAL_RESULT}    Get Text    //a[@id='navbardrop']

            ELSE IF  "${status}" == "Admin"

                ${ACTUAL_RESULT}    Get Text    //a[contains(text(),'เพิ่มพนักงาน')]
            
            ELSE IF  "${status}" == "Emp"

                ${ACTUAL_RESULT}    Get Text    //a[contains(text(),'รายการกาแฟ')] 
            
            ELSE IF  "${status}" == "NS"

                ${ACTUAL_RESULT}    Set Variable    โปรดกรอกฟิลด์นี้
            
            ELSE IF  "${status}" == "NP"

                ${ACTUAL_RESULT}    Set Variable    โปรดกรอกฟิลด์นี้  
            ELSE 
                ${ACTUAL_RESULT}    Get Text    //label[contains(text(),'username หรือ Password ไม่ตรงกัน')]  
            END

            IF    "${ACTUAL_RESULT}" == "${EXP}"
                Write Excel Cell    ${i}    7    value= ${ACTUAL_RESULT}    sheet_name=TestData
                Write Excel Cell    ${i}    8   value=PASS    sheet_name=TestData
                Write Excel Cell    ${i}    9    value=No Error    sheet_name=TestData
                Write Excel Cell    ${i}    10    value= -    sheet_name=TestData

            ELSE
                Take Screenshot    name=C:/Users/Admin/Desktop/PicErorr/TC01_Login${tdid}_Fail.png
                Write Excel Cell    ${i}    7    value=${ACTUAL_RESULT}    sheet_name=TestData
                Write Excel Cell    ${i}    8    value=FAIL    sheet_name=TestData
                Write Excel Cell    ${i}    9    value=Error   sheet_name=TestData
                Write Excel Cell    ${i}    10    value=ควรแจ้งเตือนให้ผู้ใช้ว่า"${EXP}"    sheet_name=TestData
            END
            # Close All Browsers
            Sleep    5s
                
        END
    END
    
    Save Excel Document    C:/Users/Admin/Desktop/ResultsData/TD01_Login_Result3.xlsx
    # Stop Video Recording
    

*** Keywords ***
Begin Webpage
    Open Browser            http://localhost:8081/CoffeeProject/openHome      chrome    executable_path=D:/chromedriver.exe

    Maximize Browser Window