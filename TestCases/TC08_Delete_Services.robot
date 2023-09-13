*** Settings ***
Library        SeleniumLibrary
Library        ExcelLibrary
Library        Collections
Library        ScreenCapLibrary

*** Test Cases ***
TC08
    Begin Webpage
    # Start Video Recording    C:/Users/Admin/Desktop/Testdata/DeleteServices  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    C:/Users/Admin/Desktop/Testdata/DeleteServices.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status}    Set Variable If    "${excel.cell(${i},2).value}" == "None"    ${EMPTY}    ${excel.cell(${i},2).value}
        IF    "${status}" == "Y"
            ${tdid}        Set Variable If    "${excel.cell(${i},1).value}" == "None"    ${EMPTY}    ${excel.cell(${i},1).value}    
            Log To Console   ${tdid}
            ${user}        Set Variable If    "${excel.cell(${i},3).value}" == "None"    ${EMPTY}    ${excel.cell(${i},3).value}
            ${pass}        Set Variable If    "${excel.cell(${i},4).value}" == "None"    ${EMPTY}    ${excel.cell(${i},4).value}
            # ${delete}        Set Variable If    "${excel.cell(${i},5).value}" == "None"    ${EMPTY}    ${excel.cell(${i},5).value}
            ${EXP}         Set Variable       ${excel.cell(${i},6).value}
            
            Click Element    //a[contains(text(),'Login')]
            Input Text    //input[@id='username']    ${user}
            Input Text    //input[@id='password']    ${pass}
            Sleep    4s
            Click Button    //button[contains(text(),'Login')]
            Click Element    //a[contains(text(),'รายการบริการ')]

            # ต่อ!!!!!!ยังไม่เสร็จสมบูรณ์
            
        ${ACTUAL_RESULT}    Get Text    //h2[contains(text(),'Roaster Information')]  #เช็คerorr

            IF    "${ACTUAL_RESULT}" == "${EXP}"
                Write Excel Cell    ${i}    6    value=PASS    sheet_name=TestData
            ELSE
                Take Screenshot    C:/Users/Admin/Desktop/${tdid}_Fail.png
                Write Excel Cell    ${i}    6    value=FAIL    sheet_name=TestData
                Write Excel Cell    ${i}    7    value=${ACTUAL_RESULT}    sheet_name=TestData
            END

            Sleep    5s
        END
    END
    Close All Browsers
    Save Excel Document    C:/Users/Admin/Desktop/TC08_DeleteServices.xlsx
    # Stop Video Recording

*** Keywords ***
Begin Webpage
    Open Browser            http://localhost:8081/CoffeeProject/openHome      chrome    executable_path=D:/chromedriver.exe
    Maximize Browser Window