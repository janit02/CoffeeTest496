*** Settings ***
Library        SeleniumLibrary
Library        ExcelLibrary
Library        Collections
Library        ScreenCapLibrary

*** Test Cases ***
TC13
    # Start Video Recording    name=D:/TestCoffee496/Testdata/TC13_DeleteCoffeeInformation  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    D:/TestCoffee496/Testdata/TC13_DeleteCoffeeInformation.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status}    Set Variable If    "${excel.cell(${i},2).value}" == "None"    ${EMPTY}    ${excel.cell(${i},2).value}
        IF    "${status}" == "Y"
            ${tdid}            Set Variable If    "${excel.cell(${i},1).value}" == "None"    ${EMPTY}    ${excel.cell(${i},1).value}    
            Log To Console   ${tdid}
            ${DeleteCoffee}    Set Variable If    "${excel.cell(${i},3).value}" == "None"    ${EMPTY}    ${excel.cell(${i},3).value}
            ${EXP}             Set Variable       ${excel.cell(${i},4).value}
        
            Begin Webpage
            Click Element    //a[contains(text(),'Login')]
            Input Text    //input[@id='username']    Emp03
            Input Text    //input[@id='password']    123456
            Sleep    3s  
            Click Button    //button[contains(text(),'Login')]  
            Click Element    //a[contains(text(),'รายการกาแฟ')]
            Sleep    3s 
            # Delete start Button 2
            Click Element    (//a[@class="btn btn-danger"])[${DeleteCoffee}]   
            
            ${ACTUAL_RESULT}    Get Text    //h2[contains(text(),'รายการกาแฟ')]  #เช็คerorr

                IF    "${ACTUAL_RESULT}" == "${EXP}"
                    Write Excel Cell    ${i}    5    value= ${ACTUAL_RESULT}    sheet_name=TestData
                    Write Excel Cell    ${i}    6    value=PASS    sheet_name=TestData
                    Write Excel Cell    ${i}    8    value=No Error    sheet_name=TestData
                    Write Excel Cell    ${i}    9   value= -    sheet_name=TestData

                ELSE
                    Take Screenshot    name=C:/Users/Admin/Desktop/PicErorr/TC07_Edit_ServicesRate${tdid}_Fail.png
                    Write Excel Cell    ${i}    5    value= ${ACTUAL_RESULT}    sheet_name=TestData
                    Write Excel Cell    ${i}    6    value=FAIL    sheet_name=TestData
                    Write Excel Cell    ${i}    8    value=Error   sheet_name=TestData
                    Write Excel Cell    ${i}    9   value=ควรแจ้งเตือนผู้ใช้ว่า"${EXP}"    sheet_name=TestData
                END


            Sleep    5s
        END
    END
    Close All Browsers
    Save Excel Document    D:/TestCoffee496/ResultsData/TD13_DeleteCoffee_Result.xlsx
    # Stop Video Recording

*** Keywords ***
Begin Webpage
    Open Browser            http://localhost:8081/CoffeeProject/openHome      chrome    executable_path=D:/chromedriver.exe
    Maximize Browser Window


