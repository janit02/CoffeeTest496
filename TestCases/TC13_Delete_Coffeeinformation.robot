*** Settings ***
Library        SeleniumLibrary
Library        ExcelLibrary
Library        Collections
Library        ScreenCapLibrary

*** Test Cases ***
TC13
    Begin Webpage
    # Start Video Recording    name=C:/Users/Admin/Desktop/Testdata/TC13_DeleteCoffeeInformation  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    C:/Users/Admin/Desktop/TestdataTC13_DeleteCoffeeInformation.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status}    Set Variable If    "${excel.cell(${i},2).value}" == "None"    ${EMPTY}    ${excel.cell(${i},2).value}
        IF    "${status}" == "Y"
            ${tdid}        Set Variable If    "${excel.cell(${i},1).value}" == "None"    ${EMPTY}    ${excel.cell(${i},1).value}    
            Log To Console   ${tdid}
            ${Delete}        Set Variable If    "${excel.cell(${i},3).value}" == "None"    ${EMPTY}    ${excel.cell(${i},3).value}
            # ${Error}       Set Variable if    '${get_message}' == '${text_not_alert}'      Not Found Alert         No Error
            # ${Suggestion}       Set Variable if    '${Error}' == 'Not Found Alert'      ควรมีการแจ้งเตือนให้ผู้ใช้งาน "${eclin.cell(${i},3).value}" 
            ${EXP}         Set Variable       ${excel.cell(${i},4).value}
            
            # Delete
            # (//td/a[@class="btn btn-danger"])[1]
            # (//td/a[@class="btn btn-danger"])[2]
            # (//td/a[@class="btn btn-danger"])[3]

            Click Element    //a[contains(text(),'Login')]
            Input Text    //input[@id='username']    Emp03
            Input Text    //input[@id='password']    123456
            Sleep    5s  
            Click Button    //button[contains(text(),'Login')]  
            Click Element    //a[contains(text(),'รายการกาแฟ')]
            Click Element    (//td/a[@class="btn btn-danger"])    ${Delete}
            
            # IF     ${i} == 2
            #      Remove News Page
            #  ELSE
            #     Cancel News
            #  END

            # Click Button    //a[contains(text(),'Delete')] !!!!!

            # เหลือดึงค่าลิงค์หน้ามาเช็ค
            
            # ${ACTUAL_RESULT}    Get Text    //h2[contains(text(),'Roaster Information')]  #เช็คerorr

            # IF    "${ACTUAL_RESULT}" == "${EXP}"
            #     Write Excel Cell    ${i}    11    value=PASS    sheet_name=TestData
            # ELSE
            #     Take Screenshot    C:/Users/Admin/Desktop/${tdid}_Fail.png
            #     Write Excel Cell    ${i}    11    value=FAIL    sheet_name=TestData
            #     Write Excel Cell    ${i}    12    value=${ACTUAL_RESULT}    sheet_name=TestData
            # END

            Sleep    5s
        END
    END
    Close All Browsers
    Save Excel Document    C:/Users/Admin/Desktop/ResultsData/TD13_DeleteCoffeeInformation.xlsx
    # Stop Video Recording

*** Keywords ***
Begin Webpage
    Open Browser            http://localhost:8081/CoffeeProject/openHome      chrome    executable_path=D:/chromedriver.exe
    Maximize Browser Window


