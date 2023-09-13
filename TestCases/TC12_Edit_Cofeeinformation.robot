*** Settings ***
Library        SeleniumLibrary
Library        ExcelLibrary
Library        Collections
Library        ScreenCapLibrary
Library        DateTime

*** Test Cases ***
TC12
    #อัดวีดีโอ ค่อยเปิดตอนจะอัดจริงๆ
    # Start Video Recording    name=D:/TestCoffee496/Testdata/EditCoffeeInformaion  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    D:/TestCoffee496/Testdata/EditCoffeeInformaion.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status}    Set Variable If    "${excel.cell(${i},2).value}" == "None"    ${EMPTY}    ${excel.cell(${i},2).value}
        IF    "${status}" == "Y"
            ${tdid}        Set Variable If    "${excel.cell(${i},1).value}" == "None"    ${EMPTY}    ${excel.cell(${i},1).value}    
            Log To Console   ${tdid}
            ${selectedit}    Set Variable If    "${excel.cell(${i},3).value}" == "None"    ${EMPTY}    ${excel.cell(${i},3).value}
            ${coffeename}    Set Variable If    "${excel.cell(${i},4).value}" == "None"    ${EMPTY}    ${excel.cell(${i},4).value}
            ${codeName}      Set Variable If    "${excel.cell(${i},5).value}" == "None"    ${EMPTY}    ${excel.cell(${i},5).value}
            ${coffeeLocation}    Set Variable If    "${excel.cell(${i},6).value}" == "None"    ${EMPTY}    ${excel.cell(${i},6).value}
            ${coffeeDetail}    Set Variable If    "${excel.cell(${i},7).value}" == "None"    ${EMPTY}    ${excel.cell(${i},7).value}
            ${stockCoffee}    Set Variable If    "${excel.cell(${i},8).value}" == "None"    ${EMPTY}    ${excel.cell(${i},8).value}
            ${stockDate}    Set Variable If    "${excel.cell(${i},9).value}" == "None"    ${EMPTY}    ${excel.cell(${i},9).value}
            ${EXP}         Set Variable       ${excel.cell(${i},10).value}
            
            Begin Webpage
            Click Element    //a[contains(text(),'Login')]
            Input Text    //input[@id='username']    Emp03
            Input Text    //input[@id='password']    123456
            Sleep    5s
            Click Button    //button[contains(text(),'Login')]

            Click Element    //a[contains(text(),'รายการกาแฟ')]
            Click Element    (//a[@class="btn btn-info"])[${selectedit}]
            Input Text    //input[@id='coffeename']    ${coffeename} 
            Input Text    //input[@id='codeName']    ${codeName}
            Input Text    //input[@id='coffeeLocation']    ${coffeeLocation}
            Input Text    //textarea[@id='coffeeDetail']    ${coffeeDetail}
            Input Text    //input[@id='stockCoffee']    ${stockCoffee}
            Input Text    //input[@id='stockDate']    ${stockDate}
            # เหลือ Input Date
            Sleep    5s
            Click Button    //button[contains(text(),'แก้ไขกาแฟ')]    
            # ต่อยังไม่เสร็จ    
            
            
        
           
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
    Save Excel Document    D:/TestCoffee496/ResultsData/TC12_EditCoffeeinformaion.xlsx
    # Stop Video Recording

*** Keywords ***
Begin Webpage
    Open Browser            http://localhost:8081/CoffeeProject/openHome      chrome    executable_path=D:/chromedriver.exe
    Maximize Browser Window